Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751823AbWFWRwe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751823AbWFWRwe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 13:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751830AbWFWRwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 13:52:34 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:31106 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751823AbWFWRwd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 13:52:33 -0400
Date: Fri, 23 Jun 2006 10:52:08 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
cc: Hugh Dickins <hugh@veritas.com>, Linus Torvalds <torvalds@osdl.org>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Christoph Lameter <christoph@lameter.com>,
       Martin Bligh <mbligh@google.com>, Nick Piggin <npiggin@suse.de>
Subject: Re: [PATCH] mm: tracking shared dirty pages -v10
In-Reply-To: <1151083338.30819.28.camel@lappy>
Message-ID: <Pine.LNX.4.64.0606231048020.6519@schroedinger.engr.sgi.com>
References: <20060619175243.24655.76005.sendpatchset@lappy> 
 <20060619175253.24655.96323.sendpatchset@lappy> 
 <Pine.LNX.4.64.0606222126310.26805@blonde.wat.veritas.com> 
 <1151019590.15744.144.camel@lappy>  <Pine.LNX.4.64.0606222305210.6483@g5.osdl.org>
  <Pine.LNX.4.64.0606230759480.19782@blonde.wat.veritas.com> 
 <Pine.LNX.4.64.0606230955230.6265@schroedinger.engr.sgi.com>
 <1151083338.30819.28.camel@lappy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jun 2006, Peter Zijlstra wrote:

> On Fri, 2006-06-23 at 10:00 -0700, Christoph Lameter wrote:
> 
> > Also Peter has made the tracking configurable. So there is a way
> > to switch it off if it is harmful for some situations.
> 
> Oh?

mapping_cap_account_dirty is not a way for a fs to switch this on and off?

> > You mean anonymous pages? Anonymous pages are always dirty unless
> > you consider swap and we currently do not take account of dirty anonymous 
> > pages. With swap we already have performance problems and maybe there are
> > additional issues to fix in that area. But these are secondary.
> 
> I intent to make swap over NFS work next.

I am still a bit unclear on what you mean by "work." The only 
issue may be to consider the amount of swap pages about to be written out 
for write throttling.
