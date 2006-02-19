Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932371AbWBSJCt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932371AbWBSJCt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 04:02:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932375AbWBSJCt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 04:02:49 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:17585 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932371AbWBSJCs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 04:02:48 -0500
Date: Sun, 19 Feb 2006 10:02:34 +0100
From: Pavel Machek <pavel@suse.cz>
To: Phillip Susi <psusi@cfl.rr.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Kyle Moffett <mrmacman_g4@mac.com>,
       Alon Bar-Lev <alon.barlev@gmail.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Flames over -- Re: Which is simpler?
Message-ID: <20060219090234.GB3235@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0602131601220.4754-100000@iolanthe.rowland.org> <43F11A9D.5010301@cfl.rr.com> <20060217210445.GR3490@openzaurus.ucw.cz> <43F74C89.1080606@cfl.rr.com> <20060218172908.GD1776@elf.ucw.cz> <43F807AD.6080008@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F807AD.6080008@cfl.rr.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Ne 19-02-06 00:52:45, Phillip Susi wrote:
> Pavel Machek wrote:
> >>Provided that you sync before suspending, and there are no open files on 
> >>the filesystem, then yes, no data will be lost.  If there are open files 
> >>on the fs, such as a half saved document, or a running binary, or say, 
> >>the whole root fs, then you're going to loose data and even panic the 
> >>kernel, sync or no sync.  From the user perspective, this is
> >>unacceptable.
> >
> >While with your solution, you do not loose one open file, you loose
> >whole filesystem. Which is unacceptable.
> 
> Only if the user is foolish enough to modify the media somehow while the 
> system is suspended and replace it, which is exactly how non USB disks 
> currently behave.

"Foolish enough"? Multiple users told you that they consider that use
case okay for hotpluggable drives.

> >>connection to the drive thy are using is USB?  Every other type of drive 
> >>and interface does not suffer from this problem.
> >
> >Because it is okay to unplug usb disk on runtime, while it is not okay
> >to unplug ATA disk on runtime. And because alternatives suck even more.
> >
> 
> Actually, no, it is not okay to unplug a usb disk at runtime while it is 
> mounted.  It never has been and it never will be.  Also we aren't 

Ever heard about "journalling"?

> talking about runtime, we're talking about while the system is 
> suspended, when there is no way for the kernel to know whether or
> not 

If it is okay during runtime, it should be okay while suspended. Don't
expect users to know about power on USB buses. You may call any system
that does not support standby power on USB broken if you wish... 

> the device was unplugged, since it _allways_ appears to have been 
> unplugged.  The alternative in the uncommon case ( where the user 
> modifies the media while suspended ) does not suck any worse than it 
> currently does on non usb media, and the common case ( where the user 
> doesn't ) sucks worse currently with usb than others.

"Does not such any worse than non-usb" does not cut it here. USB disks
are too easy to unplug/replug.

Anyway, your mail came without a patch, again. That's useless; if you
implement layer above floppies/usb sticks that can recognize same
disk, maybe we can talk about that.
								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
