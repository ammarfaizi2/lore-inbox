Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265759AbSKBG1f>; Sat, 2 Nov 2002 01:27:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265882AbSKBG1f>; Sat, 2 Nov 2002 01:27:35 -0500
Received: from dp.samba.org ([66.70.73.150]:12262 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265759AbSKBG1d>;
	Sat, 2 Nov 2002 01:27:33 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: karim@opersys.com, torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Rusty's Remarkably Unreliable List of Pending 2.6 Features 
In-reply-to: Your message of "Fri, 01 Nov 2002 11:19:08 CDT."
             <3DC2A97C.D50C02E4@opersys.com> 
Date: Sat, 02 Nov 2002 17:32:54 +1100
Message-Id: <20021102063403.5F0E52C0C3@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3DC2A97C.D50C02E4@opersys.com> you write:
> 
> Rusty Russell wrote:
> > Removed ("vendor-driven" == "no", for purposes of the freeze)
> >         Linux Trace Toolkit: "no"
> 
> I'm not sure exactly why this got a "no" this time around.

"I don't know what this buys us" == "no" AFAICT.

You might surprise me, but it looks like Linus wants more trusted
developers to come running to him going "LTT is really cool, we need
it for XXX".  Of *course* you think it's great, otherwise you wouldn't
work on it.

> For one thing, LTT is certainly not "vendor-driven", I'm not getting
> paid a penny for the work I'm putting in it ;)

You misunderstand.  When Linus says "vendor-driven" he means what
usually happens is that vendors pick it up then the users come back
and convince Linus that it's worth including.

> That's not really the case here. In fact, it's the complete inverse that
> is happening with LTT: Because I'm spending so much time having to deal
> with patch updates, I have much less time to work on the user-space
> analysis tools.

Hey, I feel your pain.  Really: the module rewrite has the same issue,
except I doubt a vendor would pick it up since it breaks compatibility
with standard userspace, and they have enough to worry about.

I've put your patch back in, but I expect Linus will say "Rusty you
fucking idiot, I already said "no" once."

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Key:
A: Author
M: lkml posting describing patch
D: Download URL
S: Size of patch, number of files altered (source/config), number of new files.
X: Impact summary (only parts of patch which alter existing source files, not config/make files)
T: Diffstat of whole patch
N: Random notes

In rough order of invasiveness (number of altered source files):

In-kernel Module Loader and Unified parameter support
A: Rusty Russell
D: http://www.kernel.org/pub/linux/kernel/people/rusty/patches/Module/
S: 859 kbytes, 296/44 files altered, 24 new
T: Diffstat
X: Summary patch (609k)
N: Requires new modutils

Nanosecond Time Patch
A: Andi Kleen
M: http://www.ussg.iu.edu/hypermail/linux/kernel/0210.3/0793.html
D: ftp://ftp.firstfloor.org/pub/ak/v2.5/nsec-2.5.44-2.bz2
S: 194 kbytes, 158/0 files altered, 0 new
T: Diffstat
X: Summary patch (181k)
N: The core is tiny: putting nanoseconds into filesystems is the bulk of this patch.

Fbdev Rewrite
A: James Simmons
M: http://www.uwsg.iu.edu/hypermail/linux/kernel/0111.3/1267.html
D: http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz
S: 2320 kbytes, 131/20 files altered, 40 new
T: Diffstat
X: Summary patch (401k)

Linux Trace Toolkit (LTT)
A: Karim Yaghmour
M: http://www.uwsg.iu.edu/hypermail/linux/kernel/0204.1/0832.html
M: http://marc.theaimsgroup.com/?l=linux-kernel&m=103491640202541&w=2
M: http://marc.theaimsgroup.com/?l=linux-kernel&m=103423004321305&w=2
M: http://marc.theaimsgroup.com/?l=linux-kernel&m=103247532007850&w=2
D: http://opersys.com/ftp/pub/LTT/ExtraPatches/patch-ltt-linux-2.5.45-vanilla-021030-2.2.bz2
S: 257 kbytes, 68/3 files altered, 9 new
T: Diffstat
X: Summary patch (92k)

statfs64
A: Peter Chubb
M: http://marc.theaimsgroup.com/?l=linux-kernel&m=103610918825614&w=2
D: http://marc.theaimsgroup.com/?l=linux-kernel&m=103610918825614&w=2
S: 48 kbytes, 53/0 files altered, 2 new
T: Diffstat
X: Summary patch (32k)

POSIX Timer API
A: George Anzinger
M: http://marc.theaimsgroup.com/?l=linux-kernel&m=103553654329827&w=2
D: http://unc.dl.sourceforge.net/sourceforge/high-res-timers/hrtimers-posix-2.5.45-1.0.patch
S: 66 kbytes, 18/1 files altered, 4 new
T: Diffstat
X: Summary patch (21k)

Hotplug CPU Removal Support
A: Rusty Russell
D: http://www.kernel.org/pub/linux/kernel/people/rusty/patches/Hotcpu/hotcpu-cpudown.patch.gz
S: 32 kbytes, 16/0 files altered, 0 new
T: Diffstat
X: Summary patch (29k)

initramfs
A: Al Viro / Jeff Garzik
M: http://www.cs.helsinki.fi/linux/linux-kernel/2001-30/0110.html
D: ftp://ftp.math.psu.edu/pub/viro/N0-initramfs-C21
S: 16 kbytes, 5/1 files altered, 2 new
T: Diffstat
X: Summary patch (5k)
N: Linus says he wants it.

Kernel Probes
A: Vamsi Krishna S
M: lists.insecure.org/linux-kernel/2002/Aug/1299.html
D: http://www.kernel.org/pub/linux/kernel/people/rusty/patches/Misc/kprobes.patch.gz
S: 18 kbytes, 3/3 files altered, 4 new
T: Diffstat
X: Summary patch (5k)
