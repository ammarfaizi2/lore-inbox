Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265605AbRF1JKP>; Thu, 28 Jun 2001 05:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265610AbRF1JKF>; Thu, 28 Jun 2001 05:10:05 -0400
Received: from ns.caldera.de ([212.34.180.1]:40370 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S265605AbRF1JJu>;
	Thu, 28 Jun 2001 05:09:50 -0400
Date: Thu, 28 Jun 2001 11:09:12 +0200
Message-Id: <200106280909.f5S99Bd24719@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: gp@iws.it (Giampaolo Gallo)
Cc: linux-kernel@vger.kernel.org
Subject: Re: problem building 2.4.6 pre 6 + freevxfs
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <993718178.8885.0.camel@castle>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.2 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Giampaolo,

In article <993718178.8885.0.camel@castle> you wrote:
> gcc -D__KERNEL__ -I/u1/usr.src/linux/include -Wall -Wstrict-prototypes
> -Wno-traphs -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe
> -mpreferred-stack-bdary=2 -march=i686    -c -o vxfs_inode.o vxfs_inode.c
> vxfs_inode.c:50: `generic_file_llseek' undeclared here (not in a
> function)
> vxfs_inode.c:50: initializer element is not constant
> vxfs_inode.c:50: (near initialization for `vxfs_file_operations.llseek')

Just remove the complete line - generic_file_llseek doesn't exist in
2.4.6-pre6 and it's appeareance seems to be an merge error.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
