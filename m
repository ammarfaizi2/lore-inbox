Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286893AbSALOZW>; Sat, 12 Jan 2002 09:25:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286999AbSALOZO>; Sat, 12 Jan 2002 09:25:14 -0500
Received: from 099.dsl6660135.nokia.surewest.net ([66.60.135.99]:17652 "HELO
	dragonglen.net") by vger.kernel.org with SMTP id <S286893AbSALOZH>;
	Sat, 12 Jan 2002 09:25:07 -0500
Date: Sat, 12 Jan 2002 06:25:36 -0800 (PST)
From: Eric <eric-linuxkernel@dragonglen.net>
X-X-Sender: <eric@fire.dragonglen.invalid>
To: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.17 oops - ext2/ext3 fs corruption (?)
In-Reply-To: <E16NAKo-0001K1-00@starship.berlin>
Message-ID: <Pine.LNX.4.33.0201120619330.2686-100000@fire.dragonglen.invalid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Jan 2002, Daniel Phillips wrote:

> On January 6, 2002 12:31 am, Eric wrote:
> > On Sat, 5 Jan 2002, Andrew Morton wrote:
> > > Eric wrote:
> > > > 
> > > > I seem to be having a reoccurring problem with my Red Hat 7.2 system
> > > > running kernel 2.4.17.  Four times now, I have seen the kernel generate an
> > > > oops.  After the oops, I find that one of file systems is no longer sane.
> > > > The effect that I see is a Segmentation Fault when things like ls or du
> > > > some directory (the directory is never the same).  Also, when the system
> > > > is going down for a reboot, it is unable to umount the file system.  The
> > > > umount command returns a "bad lseek" error.
> > > 
> > > Everything here points at failing hardware.  Probably memory errors.
> > > People say that memtest86 is good at detecting these things.  Another
> > > way to verify this is to move the same setup onto a different computer...
> > 
> > I ran memtest86 on the system and let it complete 4 passes before I 
> > stopped it.  It found no errors.  Unfortunately, I do not have another 
> > system available to test this on.  Are there any other diagnostics I can 
> > run to determine if this is truly a hardware problem?
> 
> This doesn't smell like hardware to me, since your two backtraces are identical:

In an attempt to try a get more information about what is going on, I
tried compiling a new kernel with the options CONFIG_DEBUG_KERNEL and
CONFIG_DEBUG_BUGVERBOSE turned on.  However, this seems to have made 
things worse.  Now, in about 6-12 hours from boot-up, the system will hang 
completely with no information from the kernel on the console.  The only 
way to get out it is to use the reset button on the front of the box.

Is there anything else I can do to try and determine if this is a kernel 
problem?  Or at least get more information about what is going on?

Thanks,

Eric


