Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287648AbSAELGC>; Sat, 5 Jan 2002 06:06:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287652AbSAELFw>; Sat, 5 Jan 2002 06:05:52 -0500
Received: from dsl-213-023-043-154.arcor-ip.net ([213.23.43.154]:52237 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S287648AbSAELFk>;
	Sat, 5 Jan 2002 06:05:40 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Alexander Viro <viro@math.psu.edu>
Subject: Re: [CFT] Unbork fs.h + per-fs supers
Date: Sat, 5 Jan 2002 12:08:55 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@conectiva.com.br>
In-Reply-To: <Pine.GSO.4.21.0201050448280.29230-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0201050448280.29230-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16MohE-0001GW-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 5, 2002 10:54 am, Alexander Viro wrote:
> On Sat, 5 Jan 2002, Daniel Phillips wrote:
> 
> > Adding VFS support for per-fs superblock size was dead simple compared to 
> > doing the inodes because superblocks are few enough that no slab cache is 
> > needed, and also because of cleanup Al had already done.
> 
> *Stop*.
> 
> First of all, exporting size of superblock is wrong, since the entire
> ->read_super() mechanism is going to be replaced with ->get_super(type, ...)
> (get_sb_...() becoming commonly used instances of the method).  Moreover,
> freeing superblock is very likely to become a method (for quite a few
> reasons).
> 
> Please, don't turn fs type into a bloody mess.  It's bad enough as it
> is; at least don't add the stuff that will go away anyway.

How would you suggest it be done?

--
Daniel
