Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030499AbWHRQhm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030499AbWHRQhm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 12:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030497AbWHRQhm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 12:37:42 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:32496 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030499AbWHRQhm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 12:37:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HjZMOGxi7m1sUbq11XlglxlaynFCWm0FpVcsioNXj+/D9r32JzAnreyuQkDO6k8kL/73tEsV3tJ8A2E5XsipqGFVbG+vRHS1vntMDuE7JAelluFgjUyCMXT+B30Mmq4sfJX5LIGxvjok7wGhbt8tSzcxmDZxMhzPCKWm34v9Yug=
Message-ID: <4745278c0608180937k1a2af05fp7142e4cc062bf200@mail.gmail.com>
Date: Fri, 18 Aug 2006 12:37:40 -0400
From: "Vishal Patil" <vishpat@gmail.com>
To: "Andi Kleen" <ak@suse.de>
Subject: Re: Page cache using B-trees benchmark results
Cc: "Andrea Arcangeli" <andrea@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <p73mza280z1.fsf@verdi.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4745278c0608171843j5b3d28bbx16ddf472e1bdb329@mail.gmail.com>
	 <p73mza280z1.fsf@verdi.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Andi....This is useful information....I will look into it and let
you know....
Many thanks.

- Vishal

On 18 Aug 2006 18:25:54 +0200, Andi Kleen <ak@suse.de> wrote:
> "Vishal Patil" <vishpat@gmail.com> writes:
>
> > I am attaching the benchmark results for Page Cache Implementation
> > using B-trees. I basically ran the tio (threaded i/o) benchmark
> > against my kernel (with the B-tree implementation) and the Linux
>
> I suppose you'll need some more varied benchmarks to get
> more solid data.
>
> > kernel shipped with FC5. Radix tree implementation is definately
> > better however the B-tree implementation did not suck that bad :)
>
> Have you considered trying it again instead of radix tree with
> another data structure? There are still plenty of other big
> hash tables in the kernel that might benefit from trying
> a different approach:
>
> > dmesg | grep -i hash
> PID hash table entries: 4096 (order: 12, 131072 bytes)
> Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
> Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
> Mount-cache hash table entries: 256
> Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
> IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
> TCP established hash table entries: 262144 (order: 9, 2097152 bytes)
> TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
> TCP: Hash tables configured (established 262144 bind 65536)
>
> e.g. the dentry/inode hashes are an obvious attack point.
>
> Of course you'll need benchmarks that actually stress them.
>
> -Andi
>


-- 
Motivation will almost always beat mere talent.
