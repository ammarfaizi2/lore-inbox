Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161122AbWGIU0o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161122AbWGIU0o (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 16:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161123AbWGIU0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 16:26:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21121 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161122AbWGIU0n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 16:26:43 -0400
Date: Sun, 9 Jul 2006 13:21:35 -0700
From: Andrew Morton <akpm@osdl.org>
To: Cedric Le Goater <clg@fr.ibm.com>
Cc: linux-kernel@vger.kernel.org, Christoph Lameter <clameter@engr.sgi.com>
Subject: Re: 2.6.18-rc1-mm1 oops on x86_64
Message-Id: <20060709132135.6c786cfb.akpm@osdl.org>
In-Reply-To: <44B12C74.9090104@fr.ibm.com>
References: <20060709021106.9310d4d1.akpm@osdl.org>
	<44B12C74.9090104@fr.ibm.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 09 Jul 2006 18:19:00 +0200
Cedric Le Goater <clg@fr.ibm.com> wrote:

> Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc1/2.6.18-rc1-mm1/
> 
> Kernel BUG at ...home/legoater/linux/2.6.18-rc1-mm1/mm/page_alloc.c:252

	VM_BUG_ON((gfp_flags & (__GFP_WAIT | __GFP_HIGHMEM)) == __GFP_HIGHMEM);

With your config, __GFP_HIGHMEM=0, so wham.

I dunno, Christoph.  I think those patches are going to significantly
increase the number of works-with-my-config, doesnt-with-yours scenarios.

We're going to hurt ourselves if we do this.
