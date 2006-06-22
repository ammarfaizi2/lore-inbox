Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751893AbWFVTYj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751893AbWFVTYj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 15:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751894AbWFVTYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 15:24:38 -0400
Received: from sbz-30.cs.helsinki.fi ([128.214.9.98]:39348 "EHLO
	sbz-30.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1751893AbWFVTYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 15:24:37 -0400
Date: Thu, 22 Jun 2006 22:24:36 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Christoph Lameter <clameter@sgi.com>
cc: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@kvack.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Theodore Tso <tytso@mit.edu>,
       Dave Chinner <dgc@sgi.com>, Andi Kleen <ak@suse.de>
Subject: Re: [RFC 3/4] Add checks to current destructor uses
In-Reply-To: <20060619184707.23130.81359.sendpatchset@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0606222223420.5385@sbz-30.cs.Helsinki.FI>
References: <20060619184651.23130.62875.sendpatchset@schroedinger.engr.sgi.com>
 <20060619184707.23130.81359.sendpatchset@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jun 2006, Christoph Lameter wrote:
> slab: Add checks to current destructor uses
> 
> We will be adding new destructor options soon. So insure that all
> existing destructors only react to SLAB_DTOR_DESTROY.

Hmm, I don't see the slab allocator passing SLAB_DTOR_DESTROY anywhere in 
this patch?  Please don't introduce changesets that break the kernel.  
It's bad for stuff like git bisect.

					Pekka
