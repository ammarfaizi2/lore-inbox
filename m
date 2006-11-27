Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758294AbWK0Pee@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758294AbWK0Pee (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 10:34:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758296AbWK0Pee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 10:34:34 -0500
Received: from usea-naimss1.unisys.com ([192.61.61.103]:9741 "EHLO
	usea-naimss1.unisys.com") by vger.kernel.org with ESMTP
	id S1758294AbWK0Ped (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 10:34:33 -0500
Subject: Re: [PATCH] x86_64: Make the NUMA hash function nodemap allocation
	dynamic and remove NODEMAPSIZE
From: Amul Shah <amul.shah@unisys.com>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Andi Kleen <ak@suse.de>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200611271123.11649.dada1@cosmosbay.com>
References: <1163627312.3553.199.camel@ustr-linux-shaha1.unisys.com>
	 <200611262149.36529.ak@suse.de>  <200611271123.11649.dada1@cosmosbay.com>
Content-Type: text/plain
Date: Mon, 27 Nov 2006 10:32:56 -0500
Message-Id: <1164641576.3227.12.camel@ustr-linux-shaha1.unisys.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Nov 2006 15:33:55.0334 (UTC) FILETIME=[72E42A60:01C71239]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-11-27 at 11:23 +0100, Eric Dumazet wrote:
> On Sunday 26 November 2006 21:49, Andi Kleen wrote:
> > I had the patch in, but had to drop it again because it makes one of my
> > test system triple fault. Haven't done much investigation yet.
> >
> > No NUMA configuration found
> > Faking a node at 0000000000000000-000000003ef30000
> > <triple fault>
> >
> 
> Well, I dont have currently an AMD64 test machine so I cannot really help.
> 
> With previous implementation, the nimimum shift value was 20 (one megabytes)
> 
> If a memnode had a finer range (with chunks not multiple of megabytes), some 
> bits of memory could be ignored.
> 
> But with your fake node (0-3ef30000), Amul patch may give a shift value of 16.
>  Maybe this breaks something in the kernel...

I believe that this problem is related to a new patch that enhances the
fake NUMA code (see http://article.gmane.org/gmane.linux.kernel/469457).
I'll work with the submitter of said patches to make them compatible.
Hopefully that will fix the problem.

thanks,
Amul

