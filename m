Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751659AbWFVGPa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751659AbWFVGPa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 02:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751664AbWFVGPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 02:15:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18659 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751659AbWFVGP3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 02:15:29 -0400
Date: Wed, 21 Jun 2006 23:15:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: a.p.zijlstra@chello.nl, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       hugh@veritas.com, dhowells@redhat.com, christoph@lameter.com,
       mbligh@google.com, npiggin@suse.de, torvalds@osdl.org
Subject: Re: [PATCH 1/6] mm: tracking shared dirty pages
Message-Id: <20060621231500.7d00dba4.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606212305240.25441@schroedinger.engr.sgi.com>
References: <20060619175243.24655.76005.sendpatchset@lappy>
	<20060619175253.24655.96323.sendpatchset@lappy>
	<20060621225639.4c8bad93.akpm@osdl.org>
	<Pine.LNX.4.64.0606212305240.25441@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2006 23:07:37 -0700 (PDT)
Christoph Lameter <clameter@sgi.com> wrote:

> On Wed, 21 Jun 2006, Andrew Morton wrote:
> 
> > Performance testing is critical here.  I think some was done, but I don't
> > reall what tests were performed, nor do I remember the results.  Without such
> > info it's not possible to make a go/no-go decision.
> 
> Tests did show that there was no performance regression for the usual 
> tests. That is to be expected since the patch should only modify the 
> behavior of shared writable mapping. The use of those is rare in typical 
> benchmarks.

Of course.  In this case one should prepare an artificial microbenchmark so
we can understand the worst case.
