Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750885AbWFVGID@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750885AbWFVGID (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 02:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751645AbWFVGIB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 02:08:01 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:14516 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750885AbWFVGIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 02:08:00 -0400
Date: Wed, 21 Jun 2006 23:07:37 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, hugh@veritas.com, dhowells@redhat.com,
       christoph@lameter.com, mbligh@google.com, npiggin@suse.de,
       torvalds@osdl.org
Subject: Re: [PATCH 1/6] mm: tracking shared dirty pages
In-Reply-To: <20060621225639.4c8bad93.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0606212305240.25441@schroedinger.engr.sgi.com>
References: <20060619175243.24655.76005.sendpatchset@lappy>
 <20060619175253.24655.96323.sendpatchset@lappy> <20060621225639.4c8bad93.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2006, Andrew Morton wrote:

> Performance testing is critical here.  I think some was done, but I don't
> reall what tests were performed, nor do I remember the results.  Without such
> info it's not possible to make a go/no-go decision.

Tests did show that there was no performance regression for the usual 
tests. That is to be expected since the patch should only modify the 
behavior of shared writable mapping. The use of those is rare in typical 
benchmarks.
