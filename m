Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291876AbSBTOib>; Wed, 20 Feb 2002 09:38:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291878AbSBTOiV>; Wed, 20 Feb 2002 09:38:21 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:46693 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S291876AbSBTOiP>; Wed, 20 Feb 2002 09:38:15 -0500
Date: Wed, 20 Feb 2002 14:38:58 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Rik van Riel <riel@conectiva.com.br>, dmccr@us.ibm.com,
        Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Robert Love <rml@tech9.net>, mingo@redhat.com,
        Andrew Morton <akpm@zip.com.au>, manfred@colorfullife.com,
        wli@holomorphy.com
Subject: Re: [RFC] Page table sharing
In-Reply-To: <E16dXRt-0001Lo-00@starship.berlin>
Message-ID: <Pine.LNX.4.21.0202201435230.1136-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Feb 2002, Daniel Phillips wrote:
> 
> Looking at the current try_to_swap_out code I see only a local invalidate, 
> flush_tlb_page(vma, address), why is that?  How do we know that this mm could 
> not be in context on another cpu?

I made the same mistake a few months ago: not noticing #ifndef CONFIG_SMP
in the header.  arch/i386/kernel/smp.c has the real i386 flush_tlb_page().

Hugh

