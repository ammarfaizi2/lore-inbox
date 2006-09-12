Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030293AbWILRhU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030293AbWILRhU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 13:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030294AbWILRhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 13:37:20 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:21172 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030293AbWILRhT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 13:37:19 -0400
Date: Tue, 12 Sep 2006 10:36:54 -0700 (PDT)
From: Christoph Lameter <christoph@engr.sgi.com>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Alok Kataria <alok.kataria@calsoftinc.com>,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       Christoph Lameter <clameter@engr.sgi.com>
Subject: Re: [patch] slab: Do not use mempolicy for kmalloc_node
In-Reply-To: <20060912144518.GA4653@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0609121034290.11278@schroedinger.engr.sgi.com>
References: <20060912144518.GA4653@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Sep 2006, Ravikiran G Thirumalai wrote:

> The slab should follow the specified memory policy for kmalloc allocations,
> which it does.  However, for kmalloc_node allocations, slab should
> serve the object from the requested node irrespective of memory policy.
> This seems to be broken in slab code.  Following patch fixes this.

This is not complete. Please see the discussion on GFP_THISNODE and the 
related patch to fix this issue 
http://marc.theaimsgroup.com/?l=linux-mm&m=115505682122540&w=2

