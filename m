Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279951AbRKXTjL>; Sat, 24 Nov 2001 14:39:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279617AbRKXTjC>; Sat, 24 Nov 2001 14:39:02 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:35866 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S279418AbRKXTit>; Sat, 24 Nov 2001 14:38:49 -0500
Date: Sat, 24 Nov 2001 20:39:01 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Phil Sorber <aafes@psu.edu>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.15aa1
Message-ID: <20011124203901.Q1419@athlon.random>
In-Reply-To: <20011124085028.C1419@athlon.random> <1006629351.1470.8.camel@praetorian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <1006629351.1470.8.camel@praetorian>; from aafes@psu.edu on Sat, Nov 24, 2001 at 02:15:50PM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 24, 2001 at 02:15:50PM -0500, Phil Sorber wrote:
> On Sat, 2001-11-24 at 02:50, Andrea Arcangeli wrote:
> > Only in 2.4.15aa1: 00_iput-unmount-corruption-fix-1
> > 
> > 	Fix iput umount corruption.
> 
> Is this the problem that Al put out a patch for yesterday? And is his
> patch been tested and working?

it's an alternate fix (goes back to the pre8 way).

> 
> > Only in 2.4.15aa1: 00_read_super-stale-inode-1
> > 
> > 	If read_super fails avoid lefting stale inodes queued into
> > 	the superblock.
> 
> What is this? How dangerous is it?

pre8 and all previous kernels could left a stale inode if read_super
failed after an iget [see the discussion with Al on l-k]. this patch
should fix it in practice for all fs in the kernel.

Andrea
