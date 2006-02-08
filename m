Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030525AbWBHTHm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030525AbWBHTHm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 14:07:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030545AbWBHTHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 14:07:42 -0500
Received: from ns1.suse.de ([195.135.220.2]:27829 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030525AbWBHTHl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 14:07:41 -0500
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@engr.sgi.com>
Subject: Re: Terminate process that fails on a constrained allocation
Date: Wed, 8 Feb 2006 20:01:35 +0100
User-Agent: KMail/1.8.2
Cc: Paul Jackson <pj@sgi.com>, akpm@osdl.org, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.62.0602081004060.2648@schroedinger.engr.sgi.com> <20060208103448.588fdfa7.pj@sgi.com> <Pine.LNX.4.62.0602081053260.3590@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0602081053260.3590@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602082001.36236.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 February 2006 19:54, Christoph Lameter wrote:

> Index: linux-2.6.16-rc2/mm/page_alloc.c
> ===================================================================
> --- linux-2.6.16-rc2.orig/mm/page_alloc.c	2006-02-02 22:03:08.000000000 -0800
> +++ linux-2.6.16-rc2/mm/page_alloc.c	2006-02-08 10:53:08.000000000 -0800
> @@ -817,6 +818,27 @@ failed:
>  #define ALLOC_CPUSET		0x40 /* check for correct cpuset */
>  
>  /*
> + * check if a given zonelist allows allocation over all the nodes
> + * in the system.
> + */
> +int zonelist_incomplete(struct zonelist *zonelist, gfp_t gfp_mask)

static noinline

-Andi

