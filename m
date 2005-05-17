Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262025AbVEQXwq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262025AbVEQXwq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 19:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261748AbVEQXuh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 19:50:37 -0400
Received: from graphe.net ([209.204.138.32]:46603 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S262025AbVEQXtn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 19:49:43 -0400
Date: Tue, 17 May 2005 16:49:23 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Matthew Dobson <colpatch@us.ibm.com>
cc: Dave Hansen <haveblue@us.ibm.com>, "Martin J. Bligh" <mbligh@mbligh.org>,
       Jesse Barnes <jbarnes@virtuousgeek.org>,
       Christoph Lameter <clameter@engr.sgi.com>,
       Andy Whitcroft <apw@shadowen.org>, Andrew Morton <akpm@osdl.org>,
       linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       shai@scalex86.org, steiner@sgi.com
Subject: Re: NUMA aware slab allocator V3
In-Reply-To: <428A800D.8050902@us.ibm.com>
Message-ID: <Pine.LNX.4.62.0505171648370.17681@graphe.net>
References: <Pine.LNX.4.58.0505110816020.22655@schroedinger.engr.sgi.com> 
 <Pine.LNX.4.62.0505161046430.1653@schroedinger.engr.sgi.com> 
 <714210000.1116266915@flay> <200505161410.43382.jbarnes@virtuousgeek.org> 
 <740100000.1116278461@flay>  <Pine.LNX.4.62.0505161713130.21512@graphe.net>
 <1116289613.26955.14.camel@localhost> <428A800D.8050902@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 May 2005, Matthew Dobson wrote:

> You're right, Dave.  The series of #defines at the top resolve to the same
> thing as numa_node_id().  Adding the above #defines will serve only to
> obfuscate the code.

Ok.
 
> Another thing that will really help, Christoph, would be replacing all your
> open-coded for (i = 0; i < MAX_NUMNODES/NR_CPUS; i++) loops.  We have
> macros that make that all nice and clean and (should?) do the right thing
> for various combinations of SMP/DISCONTIG/NUMA/etc.  Use those and if they
> DON'T do the right thing, please let me know and we'll fix them ASAP.

Some of that was already done but I can check again.
