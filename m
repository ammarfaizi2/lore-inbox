Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965135AbWFIEET@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965135AbWFIEET (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 00:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965137AbWFIEET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 00:04:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6346 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965135AbWFIEES (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 00:04:18 -0400
Date: Thu, 8 Jun 2006 21:01:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-kernel@vger.kernel.org, hugh@veritas.com, nickpiggin@yahoo.com.au,
       linux-mm@kvack.org, ak@suse.de, marcelo.tosatti@cyclades.com,
       clameter@sgi.com
Subject: Re: [PATCH 06/14] Add per zone counters to zone node and global VM
 statistics
Message-Id: <20060608210101.155e8d4f.akpm@osdl.org>
In-Reply-To: <20060608230310.25121.77780.sendpatchset@schroedinger.engr.sgi.com>
References: <20060608230239.25121.83503.sendpatchset@schroedinger.engr.sgi.com>
	<20060608230310.25121.77780.sendpatchset@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Jun 2006 16:03:10 -0700 (PDT)
Christoph Lameter <clameter@sgi.com> wrote:

> --- linux-2.6.17-rc6-mm1.orig/mm/page_alloc.c	2006-06-08 14:29:46.317675014 -0700
> +++ linux-2.6.17-rc6-mm1/mm/page_alloc.c	2006-06-08 14:57:05.712250246 -0700
> @@ -628,6 +628,8 @@ static int rmqueue_bulk(struct zone *zon
>  	return i;
>  }
>  
> +char *vm_stat_item_descr[NR_STAT_ITEMS] = { "mapped","pagecache" };

static?
