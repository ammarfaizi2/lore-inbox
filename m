Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263066AbVCEAU2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263066AbVCEAU2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 19:20:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263396AbVCEARr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 19:17:47 -0500
Received: from fire.osdl.org ([65.172.181.4]:19386 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263264AbVCDXoB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 18:44:01 -0500
Date: Fri, 4 Mar 2005 15:43:46 -0800
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.11-mm1 ext3 writepages support for writeback mode
Message-Id: <20050304154346.488b0a14.akpm@osdl.org>
In-Reply-To: <1109978510.7236.18.camel@dyn318077bld.beaverton.ibm.com>
References: <1109978510.7236.18.camel@dyn318077bld.beaverton.ibm.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty <pbadari@us.ibm.com> wrote:
>
> Hi Andrew,
> 
> Here is the 2.6.11-mm1 patch for adding writepages support
> for ext3 writeback mode. Could you include it in -mm tree ?

spose so.  Does it work?

Do you have any benchmarking results handy?

> +static int
> +ext3_writeback_writepages(struct address_space *mapping, 
> +				struct writeback_control *wbc)
> +{
> +	struct inode *inode = mapping->host;
> +	handle_t *handle = NULL;
> +	int err, ret = 0;
> +
> +	if (!mapping_tagged(mapping, PAGECACHE_TAG_DIRTY))
> +		return ret;

Can we please add a comment explaining why this is here?  I've already
forgotten why we put it there.
