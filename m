Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932362AbWE3RlV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932362AbWE3RlV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 13:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbWE3RlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 13:41:21 -0400
Received: from gold.veritas.com ([143.127.12.110]:4209 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S932362AbWE3RlV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 13:41:21 -0400
X-IronPort-AV: i="4.05,190,1146466800"; 
   d="scan'208"; a="60016096:sNHT29784528"
Date: Tue, 30 May 2006 18:41:13 +0100 (BST)
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
In-Reply-To: <Pine.LNX.4.64.0605301030210.17905@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.64.0605301834340.8737@blonde.wat.veritas.com>
References: <Pine.LNX.4.64.0605300818080.16904@schroedinger.engr.sgi.com> 
 <Pine.LNX.4.64.0605260825160.31609@schroedinger.engr.sgi.com>
 <Pine.LNX.4.64.0605250921300.23726@schroedinger.engr.sgi.com>
 <20060525135534.20941.91650.sendpatchset@lappy> <20060525135555.20941.36612.sendpatchset@lappy>
 <24747.1148653985@warthog.cambridge.redhat.com> <12042.1148976035@warthog.cambridge.redhat.com>
  <7966.1149006374@warthog.cambridge.redhat.com>
 <Pine.LNX.4.64.0605300953390.17716@schroedinger.engr.sgi.com>
 <Pine.LNX.4.64.0605301819380.7566@blonde.wat.veritas.com>
 <Pine.LNX.4.64.0605301030210.17905@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 30 May 2006 17:41:20.0684 (UTC) FILETIME=[431B3EC0:01C68410]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 May 2006, Christoph Lameter wrote:
> On Tue, 30 May 2006, Hugh Dickins wrote:
> 
> > Your original question, whether they could be combined, was a good one;
> > and I hoped you'd be right.  But I agree with David, they cannot, unless
> > we sacrifice the guarantee that one or the other is there to give.  It's
> > much like the relationship between ->prepare_write and ->commit_write.
> 
> Ok, so separate patch sets?

They are separate patch sets (and rc5-mm1 has David's without Peter's).
But they trample on nearby areas and share infrastructure, so I'm happy
that they're looked at together.  Peter has helpfully arranged his to
go on top of David's: that can be reversed later if it's decided that
Peter's is wanted but David's not.

Hugh
