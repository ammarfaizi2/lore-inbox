Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290833AbSAaCZP>; Wed, 30 Jan 2002 21:25:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290834AbSAaCZE>; Wed, 30 Jan 2002 21:25:04 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:17257 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S290833AbSAaCYp>; Wed, 30 Jan 2002 21:24:45 -0500
Date: Thu, 31 Jan 2002 03:25:40 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Momchil Velikov <velco@fadata.bg>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] Radix tree page cache
Message-ID: <20020131032540.W1309@athlon.random>
In-Reply-To: <87sn8ny4af.fsf@fadata.bg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <87sn8ny4af.fsf@fadata.bg>; from velco@fadata.bg on Wed, Jan 30, 2002 at 10:25:44PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 10:25:44PM +0200, Momchil Velikov wrote:
> Linus,
> 
> Please, consider for inclusion in 2.5.3 series the following radix
> tree page cache patch.

Please benchmark on files 10giga large, only do cached I/O (reads are
fine) between 9G and 10G offset for example.

dbench or others handling not very huge files are not interesting
benchmarks for this, for them per-inode rbtree was faster too. the only
problem are the very huge files, the hashtable guarantees the same
performance on small and huge files.

Andrea
