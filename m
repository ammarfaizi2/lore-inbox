Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161215AbWFVTt7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161215AbWFVTt7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 15:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161213AbWFVTt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 15:49:59 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:36793 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1161215AbWFVTt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 15:49:57 -0400
Date: Thu, 22 Jun 2006 12:49:46 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Pekka J Enberg <penberg@cs.helsinki.fi>
cc: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@kvack.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Theodore Tso <tytso@mit.edu>,
       Dave Chinner <dgc@sgi.com>, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 4/4] Slab Reclaim logic
In-Reply-To: <Pine.LNX.4.58.0606222245150.5385@sbz-30.cs.Helsinki.FI>
Message-ID: <Pine.LNX.4.64.0606221249010.31332@schroedinger.engr.sgi.com>
References: <20060619184651.23130.62875.sendpatchset@schroedinger.engr.sgi.com>
 <20060619184712.23130.65271.sendpatchset@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0606222231390.5385@sbz-30.cs.Helsinki.FI>
 <Pine.LNX.4.64.0606221241240.31332@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0606222245150.5385@sbz-30.cs.Helsinki.FI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2006, Pekka J Enberg wrote:

> Not everyone is IA-64.  The slab allocator is already pretty memory 
> hungry so lets try not to make it any worse, ok?

We have a huge memory problem with reclain. This is only a small 
sacrifice. Moreover even on 32 bit platforms this will not be significant 
for most caches that are cache aligned.

