Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbUEVMak@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbUEVMak (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 08:30:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbUEVMak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 08:30:40 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:2688 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S261169AbUEVMai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 08:30:38 -0400
Date: Sat, 22 May 2004 13:37:02 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200405221237.i4MCb2Qn000252@81-2-122-30.bradfords.org.uk>
To: Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>,
       linux-kernel@vger.kernel.org
Cc: Andries.Brouwer@cwi.nl, torvalds@osdl.org
In-Reply-To: <16559.14090.6623.563810@hertz.ikp.physik.tu-darmstadt.de>
References: <16559.14090.6623.563810@hertz.ikp.physik.tu-darmstadt.de>
Subject: Re: rfc: test whether a device has a partition table
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>:
> Hello,
> 
> around last september there was a discussion about the linux kernel
> recognizing "supperfloppys" as disks with bogus partition tables.
> Linux Torvalds wrote at one point in the discussion:
> >On Thu, 25 Sep 2003, Andries Brouwer wrote:
> >> 
> >> My post implicitly suggested the minimal thing to do.
> >> It will not be enough - heuristics are never enough -
> >> but it probably helps in most cases.
> >
> >I don't mind the 0x00/0x80 "boot flag" checks - those look fairly 
> > obvious and look reasonably safe to add to the partitioning code.
> >
> >There are other checks that can be done - verifying that the start/end
> >sector values are at all sensible. We do _some_ of that, but only for
> >partitions 3 and 4, for example. We could do more - like checking the
> >actual sector numbers (but I think some formatters leave them as zero).
> >
> >Which actually makes me really nervous - it implies that we've probably 
> >seen partitions 1&2 contain garbage there, and the problem is that if 
> >you'r etoo careful in checking, you will make a system unusable.
> >
> >This is why it is so much nicer to be overly permissive ratehr than 
> >being a stickler for having all the values right.
> >
> >And your random byte checks for power-of-2 make no sense. What are they
> >based on?
> 
> The discussion seemed to fade out with no visible result, and for example my

I seem to remember the conclusion being Linus saying something along the
lines of prefering the situation where you have bogus partitions detected
rather than genuine partitions not detected.

John.
