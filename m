Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267490AbSLFBJw>; Thu, 5 Dec 2002 20:09:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267492AbSLFBJw>; Thu, 5 Dec 2002 20:09:52 -0500
Received: from [195.223.140.107] ([195.223.140.107]:56193 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S267490AbSLFBJv>;
	Thu, 5 Dec 2002 20:09:51 -0500
Date: Fri, 6 Dec 2002 02:17:33 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: Norman Gaywood <norm@turing.une.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: Maybe a VM bug in 2.4.18-18 from RH 8.0?
Message-ID: <20021206011733.GF1567@dualathlon.random>
References: <20021206111326.B7232@turing.une.edu.au> <3DEFF69F.481AB823@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DEFF69F.481AB823@digeo.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2002 at 05:00:15PM -0800, Andrew Morton wrote:
> Hard.  The relevant patches are:
> 
> http://www.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.20aa1/05_vm_16_active_free_zone_bhs-1
> and
> http://www.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.20aa1/10_inode-highmem-2

yep, those are the two I had in mind when I said they're pending for
2.4.21pre inclusion. He may still suffer other known problems besides
the above two critical highmem fixes (for example if
lower_zone_reserve_ratio is not applied and there's no other fix around
it IMHO, that's generic OS problem not only for linux, and that was my
only sensible solution to fix it, the approch in mainline is way too
weak to make a real difference) though probably whatever else problem
would probably need something more complicated than a tar to reproduce.

Andrea
