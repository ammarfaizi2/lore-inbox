Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262561AbVCIXYb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262561AbVCIXYb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 18:24:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262541AbVCIXTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 18:19:54 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:40840 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S262519AbVCIXRT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 18:17:19 -0500
Date: Wed, 9 Mar 2005 15:17:10 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Andi Kleen <ak@muc.de>
cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Page Fault Scalability patch V19 [4/4]: Drop use of page_table_lock
 in do_anonymous_page
In-Reply-To: <20050309231440.GB63395@muc.de>
Message-ID: <Pine.LNX.4.58.0503091515440.30604@schroedinger.engr.sgi.com>
References: <20050309201324.29721.28956.sendpatchset@schroedinger.engr.sgi.com>
 <20050309201344.29721.26698.sendpatchset@schroedinger.engr.sgi.com>
 <m13bv4whrl.fsf@muc.de> <Pine.LNX.4.58.0503091500040.30604@schroedinger.engr.sgi.com>
 <20050309231440.GB63395@muc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Mar 2005, Andi Kleen wrote:

> > If atomic64_t is available on all 64 bit systems then its no problem.
>
> Most of them have it already. parisc64/ppc64/sh64 are missing it,
> but I assume they will catch up quickly.

Changing the type for the countedrs is possible by only changing the
definition of MM_COUNTER_T in include/sched.h. I would prefer to wait
until atomic64_t is available on all 64 bit platforms before making that
part of this patch.


