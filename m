Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261627AbUKTCFq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261627AbUKTCFq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 21:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262812AbUKTCFf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 21:05:35 -0500
Received: from holomorphy.com ([207.189.100.168]:26752 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262820AbUKTCD3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 21:03:29 -0500
Date: Fri, 19 Nov 2004 18:03:22 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Cc: linux-kernel@vger.kernel.org, Steven.Hand@cl.cam.ac.uk,
       Christian.Limpach@cl.cam.ac.uk, Keir.Fraser@cl.cam.ac.uk
Subject: Re: [4/7] Xen VMM patch set : /dev/mem io_remap_page_range for CONFIG_XEN
Message-ID: <20041120020322.GB2714@holomorphy.com>
References: <E1CVHzW-0004XC-00@mta1.cl.cam.ac.uk> <E1CVI5c-0004bf-00@mta1.cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1CVI5c-0004bf-00@mta1.cl.cam.ac.uk>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2004 at 11:22:51PM +0000, Ian Pratt wrote:
> This patch modifies /dev/mem to call io_remap_page_range rather than
> remap_pfn_range under CONFIG_XEN.  This is required because in arch
> xen we need to use a different function for mapping MMIO space vs
> mapping psueudo-physical memory.  This allows the X server and other
> programs that use /dev/mem for MMIO to work under Xen.
> Signed-off-by: ian.pratt@cl.cam.ac.uk

This is safe from the io_remap_page_range() calling convention skew.
All good.


-- wli
