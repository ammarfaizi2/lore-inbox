Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751106AbWCaA6f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbWCaA6f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 19:58:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbWCaA6e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 19:58:34 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:33993 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751106AbWCaA6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 19:58:33 -0500
Date: Thu, 30 Mar 2006 16:58:25 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: "Luck, Tony" <tony.luck@intel.com>
cc: David Mosberger-Tang <David.Mosberger@acm.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Zoltan Menyhart <Zoltan.Menyhart@bull.net>,
       "Boehm, Hans" <hans.boehm@hp.com>,
       "Grundler, Grant G" <grant.grundler@hp.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: RE: Synchronizing Bit operations V2
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F061AAF44@scsmsx401.amr.corp.intel.com>
Message-ID: <Pine.LNX.4.64.0603301657470.2068@schroedinger.engr.sgi.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F061AAF44@scsmsx401.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Mar 2006, Luck, Tony wrote:

> > Also some higher level functions may want to have the mode passed to them 
> > as parameters. See f.e. include/linux/buffer_head.h. Without the 
> > parameters you will have to maintain farms of definitions for all cases.
> 
> But if any part of the call chain from those higher level functions
> down to these low level functions is not inline, then the compiler
> won't be able to collapse out the "switch (mode)" ... so we'd end up
> with a ton of extra object code.

Correct. But such bitops are typically defined to be inline.
