Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275567AbRJFTWC>; Sat, 6 Oct 2001 15:22:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275570AbRJFTVx>; Sat, 6 Oct 2001 15:21:53 -0400
Received: from fenrus.demon.co.uk ([158.152.228.152]:58027 "EHLO
	fenrus.demon.nl") by vger.kernel.org with ESMTP id <S275567AbRJFTVi>;
	Sat, 6 Oct 2001 15:21:38 -0400
From: arjan@fenrus.demon.nl
To: mikulas@artax.karlin.mff.cuni.cz (Mikulas Patocka)
Subject: Re: %u-order allocation failed
cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.96.1011006210743.7808D-100000@artax.karlin.mff.cuni.cz>
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.3-6.0.1 (i586))
Message-Id: <E15px1O-0000Ee-00@fenrus.demon.nl>
Date: Sat, 06 Oct 2001 20:22:02 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.3.96.1011006210743.7808D-100000@artax.karlin.mff.cuni.cz> you wrote:

> NOTE: no allocations in IRQ are safe. Not only high-order ones. 
> Allocation in IRQ may fail any time and you must recover without lost of
> functionality (network can lose packets any time, if you are doing some
> general device driver, you must preallocate all buffers in process
> context).

how again do you deal with calling vfree() on the ones where you used
vmalloc instead of the buddy allocator ?
