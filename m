Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269645AbRIMUDc>; Thu, 13 Sep 2001 16:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272056AbRIMUDX>; Thu, 13 Sep 2001 16:03:23 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:55569 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S269645AbRIMUDK>; Thu, 13 Sep 2001 16:03:10 -0400
Date: Thu, 13 Sep 2001 22:03:26 +0200
From: Pavel Machek <pavel@suse.cz>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Pavel Machek <pavel@suse.cz>, Edgar Toernig <froese@gmx.de>,
        linux-kernel@vger.kernel.org, vojtech@ucw.cz,
        Hamera Erik <HAMERAE@cs.felk.cvut.cz>
Subject: Re: Booting linux using Novell NetWare Remote Program Loader
Message-ID: <20010913220326.H6820@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20010909220921.A19145@bug.ucw.cz> <20010909170206.A3245@redhat.com> <20010909230920.A23392@atrey.karlin.mff.cuni.cz> <9nh5p0$3qt$1@cesium.transmeta.com> <20010911005318.C822@bug.ucw.cz> <3BA04514.D65EDF98@gmx.de> <20010913120706.C25204@atrey.karlin.mff.cuni.cz> <3BA0D2BA.8B972B51@gmx.de> <20010913215617.E6820@atrey.karlin.mff.cuni.cz> <3BA10FFA.1050204@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <3BA10FFA.1050204@zytor.com>; from hpa@zytor.com on Thu, Sep 13, 2001 at 12:58:50PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>>>I removed the autoprobing from bootsect.S and fixed it to 1.44MB format
> >>>>et voila, it worked perfectly.
> >>>>
> >>>Do you have patch to do that?
> >>>
> >>I have a patch for 2.0.x only.  But it should be enough to change the
> >>disksizes table at the end of bootsect.S to:
> >>
> >>disksizes: .byte 18,18,18,18
> >>
> > 
> > Yep, tried that. No more crc errors when decompressing. Instead,
> > sudden reboot when it finishes loading. OOps.
> > 
> > This is 486sx/25 booting from network. Kernel is 2.4.9, compiled with
> > math emu, and processor=386.  Any ideas what is wrong?
> > 								Pavel
> 
> 
> Am I guessing correctly that this RPL thing is a floppy image emulator?
> Then it probably becomes a matter of where that image lives (in memory, if
> so where; or on the network and downloaded sector by sector.)  You may
> want to try to make a SYSLINUX image and see if it works.

Yep, it is floppy image emulator. People are telling me it is
downloaded sector by sector. Do you have some "sure to boot" floppy
image somewhere on ftp?
								Pavel
-- 
The best software in life is free (not shareware)!		Pavel
GCM d? s-: !g p?:+ au- a--@ w+ v- C++@ UL+++ L++ N++ E++ W--- M- Y- R+
