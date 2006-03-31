Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751085AbWCaAva@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbWCaAva (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 19:51:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751091AbWCaAva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 19:51:30 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:14026 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751085AbWCaAv3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 19:51:29 -0500
Date: Thu, 30 Mar 2006 16:51:21 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Zoltan Menyhart <Zoltan.Menyhart@bull.net>,
       "Boehm, Hans" <hans.boehm@hp.com>,
       "Grundler, Grant G" <grant.grundler@hp.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: RE: Synchronizing Bit operations V2
In-Reply-To: <200603310049.k2V0nVg26779@unix-os.sc.intel.com>
Message-ID: <Pine.LNX.4.64.0603301650220.2068@schroedinger.engr.sgi.com>
References: <200603310049.k2V0nVg26779@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Mar 2006, Chen, Kenneth W wrote:

> > It precise the uncleanness in ia64 that such semantics are attached to 
> > these bit operations which may lead people to depend on those. We need to 
> > either make these explicit or not depend on them.
> 
> I know, I'm saying since it doesn't make any difference from API point of
> view whether it is acq, rel, or no ordering, then just make them rel as a
> "preferred" Operation on ia64.

That would make the behavior of clear_bit different from other bitops and 
references to volatile pointers. I'd like to have this as consistent as 
possible.

