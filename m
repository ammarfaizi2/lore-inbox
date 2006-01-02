Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750773AbWABPrE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbWABPrE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 10:47:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbWABPrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 10:47:04 -0500
Received: from mail.fh-wedel.de ([213.39.232.198]:24801 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1750773AbWABPrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 10:47:02 -0500
Date: Mon, 2 Jan 2006 16:46:48 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Andi Kleen <ak@suse.de>
Cc: Pekka J Enberg <penberg@cs.helsinki.fi>,
       Denis Vlasenko <vda@ilport.com.ua>, Eric Dumazet <dada1@cosmosbay.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [POLL] SLAB : Are the 32 and 192 bytes caches really usefull on x86_64 machines ?
Message-ID: <20060102154648.GB673@wohnheim.fh-wedel.de>
References: <7vbqzadgmt.fsf@assigned-by-dhcp.cox.net> <200601021345.44843.ak@suse.de> <Pine.LNX.4.58.0601021447440.22227@sbz-30.cs.Helsinki.FI> <200601021456.23253.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200601021456.23253.ak@suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 January 2006 14:56:22 +0100, Andi Kleen wrote:
> 
> I wasn't proposing fully dynamic slabs, just a better default set
> of slabs based on real measurements instead of handwaving (like
> the power of two slabs seemed to have been generated). With separate
> sets for 32bit and 64bit. 
> 
> Also the goal wouldn't be better performance, but just less waste of memory.

My fear would be that this leads to something like the gperf: a
perfect distribution of slab caches - until any tiny detail changes.
But maybe there is a different distribution that is "pretty good" for
all configurations and better than powers of two.

> I suspect such a move could save much more memory on small systems 
> than any of these "make fundamental debugging tools a CONFIG" patches ever.

Unlikely.  SLOB should be better than SLAB for those purposes, no
matter how you arrange the slab caches.

Jörn

-- 
Fancy algorithms are slow when n is small, and n is usually small.
Fancy algorithms have big constants. Until you know that n is
frequently going to be big, don't get fancy.
-- Rob Pike
