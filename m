Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312971AbSDGGHl>; Sun, 7 Apr 2002 01:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312972AbSDGGHl>; Sun, 7 Apr 2002 01:07:41 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:65031
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S312971AbSDGGHj>; Sun, 7 Apr 2002 01:07:39 -0500
Date: Sat, 6 Apr 2002 22:06:25 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Pritpaul Mahal <psm321@linuxmail.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: 2.4.19-pre4-ac3 (ide?) freeze
In-Reply-To: <20020407014422.17654.qmail@linuxmail.org>
Message-ID: <Pine.LNX.4.10.10204062201510.16784-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Well please do not enable taskfile until the rev on the file is 0.31 or
higher.  Since there is a delay in getting stuff to AC, it was a mistake
to unmask the option early.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

On Sat, 6 Apr 2002, Pritpaul Mahal wrote:

> Hi! I am running kernel 2.4.19-pre4-ac3 with the preempt patch.  I
> finally got everything working after some experimentation (Maxtor
> Promise ATA133 controller with new 160GB hard drive).
> 
> However, the kernel seems to freeze up after a few hours.  Any copy
> operations, etc stop, and it seems to be unable to start new processses.
> When I use SysRq+9, I keep getting hda: lost interrupt messages.  (hda
> is the drive I am booting from, not on the Promise controller.) This has
> happened two or three times so far, but it seems to have caused a worse
> problem the last time.
> 
> Now, whenever I try to bootup with that root partition, whether using
> the new kernel or an older one, I get messages like INIT: cannot execute
> /sbin/agetty.  I have run e2fsck, with no major problems, tried
> replacing files and binaries (init, inittab, agetty, etc) with known
> working copies from another partition, but to no avail.  When I try
> passing init=/bin/sh or init=/bin/bash to the kernel, it gives an error
> about not being able to locate an init program and to try passing init=
> to the kernel.  If I boot up with another partition, I can run binaries
> (agetty, bash, etc) just fine.  I checked my fstab and it seems to be
> fine.  I also tried copying everything to another partition and booting
> with that, but had the same problem.
> 
> I realize that this second problem may not directly be related to the
> kernel, but I am mentioning it because it seems to have been caused by
> the kernel freeze (and the fact that I am desperate for help :) ).
> 
> I am not adverse to a kernel upgrade, but would like to avoid it unless
> the freezing is either a known problem with this kernel or there is a
> likelihood that one of the updates in a newer kernel may have fixed the
> problem.
> 
> I would also appreciate any suggestions on how to be able to boot my
> partition again as otherwise I have no way to get full access to my
> computer. My other partition has a problem in the fstab that makes fsck
> try to check a nonexistant drive, making it boot read-only and
> single-user.  I have no way to edit this as I need the ide-patch to
> access this drive and I don't know any rescue disks that support this.
> 
> I would appreciate any help/suggestions for either of these problems. :)
> I am not attaching my .config because this is my first post to this list
> and I'm not sure if it would be appropriate, but I would be happy to do
> so if requested.  A few things off the top of my head: No I/O or Local
> APIC (no idea what they are but they caused problems), no ACPI
> (conflicted with Promise controller), and I'm pretty sure I have the new
> Taskfile access enabled.
> 
> Thanks a lot!
> 
> Sincerely,
> Pritpaul Mahal
> 
> P.S. I would appreciate a CC of any replies to me, as I am not subscribed to the list.  However, I will check the archives for replies, so it's not really necessary, just don't flame me. :-P
> 
> 
> -- 
> 
> Get your free email from www.linuxmail.org 
> 
> 
> Powered by Outblaze
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

