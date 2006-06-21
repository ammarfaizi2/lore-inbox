Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932238AbWFUQfJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932238AbWFUQfJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 12:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932247AbWFUQfJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 12:35:09 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:60040 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S932240AbWFUQfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 12:35:07 -0400
Date: Wed, 21 Jun 2006 13:35:00 -0300
From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: rmk+lkml@arm.linux.org.uk, gregkh@suse.de, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       zaitcev@redhat.com
Subject: Re: Serial-Core: USB-Serial port current issues.
Message-ID: <20060621133500.18e82511@doriath.conectiva>
In-Reply-To: <20060620193233.15224308.zaitcev@redhat.com>
References: <20060613192829.3f4b7c34@home.brethil>
	<20060614152809.GA17432@flint.arm.linux.org.uk>
	<20060620161134.20c1316e@doriath.conectiva>
	<20060620193233.15224308.zaitcev@redhat.com>
Organization: Mandriva
X-Mailer: Sylpheed-Claws 2.3.1 (GTK+ 2.9.3; i586-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jun 2006 19:32:33 -0700
Pete Zaitcev <zaitcev@redhat.com> wrote:

| On Tue, 20 Jun 2006 16:11:34 -0300, "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br> wrote:
| 
| >  Pete, was it your original idea to completely move from the spinlock
| > to a mutex?
| 
| I thought it was the cleanest solution. But perhaps I miss something.
| I'll look at your reposted patch again, maybe it's all right as it is.

 Actually, that's the best solution from the USB-Serial's POV.

 The problem is that several serial drivers uses the uart_port's
spinlock to implement their own locking, and some of them acquires the
lock in its interrupt handler...

 Sh*t.

-- 
Luiz Fernando N. Capitulino
