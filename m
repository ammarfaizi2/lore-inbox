Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263518AbTKUNxv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 08:53:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264274AbTKUNxu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 08:53:50 -0500
Received: from intra.cyclades.com ([64.186.161.6]:62627 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S263518AbTKUNxs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 08:53:48 -0500
Date: Fri, 21 Nov 2003 11:47:49 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Mikael Johansson <mpjohans@pcu.helsinki.fi>
Cc: linux-raid@vger.kernel.org, <linux-kernel@vger.kernel.org>
Subject: Re: RAID-0 read perf. decrease after 2.4.20
In-Reply-To: <Pine.OSF.4.58.0311201827090.515286@soul.helsinki.fi>
Message-ID: <Pine.LNX.4.44.0311211144130.15440-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 20 Nov 2003, Mikael Johansson wrote:

> 
> Hello All!
> 
> Has anyone else experienced a drastic drop in read performance on software
> RAID-0 with post 2.4.20 kernels? We have a few Athlon XP's here at our
> lab with double IDE disks on different channels set up as RAID-0. Some
> bonnie++ benchmark results with various kernels, on the same machine
> (Athlon XP 2400+, 2 GHz, 1.5 GB RAM, VIA chipset, 2*Maxtor 120 GB
> 6Y060L0):
> 		write	read
> 2.4.20-ac1:	88,000 	135,000 K/sec
> 2.4.21-pre7:	93,000   75,000
> 2.4.22-ac4:	94,000	 82,000
> 
> So the write speed has gone up a bit, but the read speed performance has
> plunged. Any ideas on what happened between 2.4.20 and 2.4.21 and what to
> do about it? I'm eagerly awaiting suggestions, good read speed is quite
> critical for many of our calculations :-) I will of course provide more
> details if necessary.

There have been no significant changes in the RAID driver in 2.4.21, so I
suspect the cause for the slowdowns might the changes to the IO scheduler
(ll_rw_blk.c) or VM changes.

Isolating the -pre which the slowdown starts helps a lot.



