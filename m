Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263566AbTEWBA5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 21:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263567AbTEWBA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 21:00:57 -0400
Received: from palrel13.hp.com ([156.153.255.238]:57259 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S263566AbTEWBAy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 21:00:54 -0400
Date: Thu, 22 May 2003 18:13:49 -0700
To: Stian Jordet <liste@jordet.nu>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Martin Diehl <lists@mdiehl.de>
Subject: Re: irtty_sir cannot be unloaded
Message-ID: <20030523011349.GA12195@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20030522233609.GA11706@bougret.hpl.hp.com> <1053652200.709.6.camel@chevrolet.hybel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1053652200.709.6.camel@chevrolet.hybel>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 23, 2003 at 03:10:00AM +0200, Stian Jordet wrote:
> fre, 23.05.2003 kl. 01.36 skrev Jean Tourrilhes: 
> > Stian Jordet wrote :
> > > 
> > > Module irtty_sir cannot be unloaded due to unsafe usage in
> > > include/linux/module.h:456
> > > 
> > > I get this message when trying to use irda with 2.5.x. I know it has
> > > been there for a long time, but since nothing happens
> > 
> > 	This is fixed in the patches I've send to Jeff :
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=105286597418927&w=2
> > 	Just be patient ;-)
> 
> Well, this got rid of the warning :) But actually when I stop irattach
> (using Debian's init-script (/etc/init.d/irda stop)) my computer
> freezes. This works (of course) fine with 2.4.21-rc2. I thought the
> problem was the module unloading, but it seems to be something with
> irattach instead. Sorry about that.

	Disable HotPlug in your kernel and recompile. Various network
people have been notified of this bug, but this is not an easy one.

> It works, but I get lots of weird/ugly/different messages. This is with
> a SonyEricsson P800. Except for those annoying messages in my logs, it
> works perfect :-)
> 
> irlap_change_speed(), setting speed to 9600
> sirdev_open - done, speed = 0
> sirdev_schedule_request - state=0x0700 / param=9600
> sirdev_schedule_request - down
> irda_config_fsm - up

	Yeah, Martin should increase the debug level.

> I see I have gotten a ircomm_tty can't be unloaded as well.

	This has been fixed in the latest BK.

> Hmm. Well,
> as I said, it works perfect, except for stopping irattach.
> 
> Thanks.
> 
> Best regards,
> Stian


	Have fun...

	Jean
