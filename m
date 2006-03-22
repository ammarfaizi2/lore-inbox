Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751262AbWCVPD5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbWCVPD5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 10:03:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbWCVPDc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 10:03:32 -0500
Received: from ns1.suse.de ([195.135.220.2]:63903 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751262AbWCVPD3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 10:03:29 -0500
From: Andi Kleen <ak@suse.de>
To: virtualization@lists.osdl.org
Subject: Re: [RFC PATCH 32/35] Add Xen driver utility functions.
Date: Wed, 22 Mar 2006 15:12:12 +0100
User-Agent: KMail/1.9.1
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>,
       jbeulich@novell.com
References: <20060322063040.960068000@sorel.sous-sol.org> <20060322063806.845778000@sorel.sous-sol.org>
In-Reply-To: <20060322063806.845778000@sorel.sous-sol.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603221512.13287.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 22 March 2006 07:31, Chris Wright wrote:

> +	/*
> +	 * Ensure that the page tables are mapped into the current mm. The
> +	 * page-fault path will copy the page directory pointers from init_mm.
> +	 */
> +	for (i = 0; i < area->size; i += PAGE_SIZE)
> +		(void)__get_user(c, (char __user *)area->addr + i);

It would be easier and simpler to just copy the pgd manually. 

Iirc Jan B. had a patch for a vmalloc_sync() function for this purpose, maybe
that one could be used.

-Andi

