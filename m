Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262259AbVCIX00@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262259AbVCIX00 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 18:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262138AbVCIXZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 18:25:23 -0500
Received: from colin2.muc.de ([193.149.48.15]:54797 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S262556AbVCIXVn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 18:21:43 -0500
Date: 10 Mar 2005 00:21:41 +0100
Date: Thu, 10 Mar 2005 00:21:41 +0100
From: Andi Kleen <ak@muc.de>
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Page Fault Scalability patch V19 [4/4]: Drop use of page_table_lock in do_anonymous_page
Message-ID: <20050309232141.GD63395@muc.de>
References: <20050309201324.29721.28956.sendpatchset@schroedinger.engr.sgi.com> <20050309201344.29721.26698.sendpatchset@schroedinger.engr.sgi.com> <m13bv4whrl.fsf@muc.de> <Pine.LNX.4.58.0503091500040.30604@schroedinger.engr.sgi.com> <20050309231440.GB63395@muc.de> <Pine.LNX.4.58.0503091515440.30604@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0503091515440.30604@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2005 at 03:17:10PM -0800, Christoph Lameter wrote:
> On Wed, 10 Mar 2005, Andi Kleen wrote:
> 
> > > If atomic64_t is available on all 64 bit systems then its no problem.
> >
> > Most of them have it already. parisc64/ppc64/sh64 are missing it,
> > but I assume they will catch up quickly.
> 
> Changing the type for the countedrs is possible by only changing the
> definition of MM_COUNTER_T in include/sched.h. I would prefer to wait
> until atomic64_t is available on all 64 bit platforms before making that
> part of this patch.

Well, they will not move until someone uses it (especially parisc
and sh64 which always are quite out of sync in mainline). ppc64 
usually moves quickly.

But adding arbitary limits like this even temporarily is imho
a bad idea.

-Andi
