Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314278AbSFEKCS>; Wed, 5 Jun 2002 06:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314284AbSFEKCR>; Wed, 5 Jun 2002 06:02:17 -0400
Received: from loewe.cosy.sbg.ac.at ([141.201.2.12]:40952 "EHLO
	loewe.cosy.sbg.ac.at") by vger.kernel.org with ESMTP
	id <S314278AbSFEKCR>; Wed, 5 Jun 2002 06:02:17 -0400
Date: Wed, 5 Jun 2002 12:02:07 +0200 (MET DST)
From: "Thomas 'Dent' Mirlacher" <dent@cosy.sbg.ac.at>
To: Hans-Christian Armingeon <linux.johnny@gmx.net>
cc: Andreas Dilger <adilger@clusterfs.com>, Andrew Morton <akpm@zip.com.au>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [rfc] "laptop mode"
In-Reply-To: <200206051340.47261.root@johnny>
Message-ID: <Pine.GSO.4.05.10206051157190.8783-100000@mausmaki.cosy.sbg.ac.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--snip/snip
> What parts of the filesystem needs to be accessed very often? I think, that placing var on a ramdisk, that is mirrored on the hd and is synced every 30 minutes, would be a good solution.
> I think, that we should add a sysrq key to save the ramdisk to the disk. Is there a similar project, that loads an image into a ramdisk at mount, and writes it back at unmount?

a nice thing for that would be to have unionfs (al viro seems to work on that?),
and mount a ramdisk ontop of your var directory (or shichever directory is
a hotspot. - or mount it over your whole harddrive, doing COW on the ramdisk.
and once the disk reaches a critical high-water-mark sync the whole set to
the underlaying "real" filesystem.

any comments?

	tm

-- 
in some way i do, and in some way i don't.

