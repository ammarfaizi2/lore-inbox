Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267511AbUHEVOO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267511AbUHEVOO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 17:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267973AbUHEVLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 17:11:49 -0400
Received: from fw.osdl.org ([65.172.181.6]:1925 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267991AbUHEVKg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 17:10:36 -0400
Date: Thu, 5 Aug 2004 14:13:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, jbarnes@engr.sgi.com
Subject: Re: [PATCH] don't pass mem_map into init functions
Message-Id: <20040805141336.1687cbbc.akpm@osdl.org>
In-Reply-To: <1091581282.27397.6676.camel@nighthawk>
References: <1091581282.27397.6676.camel@nighthawk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <haveblue@us.ibm.com> wrote:
>
> When using CONFIG_NONLINEAR, a zone's mem_map isn't contiguous, and
> isn't allocated in the same place.  This means that nonlinear doesn't
> really have a mem_map[] to pass into free_area_init_node() or 
> memmap_init_zone() which makes any sense.  

argh, sorry.  It's this patch which I dropped due to psychedelic screen
syndrome.  The "break out zone free list initialization" patch is innocent, and
was included in rc3-mm1.
