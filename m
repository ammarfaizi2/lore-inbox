Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030352AbWFVTwt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030352AbWFVTwt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 15:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030366AbWFVTwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 15:52:49 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:50343 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030352AbWFVTwr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 15:52:47 -0400
Date: Thu, 22 Jun 2006 12:52:12 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Pekka J Enberg <penberg@cs.helsinki.fi>
cc: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@kvack.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Theodore Tso <tytso@mit.edu>,
       Dave Chinner <dgc@sgi.com>, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 4/4] Slab Reclaim logic
In-Reply-To: <Pine.LNX.4.58.0606222247420.5385@sbz-30.cs.Helsinki.FI>
Message-ID: <Pine.LNX.4.64.0606221249560.31332@schroedinger.engr.sgi.com>
References: <20060619184651.23130.62875.sendpatchset@schroedinger.engr.sgi.com>
 <20060619184712.23130.65271.sendpatchset@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0606222234400.5385@sbz-30.cs.Helsinki.FI>
 <Pine.LNX.4.64.0606221243360.31332@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0606222247420.5385@sbz-30.cs.Helsinki.FI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2006, Pekka J Enberg wrote:

> On Thu, 22 Jun 2006, Christoph Lameter wrote:
> > > Please use struct kmem_cache instead of the typedef.  Better name for l3 
> > > would be nice.
> > 
> > l3 is a very good name.
> 
> No, it's a terrible name :-). But I guess it's ok for this patch.

Its a good name and you better come up with a another reason than 
"terrible name" before you change the established variable name in the 
slab allocator. Otherwise lots of us will have trouble reading the code.

Please make sure that all references to kmem_list3 are called consistently 
l3 thoughout the slab allocator.

