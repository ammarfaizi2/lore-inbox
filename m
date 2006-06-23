Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751832AbWFWSDy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751832AbWFWSDy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 14:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751834AbWFWSDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 14:03:54 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:30942 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S1751832AbWFWSDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 14:03:53 -0400
Subject: Re: [PATCH] mm: tracking shared dirty pages -v10
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Christoph Lameter <clameter@sgi.com>, Hugh Dickins <hugh@veritas.com>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Christoph Lameter <christoph@lameter.com>,
       Martin Bligh <mbligh@google.com>, Nick Piggin <npiggin@suse.de>,
       riel <riel@redhat.com>
In-Reply-To: <Pine.LNX.4.64.0606231055520.6483@g5.osdl.org>
References: <20060619175243.24655.76005.sendpatchset@lappy>
	 <20060619175253.24655.96323.sendpatchset@lappy>
	 <Pine.LNX.4.64.0606222126310.26805@blonde.wat.veritas.com>
	 <1151019590.15744.144.camel@lappy>
	 <Pine.LNX.4.64.0606222305210.6483@g5.osdl.org>
	 <Pine.LNX.4.64.0606230759480.19782@blonde.wat.veritas.com>
	 <Pine.LNX.4.64.0606230955230.6265@schroedinger.engr.sgi.com>
	 <1151083338.30819.28.camel@lappy>
	 <Pine.LNX.4.64.0606231055520.6483@g5.osdl.org>
Content-Type: text/plain
Date: Fri, 23 Jun 2006 20:03:49 +0200
Message-Id: <1151085829.30819.33.camel@lappy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-23 at 10:56 -0700, Linus Torvalds wrote:
> 
> On Fri, 23 Jun 2006, Peter Zijlstra wrote:
> > 
> > I intent to make swap over NFS work next.
> 
> Doesn't it work already? Is there some throttling that doesn't work?

I do not know how 'bad' the situation is now that we have the dirty page
tracking stuff, still need to create a test environment.

But the general idea is that its broken because the ACK from writeout
can be delayed and the remaining free memory taken by other incomming
network packets.

Until I have a test setup and some reproducable deadlocks I cannot say
more I'm afraid.

Peter

