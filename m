Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267638AbUJSVRL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267638AbUJSVRL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 17:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267416AbUJSVPo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 17:15:44 -0400
Received: from gprs214-24.eurotel.cz ([160.218.214.24]:2176 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S269949AbUJSVJZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 17:09:25 -0400
Date: Tue, 19 Oct 2004 23:09:06 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Kendall Bennett <kendallb@scitechsoft.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       fbdev <linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: Generic VESA framebuffer driver and Video card BOOT?
Message-ID: <20041019210906.GB1142@elf.ucw.cz>
References: <416FB275.6425.1C3D985@localhost> <9e4733910410151319159482ce@mail.gmail.com> <416FEB4B.9875.2A1DBFE@localhost> <9e47339104101516027860bb1e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e47339104101516027860bb1e@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > What about non-x86 platforms such as PowerPC and MIPS embedded devices
> > that want video (TiVo type platforms, media players etc). How would these
> > fit into the picture? Would this require the boot loader (ie: U-Boot or
> > whatever) to have the ability to POST the card?
> 
> There is the assumption that whatever BIOS the device has can get up a
> very early console that can output critical error messages before the
> kernel and early user space is loaded. For example the "I can't find
> the kernel" or  "initramfs is missing" error message. This also
> assumes that the BIOS can post whatever display it is using.
> 
> I'm not trying to fix the problem of getting early boot messages out
> of a Mac with an x86 card plugged into it. The card will work after
> early user space initializes. The right way to fix that would be to
> switch to something like LinuxBIOS and build the x86 emulator into
> it.

That still does not solve resume from suspend-to-RAM. We need to post
VGA there. We probably could do it late in userspace... but it makes
debugging resume pretty hard.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
