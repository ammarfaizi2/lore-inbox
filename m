Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030386AbWILTwd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030386AbWILTwd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 15:52:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030392AbWILTwd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 15:52:33 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:46789 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030386AbWILTwc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 15:52:32 -0400
Date: Tue, 12 Sep 2006 12:52:14 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Alok Kataria <alok.kataria@calsoftinc.com>,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       Christoph Lameter <clameter@engr.sgi.com>
Subject: Re: [patch] slab: Do not use mempolicy for kmalloc_node
In-Reply-To: <20060912195246.GA4039@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0609121251160.12388@schroedinger.engr.sgi.com>
References: <20060912144518.GA4653@localhost.localdomain>
 <Pine.LNX.4.64.0609121034290.11278@schroedinger.engr.sgi.com>
 <20060912195246.GA4039@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Sep 2006, Ravikiran G Thirumalai wrote:

> On Tue, Sep 12, 2006 at 10:36:54AM -0700, Christoph Lameter wrote:
> > On Tue, 12 Sep 2006, Ravikiran G Thirumalai wrote:
> > 
> > ... 
> > This is not complete. Please see the discussion on GFP_THISNODE and the 
> > related patch to fix this issue 
> > http://marc.theaimsgroup.com/?l=linux-mm&m=115505682122540&w=2
> 
> Hmm, I see, but with the above patch, if we ignore mempolicy for 
> __GFP_THISNODE slab caches at alternate_node_alloc (which is pretty much 
> all the slab caches) then we would be ignoring memplocies altogether no?

We are implementing memory policies in the slab layer. I.e. we 
are taking slab objects round robin from the per node lists of the 
slab.

