Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315919AbSGARXS>; Mon, 1 Jul 2002 13:23:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315921AbSGARXR>; Mon, 1 Jul 2002 13:23:17 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:64799 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S315919AbSGARXQ>; Mon, 1 Jul 2002 13:23:16 -0400
Date: Mon, 1 Jul 2002 13:25:14 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: Ralph Corderoy <ralph@inputplus.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Happy Hacking Keyboard Lite Mk 2 USB Problems with 2.4.18.
Message-ID: <20020701132514.A17008@devserv.devel.redhat.com>
References: <zaitcev@redhat.com> <200207011647.g61GlNx14474@blake.inputplus.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200207011647.g61GlNx14474@blake.inputplus.co.uk>; from ralph@inputplus.co.uk on Mon, Jul 01, 2002 at 05:47:23PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Mon, 01 Jul 2002 17:47:23 +0100
> From: Ralph Corderoy <ralph@inputplus.co.uk>

> > > My theory is that usbkbd.o doesn't cope with ErrorRollover which is
> > > being generated, unlike hid.o which didn't used to but does now.
> > 
> > I have an idea: remove usbkbd or make it extremely hard for newbies to
> > build (e.g. drop CONFIG_USB_KBD from config.in, so it would need to be
> > added manually if you want usbkbd).
> 
> That doesn't sound too great.
> 
> > At the very minimum I would like to see all distros, and especially
> > SuSE (because of Vojtech) to stop shipping usbkbd.o.
> 
> What I'd like to see, if both hid.o and usbkbd.o can handle a keyboard,
> is that hid.o gets the job.  Then usbkbd.o can stay in config.in and be
> built just in case it's needed.

This is exactly why today's situation is broken. Users (and even
developers) sometimes find that hid does not work. So, they compile
usbkbd and move along. This means that hid never can reach into
certain corner cases, such as the infamous HP keyboard p/n 5184-4708.

-- Pete
