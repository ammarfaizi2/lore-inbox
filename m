Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262549AbUKRBXG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262549AbUKRBXG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 20:23:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262661AbUKRBXF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 20:23:05 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:49043 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262549AbUKRBUf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 20:20:35 -0500
Subject: Re: [patch 4/4] Xen core patch : /dev/mem calls io_remap_page_range
From: Dave Hansen <haveblue@us.ibm.com>
To: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Keir.Fraser@cl.cam.ac.uk,
       Christian.Limpach@cl.cam.ac.uk
In-Reply-To: <E1CUajU-0005vu-00@mta1.cl.cam.ac.uk>
References: <E1CUajU-0005vu-00@mta1.cl.cam.ac.uk>
Content-Type: text/plain
Message-Id: <1100740828.12373.269.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 17 Nov 2004 17:20:28 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-11-17 at 17:05, Ian Pratt wrote:
> If there really are no uses, an alternative patch would be to
> introduce an ARCH_HAS_REMAP_PAGE_RANGE. Would this be preferable?

Well, first of all, remap_page_range() is now deprecated, so some of
this might not even be relevant.  :) 

My only worry is that you might want *all* calls to
remap_page/pfn_range() to be to io_remap_page/pfn_range() for your
arch.  If this isn't the case, then there really isn't an issue.  And,
yes, mem.c is a mess.

Thanks for the explanation.

-- Dave

