Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276312AbRKHQrd>; Thu, 8 Nov 2001 11:47:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276591AbRKHQrZ>; Thu, 8 Nov 2001 11:47:25 -0500
Received: from rj.sgi.com ([204.94.215.100]:24284 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S275990AbRKHQrQ>;
	Thu, 8 Nov 2001 11:47:16 -0500
Message-Id: <200111081647.KAA23811@slobber.americas.sgi.com>
To: Luka Renko <luka.renko@hermes.si>
cc: Nathan Scott <nathans@sgi.com>, Linus Torvalds <torvalds@transmeta.com>,
        Andreas Gruenbacher <ag@bestbits.at>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, acl-devel@bestbits.at,
        linux-xfs@hermes.si
Subject: Re: [RFC][PATCH] extended attributes 
Date: Thu, 08 Nov 2001 10:47:05 -0600
From: Dean Roehrich <roehrich@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>From:  Luka Renko <luka.renko@hermes.si>
>I am also thinking in terms of HSM application (or DMAPI if you want). Where
>do you want HSM attributes to be placed? I thought it should be in trusted,
>because we might need access to them from user space. Other option is system
>(that would require accessing them from kernel code) or user (might be
>problematic, since regular user with write permission might remove them...
>Actually, where are XFS guys storing DMAPI attributes today?

On XFS the DMAPI event mask for that file is kept in a field in the
xfs_dinode_core_t structure--so it's in the inode.  On Irix, HSM's store state
info in an extended attribute in the "root" namespace on each file, but they
do it via the appropriate DMAPI calls (which jump to XFS's extended attribute
code) rather than via the extended attribute library.


Dean
