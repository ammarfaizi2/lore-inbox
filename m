Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261814AbVCQI5r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261814AbVCQI5r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 03:57:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261874AbVCQI5q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 03:57:46 -0500
Received: from mta2.cl.cam.ac.uk ([128.232.0.14]:7336 "EHLO mta2.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S261814AbVCQI5o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 03:57:44 -0500
In-Reply-To: <42390A65.7090501@osdl.org>
References: <E1DBX27-0000te-00@mta1.cl.cam.ac.uk> <42390A65.7090501@osdl.org>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <95cdf61bd30e7b47c7ec360eddbcf542@cl.cam.ac.uk>
Content-Transfer-Encoding: 7bit
Cc: akpm@osdl.org, Ian.Pratt@cl.cam.ac.uk, linux-kernel@vger.kernel.org,
       riel@redhat.com, kurt@garloff.de, Christian.Limpach@cl.cam.ac.uk
From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Subject: Re: [PATCH] Xen/i386 cleanups - io_remap_pfn_range
Date: Thu, 17 Mar 2005 09:00:40 +0000
To: "Randy.Dunlap" <rddunlap@osdl.org>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 17 Mar 2005, at 04:41, Randy.Dunlap wrote:

> Our io_remap_pfn_range() patches don't contain many collisions.
> My first patch [adding io_remap_pfn_range() to all arches]
> <http://marc.theaimsgroup.com/?l=linux-mm&m=111049473410099&w=2>
> does go a little further than yours in that regard.
>
> Also, I was under the impression (only, so this is a question)
> that this type of construct (from your patch):
>
> +#ifndef io_remap_pfn_range
> +#define io_remap_pfn_range remap_pfn_range
> +#endif
>
> only works for #defines (macros), while in some arches
> io_remap_page_range() (and presumably io_remap_pfn_range)
> is a function [sparc32/64] or inline function [mips].
>
> My first patch referenced a future patch to convert
> all callers of io_remap_page_range() to io_remap_pfn_range(),
> which I have now done and built succesfully on 8 arches.
> I'll post it now.

The way in which you introduce io_remap_pfn_range() into all 
architectures is much better than my method, and doesn't depend on 
io_remap_pfn_range being a macro.
Apart from that, yes: our driver patches are quite disjoint and 
complement each other.
Hopefully a combined patch could eliminate some of the 'ifdef sparc's 
that are scattered around. :-)

  -- Keir

