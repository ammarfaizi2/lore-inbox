Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262489AbRENUyc>; Mon, 14 May 2001 16:54:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262493AbRENUyW>; Mon, 14 May 2001 16:54:22 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:18940 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S262489AbRENUyH>; Mon, 14 May 2001 16:54:07 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200105142053.f4EKrhOh002240@webber.adilger.int>
Subject: Re: [Re: Inodes]
In-Reply-To: <9dovmu$eqj$1@cesium.transmeta.com> "from H. Peter Anvin at May
 14, 2001 09:04:46 am"
To: "H. Peter Anvin" <hpa@zytor.com>
Date: Mon, 14 May 2001 14:53:43 -0600 (MDT)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HPA writes:
> Blesson Paul <blessonpaul@usa.net> writes:
> > You misunderstood my question. Let take an example.  Let I have a msdos
> > partition. No msdos files has inode numbers, right. Let I mount that
> > msdos partition. Then what happens, That is my question. Will the
> > inode numbers are assigned to all msdos files at mounting time itself
> > 
> 
> The inode numbers are "invented" by the MS-DOS filesystem driver.  In
> the particular case of the "msdos" driver I believe it uses the
> location of the directory entry (the functional equivalent of the
> inode) on disk.

Just to clarify, this means that the "inode numbers" reported by an
msdos filesystem are a function of the disk-layout itself (i.e. they
are determined at mount time), and not numbers created when the file
is first accessed (AFAIK).

However, other filesystems are free to do this in other ways.  Reiserfs
has 64-bit "inode numbers" (actually "packing locality" + unique ID),
as does NTFS and XFS.  Network filesystems may do something completely
different (I have no idea what SMBFS does).

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
