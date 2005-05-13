Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262363AbVEMNqh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262363AbVEMNqh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 09:46:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262364AbVEMNqh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 09:46:37 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:14785 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262363AbVEMNqf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 09:46:35 -0400
Subject: Re: NUMA aware slab allocator V2
From: Dave Hansen <haveblue@us.ibm.com>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       shai@scalex86.org, steiner@sgi.com
In-Reply-To: <Pine.LNX.4.58.0505130411300.4500@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0505110816020.22655@schroedinger.engr.sgi.com>
	 <20050512000444.641f44a9.akpm@osdl.org>
	 <Pine.LNX.4.58.0505121252390.32276@schroedinger.engr.sgi.com>
	 <20050513000648.7d341710.akpm@osdl.org>
	 <Pine.LNX.4.58.0505130411300.4500@schroedinger.engr.sgi.com>
Content-Type: text/plain
Date: Fri, 13 May 2005 06:46:17 -0700
Message-Id: <1115991978.7129.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-05-13 at 04:21 -0700, Christoph Lameter wrote:
> The definition for the number of NUMA nodes is dependent on
> CONFIG_FLATMEM instead of CONFIG_NUMA in mm.
> CONFIG_FLATMEM is not set on ppc64 because CONFIG_DISCONTIG is set! And
> consequently nodes exist in a non NUMA config.
> 
> s/CONFIG_NUMA/CONFIG_FLATMEM/ ??

FLATMEM effectively means that you have a contiguous, single mem_map[];
it isn't directly related to NUMA.

Could you point me to the code that you're looking at?  We shouldn't
have numbers of NUMA nodes is dependent on CONFIG_FLATMEM, at least
directly.  

-- Dave

