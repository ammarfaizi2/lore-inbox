Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbWABMeV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbWABMeV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 07:34:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750704AbWABMeV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 07:34:21 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:7603 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750702AbWABMeU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 07:34:20 -0500
Date: Mon, 2 Jan 2006 07:33:48 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Pekka Enberg <penberg@cs.helsinki.fi>
cc: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org,
       Eric Dumazet <dada1@cosmosbay.com>, Denis Vlasenko <vda@ilport.com.ua>,
       Andreas Kleen <ak@suse.de>, Matt Mackall <mpm@selenic.com>
Subject: Re: [POLL] SLAB : Are the 32 and 192 bytes caches really usefull on
 x86_64 machines ?
In-Reply-To: <84144f020601020051l326e163ep7cba5f2fd240dc0d@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0601020731420.9621@gandalf.stny.rr.com>
References: <7vbqzadgmt.fsf@assigned-by-dhcp.cox.net>  <43A91C57.20102@cosmosbay.com>
 <200512281032.15460.vda@ilport.com.ua>  <200512281054.26703.vda@ilport.com.ua>
  <3186311.1135792635763.SLOX.WebMail.wwwrun@imap-dhs.suse.de> 
 <20051228210124.GB1639@waste.org> <20051229012616.GA3286@redhat.com> 
 <1135915609.6039.39.camel@localhost.localdomain> 
 <84144f020601020046t3176cde2k7d9ec900cafd6d2f@mail.gmail.com>
 <84144f020601020051l326e163ep7cba5f2fd240dc0d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 2 Jan 2006, Pekka Enberg wrote:

>
> Also, wouldn't it be better to track kmem_cache_alloc and
> kmem_cache_alloc_node instead?
>

I believe they are very interested in when kmalloc and kfree are used,
since those are the ones for the generic slabs.  And even then, they are
only profiling the ones that use a dynamic allocation.  (the kmalloc and
kfree of sizeof(x) is not profiled).  This was brought up earlier in the
thread.

-- Steve

