Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964983AbVLFVDE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964983AbVLFVDE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 16:03:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965035AbVLFVDE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 16:03:04 -0500
Received: from mx1.redhat.com ([66.187.233.31]:30661 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964983AbVLFVDB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 16:03:01 -0500
Date: Tue, 6 Dec 2005 13:02:07 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, ehabkost@mandriva.com,
       zaitcev@redhat.com
Subject: Re: [PATCH 00/10] usb-serial: Switches from spin lock to atomic_t.
Message-Id: <20051206130207.7658636e.zaitcev@redhat.com>
In-Reply-To: <20051206181449.11947f4f.lcapitulino@mandriva.com.br>
References: <20051206095610.29def5e7.lcapitulino@mandriva.com.br>
	<20051206194041.GA22890@suse.de>
	<20051206181449.11947f4f.lcapitulino@mandriva.com.br>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.7; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Dec 2005 18:14:49 -0200, Luiz Fernando Capitulino <lcapitulino@mandriva.com.br> wrote:

>  The spinlock makes the code less clear, error prone, and we already a
> semaphore in the struct usb_serial_port.
> 
>  The spinlocks _seems_ useless to me.

Dude, semaphores are not compatible with interrupts. Surely you
understand that?

-- Pete
