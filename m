Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932284AbVI2SL6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932284AbVI2SL6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 14:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932312AbVI2SL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 14:11:58 -0400
Received: from serv01.siteground.net ([70.85.91.68]:37029 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S932284AbVI2SL5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 14:11:57 -0400
Date: Thu, 29 Sep 2005 11:11:37 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: Andrew Morton <akpm@osdl.org>, Christoph Lameter <clameter@engr.sgi.com>,
       alokk@calsoftinc.com, linux-kernel@vger.kernel.org,
       manfred@colorfullife.com,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       ananth@in.ibm.com, Andi Kleen <ak@suse.de>, bos@serpentine.com
Subject: Re: 2.6.14-rc1-git-now still dying in mm/slab - this time line 1849
Message-ID: <20050929181137.GD3651@localhost.localdomain>
References: <20050916230809.789d6b0b.akpm@osdl.org> <432EE103.5020105@vc.cvut.cz> <20050919112912.18daf2eb.akpm@osdl.org> <Pine.LNX.4.62.0509191141380.26105@schroedinger.engr.sgi.com> <20050919122847.4322df95.akpm@osdl.org> <Pine.LNX.4.62.0509191351440.26388@schroedinger.engr.sgi.com> <20050919221614.6c01c2d1.akpm@osdl.org> <43301578.8040305@vc.cvut.cz> <20050928210245.GA3760@localhost.localdomain> <433C1999.2060201@vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <433C1999.2060201@vc.cvut.cz>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2005 at 06:43:05PM +0200, Petr Vandrovec wrote:
> Ravikiran G Thirumalai wrote:
> 
> Unfortunately I must confirm that it does not fix problem.  But it pointed
> out to me another thing - proc_inode_cache stuff is put into caches
> BEFORE this code is executed.  So if anything in mm/slab.c relies
> on node_to_mask[] being valid (and if it relies on some other things
> which are set this late), it probably won't work.

Hmmm.  Another data point for this bug.  Bryan, who encountered the same bug
on his box just tried 2.6.13 stock + numa slab patches from 2.6.13-mm s, and 
apparently, the kernel booted up on his opteron.  So I guess we should 
concentrate on  the x86_64 bootup part.

Thanks,
Kiran
