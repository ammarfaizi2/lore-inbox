Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269502AbUI3VQr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269502AbUI3VQr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 17:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269517AbUI3VQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 17:16:43 -0400
Received: from cantor.suse.de ([195.135.220.2]:25549 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S269502AbUI3VPi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 17:15:38 -0400
Date: Thu, 30 Sep 2004 23:12:28 +0200
From: Andi Kleen <ak@suse.de>
To: Matthew Dobson <colpatch@us.ibm.com>
Cc: Andi Kleen <ak@suse.de>, Nick Piggin <nickpiggin@yahoo.com.au>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: [RFC PATCH] sched_domains: Make SD_NODE_INIT per-arch
Message-ID: <20040930211228.GE28315@wotan.suse.de>
References: <1096420339.15060.139.camel@arrakis> <415BC0BC.6040902@yahoo.com.au> <1096569412.20097.13.camel@arrakis> <20040930204502.GD28315@wotan.suse.de> <1096578415.20964.9.camel@arrakis>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1096578415.20964.9.camel@arrakis>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well, you can certainly base the x86_64 CMP values on the current
> SD_SIBLING_INIT values.  Those are well publicized, see
> include/linux/sched.h! ;)

Current BK has it in kernel/sched.c.

And it also broke NUMA kernels on UP, but that's a different issue.

> I suppose it would be pretty trivial to define defaults in
> include/asm-generic/topology.h, and allow arches that care to define
> their own SD_*_INITs without disrupting anyone else.  Actually, that's
> far better than what I've got now.  I'll run that patch up after the
> meeting I'm currently late for and post it in a couple hours.

Full override isn't good imho because it could lead to bit rot, 
better is to have defaults that can be used as a base, but tweaked.


-Andi
