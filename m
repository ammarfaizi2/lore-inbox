Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751888AbWFWSXY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751888AbWFWSXY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 14:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751892AbWFWSXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 14:23:24 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:37515 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751888AbWFWSXX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 14:23:23 -0400
Date: Fri, 23 Jun 2006 11:23:01 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
cc: Linus Torvalds <torvalds@osdl.org>, Hugh Dickins <hugh@veritas.com>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Martin Bligh <mbligh@google.com>, Nick Piggin <npiggin@suse.de>,
       riel <riel@redhat.com>
Subject: Re: [PATCH] mm: tracking shared dirty pages -v10
In-Reply-To: <1151085829.30819.33.camel@lappy>
Message-ID: <Pine.LNX.4.64.0606231121170.6877@schroedinger.engr.sgi.com>
References: <20060619175243.24655.76005.sendpatchset@lappy> 
 <20060619175253.24655.96323.sendpatchset@lappy> 
 <Pine.LNX.4.64.0606222126310.26805@blonde.wat.veritas.com> 
 <1151019590.15744.144.camel@lappy>  <Pine.LNX.4.64.0606222305210.6483@g5.osdl.org>
  <Pine.LNX.4.64.0606230759480.19782@blonde.wat.veritas.com> 
 <Pine.LNX.4.64.0606230955230.6265@schroedinger.engr.sgi.com> 
 <1151083338.30819.28.camel@lappy>  <Pine.LNX.4.64.0606231055520.6483@g5.osdl.org>
 <1151085829.30819.33.camel@lappy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jun 2006, Peter Zijlstra wrote:

> But the general idea is that its broken because the ACK from writeout
> can be delayed and the remaining free memory taken by other incomming
> network packets.

That is already taken care of by nr_unstable which is considered for 
write throttling.
