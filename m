Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751224AbWFFQPA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbWFFQPA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 12:15:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbWFFQPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 12:15:00 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:32976 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S1751224AbWFFQO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 12:14:59 -0400
Date: Tue, 6 Jun 2006 13:15:03 -0300
From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg KH <gregkh@suse.de>, Pete Zaitcev <zaitcev@redhat.com>,
       linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk,
       linux-usb-devel@lists.sourceforge.net, rmk+lkml@arm.linux.org.uk
Subject: Re: [PATCH 8/11] usbserial: pl2303: Ports tty functions.
Message-ID: <20060606131503.1f43e9a6@doriath.conectiva>
In-Reply-To: <1149585808.5724.0.camel@localhost.localdomain>
References: <1149217397133-git-send-email-lcapitulino@mandriva.com.br>
	<1149217398434-git-send-email-lcapitulino@mandriva.com.br>
	<20060602205014.GB31251@suse.de>
	<20060602154121.d3f19cbe.zaitcev@redhat.com>
	<20060602224435.GA26061@suse.de>
	<20060603191917.29967d61@home.brethil>
	<20060606073441.GD17682@suse.de>
	<1149585808.5724.0.camel@localhost.localdomain>
Organization: Mandriva
X-Mailer: Sylpheed-Claws 2.2.1 (GTK+ 2.9.1; i586-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 06 Jun 2006 10:23:28 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

| > > | > > >   2. The new pl2303's set_termios() can (still) sleep. Serial Core's
| > > | > > >      documentation says that that method must not sleep, but I couldn't find
| > > | > > >      where in the Serial Core code it's called in atomic context. So, is this
| > > | > > >      still true? Isn't the Serial Core's documentation out of date?
| 
| For the tty layer at least this was fixed to be semaphore locked and I
| think this is now a docs error. It was fixed precisely because the USB
| people couldn't resolve termios setup without sleeping.

 Russell, could you confirm if this is valid for the Serial Core
layer?

-- 
Luiz Fernando N. Capitulino
