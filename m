Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278756AbRJVMJT>; Mon, 22 Oct 2001 08:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278753AbRJVMJK>; Mon, 22 Oct 2001 08:09:10 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:64598 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S278751AbRJVMI6>; Mon, 22 Oct 2001 08:08:58 -0400
Date: Mon, 22 Oct 2001 14:09:35 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: Re: problems with I/O performance with 2.4.12-ac3
Message-ID: <20011022140935.I26029@athlon.random>
In-Reply-To: <20011019195328.A30781@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20011019195328.A30781@localhost>; from vdb@mail.ru on Fri, Oct 19, 2001 at 07:53:28PM +0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2001 at 07:53:28PM +0400, Dmitry Volkoff wrote:
> Hi,
> On my machine HDD is slow with all ac-kernels I've tried so far.
> There is even more simple test -- hdparm.
> 
> 2.4.12-ac3:
> # hdparm -tT /dev/hda
> /dev/hda:
> Timing buffer-cache reads:   128 MB in  0.70 seconds =182.86 MB/sec
> Timing buffered disk reads:  64 MB in  2.88 seconds = 22.22 MB/sec
> 
> 2.4.13-pre3:
> # hdparm -tT /dev/hda
> /dev/hda
> Timing buffer-cache reads:   128 MB in  0.63 seconds =203.00 MB/sec
> Timing buffered disk reads:  64 MB in  1.57 seconds = 40.76 MB/sec

this should be mostly the blkdev in pagecache and possibly also the vm.

Andrea
