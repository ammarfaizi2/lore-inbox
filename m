Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262787AbVCER7D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262787AbVCER7D (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 12:59:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261688AbVCER4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 12:56:35 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31456 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261694AbVCERuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 12:50:21 -0500
Message-ID: <4229F14A.8030109@pobox.com>
Date: Sat, 05 Mar 2005 12:50:02 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Russell King <rmk+lkml@arm.linux.org.uk>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       chrisw@osdl.org
Subject: Re: Linux 2.6.11.1
References: <20050304175302.GA29289@kroah.com> <20050304124431.676fd7cf.akpm@osdl.org> <20050304205842.GA32232@kroah.com> <20050304131537.7039ca10.akpm@osdl.org> <Pine.LNX.4.58.0503041353050.11349@ppc970.osdl.org> <20050304135933.3a325efc.akpm@osdl.org> <20050304220518.GC1201@kroah.com> <20050305095139.A26541@flint.arm.linux.org.uk> <4229EA0A.8010608@pobox.com> <Pine.LNX.4.58.0503050930430.2304@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0503050930430.2304@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sat, 5 Mar 2005, Jeff Garzik wrote:
> 
>>Yup, BK could definitely handle that...
> 
> 
> However, it's also true that the thing BK is _worst_ at is cherry-picking 
> things, and having a collection of stuff where somebody may end up vetoing 
> one patch and saying "remove that one".

In general, I agree.  Andrew and I mentioned this to BitMover recently 
[though its certainly not a new comment], when they asked us why I had 
to occasionally blow away the netdev-2.6 tree, and reconstitute it from 
scratch.


> I love BK, but what BK does well is merging and maintaining trees full of 
> good stuff. What BK sucks at is experimental stuff where you don't know 
> whether something should be eventually used or not.

I use BitKeeper to maintain such a tree, "libata-dev".  Most stuff in 
there will go upstream.  Some stuff may never go upstream.  Some stuff 
needs to simmer for a while before going upstream.  So "change streams" 
get divided up locally:

[jgarzik@pretzel libata-dev]$ ls -FC
adma/          atapi-enable/        janitor/            remove-one-fix/
adma-mwi/      bridge-detect/       passthru/           sata-sil-irq/
ahci-msi/      chs-support/         pdc2027x/           tf-cleanup/
ahci-tf-read/  ioctl-get-identity/  pdc20619/           via-6421/
iomap/         promise-sata-pata/

and then I cherrypick from that.

netdev-2.6 queue is maintained the same way.  It's simply a merge tree 
composed of 40+ individual trees, all merged together.

	Jeff


