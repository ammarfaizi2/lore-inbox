Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262761AbUKRM6F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262761AbUKRM6F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 07:58:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262765AbUKRM6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 07:58:05 -0500
Received: from holomorphy.com ([207.189.100.168]:33152 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262761AbUKRM6D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 07:58:03 -0500
Date: Thu, 18 Nov 2004 04:57:35 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Cc: Andrew Morton <akpm@osdl.org>, Ian Pratt <m+Ian.Pratt@cl.cam.ac.uk>,
       Keir.Fraser@cl.cam.ac.uk, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, Christian.Limpach@cl.cam.ac.uk
Subject: Re: [patch 2] Xen core patch : arch_free_page return value
Message-ID: <20041118125735.GD2268@holomorphy.com>
References: <20041118103620.GC3217@holomorphy.com> <E1CUlkn-0007sb-00@mta1.cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1CUlkn-0007sb-00@mta1.cl.cam.ac.uk>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2004 at 12:51:12PM +0000, Ian Pratt wrote:
> Having pulled the latest snapshot, it's good to see that
> remap_pfn_range has cleaned things up a bit. However, it doesn't
> solve our problem.
> In arch xen we need to use a different function for mapping MMIO
> or BIOS pages, which is the /dev/mem behaviour we need to
> support.
> I'm not sure we can do this without changing the call in mem.c,
> at least not without adding an extra hook inside remap_pfn_range
> that allows us to use an alternative to set_pte e.g. slow_set_pte
> that tries to figure out whether the pfn is real memory or
> not. Personally I think the mem.c #ifdef is cleaner and more
> robust. 
> I'm not sure I understand the issue about io_remap_page_range
> having an architecture-specific calling convention. Please can
> you enlighten me.

On some architectures it takes 5 arguments, and on others, 6.
It won't compile everywhere without an #ifdef.


-- wli
