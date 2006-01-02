Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750728AbWABN4d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbWABN4d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 08:56:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750731AbWABN4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 08:56:33 -0500
Received: from cantor2.suse.de ([195.135.220.15]:49870 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750728AbWABN4c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 08:56:32 -0500
From: Andi Kleen <ak@suse.de>
To: Pekka J Enberg <penberg@cs.helsinki.fi>
Subject: Re: [POLL] SLAB : Are the 32 and 192 bytes caches really usefull on x86_64 machines ?
Date: Mon, 2 Jan 2006 14:56:22 +0100
User-Agent: KMail/1.8.2
Cc: Denis Vlasenko <vda@ilport.com.ua>, Eric Dumazet <dada1@cosmosbay.com>,
       linux-kernel@vger.kernel.org
References: <7vbqzadgmt.fsf@assigned-by-dhcp.cox.net> <200601021345.44843.ak@suse.de> <Pine.LNX.4.58.0601021447440.22227@sbz-30.cs.Helsinki.FI>
In-Reply-To: <Pine.LNX.4.58.0601021447440.22227@sbz-30.cs.Helsinki.FI>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601021456.23253.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 02 January 2006 14:04, Pekka J Enberg wrote:

> Maybe it's not. But that's besides the point. 

It was my point. I don't know what your point was.

> The specific problem Bonwick  
> mentioned is related to cache line distribution and should be taken care 
> of by slab coloring. Internal fragmentation is painful but the worst 
> offenders can be fixed with kmem_cache_alloc(). So I really don't see the 
> problem. On the other hand, I am not opposed to dynamic generic slabs if 
> you can show a clear performance benefit from it. I just doubt you will.

I wasn't proposing fully dynamic slabs, just a better default set
of slabs based on real measurements instead of handwaving (like
the power of two slabs seemed to have been generated). With separate
sets for 32bit and 64bit. 

Also the goal wouldn't be better performance, but just less waste of memory.

I suspect such a move could save much more memory on small systems 
than any of these "make fundamental debugging tools a CONFIG" patches ever.

-Andi
