Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030373AbWILTuz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030373AbWILTuz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 15:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030288AbWILTuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 15:50:55 -0400
Received: from server99.tchmachines.com ([72.9.230.178]:48098 "EHLO
	server99.tchmachines.com") by vger.kernel.org with ESMTP
	id S1030373AbWILTuy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 15:50:54 -0400
Date: Tue, 12 Sep 2006 12:52:46 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Christoph Lameter <christoph@engr.sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Alok Kataria <alok.kataria@calsoftinc.com>,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       Christoph Lameter <clameter@engr.sgi.com>
Subject: Re: [patch] slab: Do not use mempolicy for kmalloc_node
Message-ID: <20060912195246.GA4039@localhost.localdomain>
References: <20060912144518.GA4653@localhost.localdomain> <Pine.LNX.4.64.0609121034290.11278@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609121034290.11278@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server99.tchmachines.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2006 at 10:36:54AM -0700, Christoph Lameter wrote:
> On Tue, 12 Sep 2006, Ravikiran G Thirumalai wrote:
> 
> ... 
> This is not complete. Please see the discussion on GFP_THISNODE and the 
> related patch to fix this issue 
> http://marc.theaimsgroup.com/?l=linux-mm&m=115505682122540&w=2

Hmm, I see, but with the above patch, if we ignore mempolicy for 
__GFP_THISNODE slab caches at alternate_node_alloc (which is pretty much 
all the slab caches) then we would be ignoring memplocies altogether no?

Thanks,
Kiran
