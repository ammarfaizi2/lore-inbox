Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265475AbRGPRG7>; Mon, 16 Jul 2001 13:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265449AbRGPRGi>; Mon, 16 Jul 2001 13:06:38 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:32587 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S265452AbRGPRGb>; Mon, 16 Jul 2001 13:06:31 -0400
Date: Mon, 16 Jul 2001 19:06:53 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Gianluca Anzolin <g.anzolin@inwind.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.7-pre6 can't complete e2fsck
Message-ID: <20010716190653.E11978@athlon.random>
In-Reply-To: <20010716132933.A216@fourier.home.intranet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010716132933.A216@fourier.home.intranet>; from g.anzolin@inwind.it on Mon, Jul 16, 2001 at 01:29:33PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2001 at 01:29:33PM +0200, Gianluca Anzolin wrote:
> I've upgraded to 2.4.7-pre6aa1 and I'm seeing a strange behaviour:
> 
> e2fsck /dev/hda3 never finishes: I can't even stop the process with
> CTRL+C. Alt+SysRQ works and it tells me that the number of inactive dirty
> pages increases, while the active and free pages decrease.
> 
> Alt+SYSRQ+P says the kernel loops mainly in page_launder
> 
> Is there a patch to solve this problem?

The problem will go away if you backout this patch:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.7pre6aa1/40_blkdev-pagecache-5

I can reproduce so it will be fixed in the next release. thanks for the
feedback.

Andrea
