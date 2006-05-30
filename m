Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932352AbWE3RZi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352AbWE3RZi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 13:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932353AbWE3RZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 13:25:38 -0400
Received: from gold.veritas.com ([143.127.12.110]:60527 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S932352AbWE3RZh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 13:25:37 -0400
X-IronPort-AV: i="4.05,190,1146466800"; 
   d="scan'208"; a="60015125:sNHT33796200"
Date: Tue, 30 May 2006 18:25:29 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Christoph Lameter <clameter@sgi.com>
cc: David Howells <dhowells@redhat.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Christoph Lameter <christoph@lameter.com>,
       Martin Bligh <mbligh@google.com>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 1/3] mm: tracking shared dirty pages 
In-Reply-To: <Pine.LNX.4.64.0605300953390.17716@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.64.0605301819380.7566@blonde.wat.veritas.com>
References: <Pine.LNX.4.64.0605300818080.16904@schroedinger.engr.sgi.com> 
 <Pine.LNX.4.64.0605260825160.31609@schroedinger.engr.sgi.com>
 <Pine.LNX.4.64.0605250921300.23726@schroedinger.engr.sgi.com>
 <20060525135534.20941.91650.sendpatchset@lappy> <20060525135555.20941.36612.sendpatchset@lappy>
 <24747.1148653985@warthog.cambridge.redhat.com> <12042.1148976035@warthog.cambridge.redhat.com>
  <7966.1149006374@warthog.cambridge.redhat.com>
 <Pine.LNX.4.64.0605300953390.17716@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 30 May 2006 17:25:37.0090 (UTC) FILETIME=[10AE3A20:01C6840E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 May 2006, Christoph Lameter wrote:
> On Tue, 30 May 2006, David Howells wrote:
> 
> > What's wrong with my suggestion anyway?
> 
> Adds yet another method with functionality that for the most part 
> is the same as set_page_dirty().

Your original question, whether they could be combined, was a good one;
and I hoped you'd be right.  But I agree with David, they cannot, unless
we sacrifice the guarantee that one or the other is there to give.  It's
much like the relationship between ->prepare_write and ->commit_write.

Hugh
