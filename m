Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262349AbRENSCV>; Mon, 14 May 2001 14:02:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262350AbRENSCM>; Mon, 14 May 2001 14:02:12 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:64251 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S262349AbRENSB4>; Mon, 14 May 2001 14:01:56 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200105141800.f4EI0TTb001638@webber.adilger.int>
Subject: Re: Getting FS access events
In-Reply-To: <01051415043103.02742@starship> "from Daniel Phillips at May 14,
 2001 03:04:31 pm"
To: Daniel Phillips <phillips@bonn-fries.net>
Date: Mon, 14 May 2001 12:00:29 -0600 (MDT)
CC: Richard Gooch <rgooch@ras.ucalgary.ca>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel writes:
> But we don't need anything so fancy to try out your idea, we just need 
> a lvm-like device that can:
> 
>   - Maintain a block cache
>   - Remap logical to physical blocks
>   - Record the block accesses
>   - Physically reorder the blocks according to the recorded order
>   - Load a given region of disk into the block cache on command

The current LVM device (if compiled with DEBUG_MAP) will report all of
the logical->physical block mappings via printk.  Probably too heavy-
weight for a large amount of IO.  It could be changed to save the block
numbers into a cache, to be extracted later.  All of the LVM mapping
is done in the lvm_map() function.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
