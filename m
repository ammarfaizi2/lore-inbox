Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288768AbSAQOOL>; Thu, 17 Jan 2002 09:14:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288783AbSAQOOB>; Thu, 17 Jan 2002 09:14:01 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:1049 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S288768AbSAQONu>; Thu, 17 Jan 2002 09:13:50 -0500
Date: Thu, 17 Jan 2002 15:13:56 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Chris Chabot <chabotc@reviewboard.com>
Cc: linux-kernel@vger.kernel.org, Rik van Riel <riel@conectiva.com.br>
Subject: blkdev speedup
Message-ID: <20020117151356.G4847@athlon.random>
In-Reply-To: <20020116200459.E835@athlon.random> <3C460255.4020805@reviewboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3C460255.4020805@reviewboard.com>; from chabotc@reviewboard.com on Wed, Jan 16, 2002 at 11:44:37PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2002 at 11:44:37PM +0100, Chris Chabot wrote:
> 
> > Test hardware:
> > 4 way Dell, 4 GB physical RAM, SCSI/RAID subsystem,
> > DB runs on FS.
> 
> Can we first make sure that the other factors dont plat a rol in this 
> benchmark? I have a couple (14+) Dell servers here, and i know for a 
> fact that most of their RAID systems are heavely borked in the 
> performance department.
> 
> All kernels upto 2.4.1x performed horibly, and all kernels after 2.4.16 
> or so perform horibly again! Somewhere inbetween some magic seemed to 
> happen in the block layer / elevator code / etc, that caused performance 
> to increase upto 100% on the Dell PERC adapters. (started @ the first 
> release of the AA VM). However after a few small releases, the 

if you're using the blkdev directly, then please try to mount the blkdev
with a 4k filesystem before making your benchmark, that should give you
the magic performance back. 2.4.10 intentionally were defaulting to 4k
I/O, this is probably what made the difference for you.

Andrea
