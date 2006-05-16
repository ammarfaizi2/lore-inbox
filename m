Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750717AbWEPUKL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbWEPUKL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 16:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750758AbWEPUKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 16:10:11 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:42508 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1750717AbWEPUKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 16:10:09 -0400
Date: Tue, 16 May 2006 22:10:02 +0200
From: Willy Tarreau <willy@w.ods.org>
To: George Nychis <gnychis@cmu.edu>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: problem booting 2.4.32, unknown symbol
Message-ID: <20060516201002.GP11191@w.ods.org>
References: <4469E51E.80103@cmu.edu> <20060516075340.8d387ddb.rdunlap@xenotime.net> <4469E839.3090806@cmu.edu> <20060516081442.579d3c12.rdunlap@xenotime.net> <4469EF6F.7050801@cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4469EF6F.7050801@cmu.edu>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2006 at 11:27:43AM -0400, George Nychis wrote:
> 
> 
> Randy.Dunlap wrote:
> > On Tue, 16 May 2006 10:56:57 -0400 George Nychis wrote:
> > 
> >>
> >> Randy.Dunlap wrote:
> >>> On Tue, 16 May 2006 10:43:42 -0400 George Nychis wrote:
> >>>
> >>>> Hi,
> >>>>
> >>>> I am trying to boot 2.4.32 with FC3, whenever i try to boot i get the
> >>>> following errors:
> >>>>
> >>>> insmod: error inserting `/lib/scsi_mod.o': -1 Unknown symbol in module
> >>>> ERROR /bin/insmod excited abnormally!
> >>>> insmod: error inserting `/lib/sd_mod.o': -1 Unknown symbol in module
> >>>>
> >>>> I get the same error for libata.o, ata_piix.o, and lvm-mod.o
> >>>>
> >>>> then i get failed to create /edv/ide/host0/bus0/target0/lun0/disc
> >>>>
> >>>> So my guess is trying to fix the top most first
> >>>>
> >>>> Anyone have any ideas?
> >>> I don't know the problem, but dmesg should show you/us the
> >>> actual symbol that is wanted and missing, so please provide that.
> >>>
> >>> ---
> >>> ~Randy
> >>>
> >> If the system doesn't boot, how can i get the dmesg?
> > 
> > aha, my bad, sorry.
> > I'll have to defer to someone who knows about FC3.
> > 
> > ---
> > ~Randy
> > 
> 
> Some more info, my bottom most errors:
> 
> ERROR: failed in exec of vgscan
> ERROR: failed in exec of vgchange
> mount: error 6 mounting ext3
> pivotroot: pivot_root(/sysroot,/sysroot/initrd) failed: 2
> umount /initrd/proc failed: 2
> ERROR: vchange exited abnormally!
> mkrootdev: mknod failed: 17
> ...
> ...
> Kernel panic: No init found.  Try passing init= option to kernel

Are you really sure this combination is supported at all ? Your distro
might be heavily relying on 2.6 extensions not present in 2.4 (lvm2, ...).
For instance, I remember that a time ago, some distros installed with
the DIRINDEX option enabled on all EXT2/EXT3 filesystems, which could
not be mounted by unpatched kernels because this option was not in
mainline.

> - George

Willy

