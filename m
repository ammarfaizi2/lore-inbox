Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262657AbUKRBKM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262657AbUKRBKM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 20:10:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262634AbUKRBJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 20:09:29 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:36815 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262674AbUKRBEn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 20:04:43 -0500
Subject: Re: [patch 2] Xen core patch : arch_free_page return value
From: Dave Hansen <haveblue@us.ibm.com>
To: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Keir.Fraser@cl.cam.ac.uk,
       Christian.Limpach@cl.cam.ac.uk
In-Reply-To: <E1CUZXm-00053v-00@mta1.cl.cam.ac.uk>
References: <E1CUZXm-00053v-00@mta1.cl.cam.ac.uk>
Content-Type: text/plain
Message-Id: <1100739876.12373.262.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 17 Nov 2004 17:04:36 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-11-17 at 15:48, Ian Pratt wrote:
> This patch adds a return value to the existing arch_free_page function
> that indicates whether the normal free routine still has work to
> do. The only architecture that currently uses arch_free_page is arch
> 'um'. arch-xen needs this for 'foreign pages' - pages that don't
> belong to the page allocator but are instead managed by custom
> allocators.

But, you're modifying page allocator functions to do this.  Why would
you call __free_pages_ok() on a page that didn't belong to the page
allocator?

-- Dave

