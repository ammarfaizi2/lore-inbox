Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289011AbSANUX4>; Mon, 14 Jan 2002 15:23:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289018AbSANUW7>; Mon, 14 Jan 2002 15:22:59 -0500
Received: from 216-42-72-141.ppp.netsville.net ([216.42.72.141]:11414 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S289012AbSANUVm>; Mon, 14 Jan 2002 15:21:42 -0500
Date: Mon, 14 Jan 2002 15:21:15 -0500
From: Chris Mason <mason@suse.com>
To: Andreas Dilger <adilger@turbolabs.com>, Oleg Drokin <green@namesys.com>
cc: Hans Reiser <reiser@namesys.com>, reiserfs-list@namesys.com,
        linux-kernel@vger.kernel.org, ewald.peiszer@gmx.at,
        matthias.andree@stud.uni-dortmund.de
Subject: Re: [reiserfs-list] Boot failure: msdos pushes in front of reiserfs
Message-ID: <551760000.1011039675@tiny>
In-Reply-To: <20020114104242.M26688@lynx.adilger.int>
In-Reply-To: <20020113223803.GA28085@emma1.emma.line.org>
 <20020114095013.A4760@namesys.com> <3C42BE0E.2090902@namesys.com>
 <20020114143650.D828@namesys.com> <20020114104242.M26688@lynx.adilger.int>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Monday, January 14, 2002 10:42:42 AM -0700 Andreas Dilger
<adilger@turbolabs.com> wrote:

>> We can use both:
>>      destroy MSDOS superblock (if any) at mkreiserfs (or don't touch 1st
>>      block of the device if there is no msdos superblock).
>>      And link reiserfs code into the kernel earlier than msdos code.
> 
> Hmm, I could have sworn I submitted patches already which did both of these
> things.  In general, it is perfectly safe to zero the bootsector of a
> partition when you mkfs it (mke2fs has been doing this for a long time).
> If you mkfs your boot partition (and zap the bootblock) you would have to
> run LILO on it anyways after they install a new kernel, because the
> location of the kernel would change.

Hmmm mke2fs seems to always zero out the first 1024, except on sparcs (when
ZAP_BOOT_BLOCK not defined).  I thought alphas stored the partition table on
the first block of the first partition as well, and that we didn't want to
zero it then.

-chris

