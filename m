Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030374AbVI3Q4N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030374AbVI3Q4N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 12:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030376AbVI3Q4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 12:56:13 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:40890 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030374AbVI3Q4M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 12:56:12 -0400
Date: Fri, 30 Sep 2005 09:55:40 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
cc: Petr Vandrovec <vandrove@vc.cvut.cz>, Andrew Morton <akpm@osdl.org>,
       alokk@calsoftinc.com, linux-kernel@vger.kernel.org,
       manfred@colorfullife.com,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       ananth@in.ibm.com, Andi Kleen <ak@suse.de>
Subject: Re: 2.6.14-rc1-git-now still dying in mm/slab - this time line 1849
In-Reply-To: <20050930054556.GA3599@localhost.localdomain>
Message-ID: <Pine.LNX.4.62.0509300955070.29430@schroedinger.engr.sgi.com>
References: <20050916230809.789d6b0b.akpm@osdl.org> <432EE103.5020105@vc.cvut.cz>
 <20050919112912.18daf2eb.akpm@osdl.org> <Pine.LNX.4.62.0509191141380.26105@schroedinger.engr.sgi.com>
 <20050919122847.4322df95.akpm@osdl.org> <Pine.LNX.4.62.0509191351440.26388@schroedinger.engr.sgi.com>
 <20050919221614.6c01c2d1.akpm@osdl.org> <43301578.8040305@vc.cvut.cz>
 <20050928210245.GA3760@localhost.localdomain> <433C1999.2060201@vc.cvut.cz>
 <20050930054556.GA3599@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Sep 2005, Ravikiran G Thirumalai wrote:

> Here is a quick fix for this.  The right fix obviously is to have
> cpu_to_node[bsp] setup early for numa_init_array().  The following patch
> will fix the problem now, and the code can stay on even when cpu_to_node{BP] 
> gets fixed early correctly.

This fixes the problem that I can produce by booting with numa=fake=2

