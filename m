Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932221AbVI2Sim@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbVI2Sim (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 14:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932457AbVI2Sim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 14:38:42 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:32727 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932221AbVI2Sil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 14:38:41 -0400
Date: Thu, 29 Sep 2005 11:38:12 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
cc: Petr Vandrovec <vandrove@vc.cvut.cz>, Andrew Morton <akpm@osdl.org>,
       alokk@calsoftinc.com, linux-kernel@vger.kernel.org,
       manfred@colorfullife.com,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       ananth@in.ibm.com, Andi Kleen <ak@suse.de>, bos@serpentine.com
Subject: Re: 2.6.14-rc1-git-now still dying in mm/slab - this time line 1849
In-Reply-To: <20050929181137.GD3651@localhost.localdomain>
Message-ID: <Pine.LNX.4.62.0509291136560.20642@schroedinger.engr.sgi.com>
References: <20050916230809.789d6b0b.akpm@osdl.org> <432EE103.5020105@vc.cvut.cz>
 <20050919112912.18daf2eb.akpm@osdl.org> <Pine.LNX.4.62.0509191141380.26105@schroedinger.engr.sgi.com>
 <20050919122847.4322df95.akpm@osdl.org> <Pine.LNX.4.62.0509191351440.26388@schroedinger.engr.sgi.com>
 <20050919221614.6c01c2d1.akpm@osdl.org> <43301578.8040305@vc.cvut.cz>
 <20050928210245.GA3760@localhost.localdomain> <433C1999.2060201@vc.cvut.cz>
 <20050929181137.GD3651@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Sep 2005, Ravikiran G Thirumalai wrote:

> Hmmm.  Another data point for this bug.  Bryan, who encountered the same bug
> on his box just tried 2.6.13 stock + numa slab patches from 2.6.13-mm s, and 
> apparently, the kernel booted up on his opteron.  So I guess we should 
> concentrate on  the x86_64 bootup part.

Careful with the patchsets. Some of them contain my fix that masks the 
problem. Be sure to either have the WARN_ON statements in there that 
check for valid node numers or use a version before I added the node 
parameter to free_block.
