Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265387AbTLRXQz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 18:16:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265388AbTLRXQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 18:16:55 -0500
Received: from palrel10.hp.com ([156.153.255.245]:44710 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S265387AbTLRXQv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 18:16:51 -0500
Date: Thu, 18 Dec 2003 15:16:50 -0800
To: Andrew Morton <akpm@osdl.org>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.0
Message-ID: <20031218231650.GA828@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote :
> 
> It's actually rather short because I started late.  See below.
> 
> There are also the "must-fix" and "should-fix" lists of items which we have
> identified as still on the 2.6 todo list.  These are at

	Ok, a few updates on my side :

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/must-fix/must-fix-7.txt and
> 
> drivers/net/irda/
> ~~~~~~~~~~~~~~~~~
> 
> o dongle drivers need to be converted to sir-dev

	In (slow) progress ; tekram-sir patches on my web page.

> o irport need to be converted to sir-kthread

	Not done.

> o new drivers (irtty-sir/smsc-ircc2/donauboe) need more testing

	In (slow) progress ; Patch for irtty-sir on my web page.

> o rmk: Refuse IrDA initialisation if sizeof(structures) is incorrect (I'm
>   not sure if we still need this; I think gcc 2.95.3 on ARM shows this
>   problem though.)

	Included in 2.6.0-test1 (file net/irda/irlap.c, line 80)

	Additions :

net/irda/*
~~~~~~~~~~
	o F-timer expiry fix ; patch on my web page
	o IrCOMM disconnect race condition Oops ; todo
	<Those are short term items and under control, so don't need
to go into your todo list>

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/must-fix/should-fix-7.txt
> 
> drivers/net/wireless/
> ~~~~~~~~~~~~~~~~~~~~~
> 
> o get latest orinoco changes from David.

	2.6.0 has the latest stable version (as version 0.14 is still
beta). David may want to comment on his plans.

> o get the latest airo.c fixes from CVS.  This will hopefully fix problems
>   people have reported on the LKML.

	Javier has done a great job, cf. fixes in 2.6.0-final.

> o get HostAP driver in the kernel.

	Todo.

> o get more wireless drivers into the kernel.

	Todo. Atmel Pcmcia done. The release of 2.6.0 will help get
maintainer motivated ;-)

> o The last two drivers mentioned above are held up by firmware issues (see
>   flamewar on LKML a few days ago).  So maybe fixing those firmware issues
>   should be a requirement for 2.6.X, because we can expect more wireless
>   devices to need firmware upload at startup coming to market.

	Done. The Atmel wireless driver in the kernel is using the new
firmware loading infrastructure (as well as other drivers), and distro
are picking up firmare.agent hotplug script.

> drivers/net/
> ~~~~~~~~~~~~
> 
> o davej: Either Wireless network drivers or PCMCIA broke somewhen.  A
>   configuration that worked fine under 2.4 doesn't receive any packets.  Need
>   to look into this more to make sure I don't have any misconfiguration that
>   just 'happened to work' under 2.4

	Please report those bugs to the driver authors with precise
details of setup and issue. Such useless bug report should not be in a
todo list, as it's impossible to act on it.


	I'll probably send you stuff for 2.6.1 when I'll be back from
the hollyday break.

	Have fun...

	Jean

