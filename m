Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265995AbUAEWx5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 17:53:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265994AbUAEWx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 17:53:57 -0500
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:9396 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S265985AbUAEWxt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 17:53:49 -0500
Date: Mon, 5 Jan 2004 14:53:40 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: colpatch@us.ibm.com, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@digeo.com>
Subject: Re: [TRIVIAL PATCH] Ensure pfn_to_nid() is always defined for i386
Message-ID: <20040105225340.GB1882@matchmail.com>
Mail-Followup-To: "Martin J. Bligh" <mbligh@aracnet.com>,
	colpatch@us.ibm.com, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@digeo.com>
References: <3FE74984.3000602@us.ibm.com> <1814780000.1072139199@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1814780000.1072139199@flay>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 22, 2003 at 04:26:40PM -0800, Martin J. Bligh wrote:
> + * for now assume that 64Gb is max amount of RAM for whole system
> + *    64Gb / 4096bytes/page = 16777216 pages
> + */
> +#define MAX_NR_PAGES 16777216
> +#define MAX_ELEMENTS 256
> +#define PAGES_PER_ELEMENT (MAX_NR_PAGES/MAX_ELEMENTS)

Why not do the calculation in the define, and use PAGE_SIZE?

If PAGE_SIZE isn't 4k will it break the rest of this code, or will the
calculations make sence with larger PAGE_SIZE?

Might as well make it easier to go in the direction of variable PAGE_SIZE
instead of keeping the assumption.
