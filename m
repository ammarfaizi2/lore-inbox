Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312712AbSDFSjX>; Sat, 6 Apr 2002 13:39:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312713AbSDFSjW>; Sat, 6 Apr 2002 13:39:22 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:21938 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S312712AbSDFSjV>;
	Sat, 6 Apr 2002 13:39:21 -0500
Date: Sat, 6 Apr 2002 13:39:20 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Wayne.Brown@altec.com
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.8-pre2 ncpfs unresolved symbols
In-Reply-To: <86256B93.00658E1F.00@smtpnotes.altec.com>
Message-ID: <Pine.GSO.4.21.0204061338260.632-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 6 Apr 2002 Wayne.Brown@altec.com wrote:

> 
> 
> ncpfs.o has unresolved symbols lock_kernel() and unlock_kernel() in 2.5.8-pre2.
> Adding #include <linux/smp-lock.h> in fs/ncpfs/inode.c gets rid of this error.
> I can't test the driver until Monday, though, as I won't have access to a
> network with a Novell server before then.

Dave forgot to add smp_lock.h while messing with BKL-shifting.  There and
in jffs2/file.c

