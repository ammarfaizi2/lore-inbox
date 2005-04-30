Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263107AbVD3Avw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263107AbVD3Avw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 20:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263106AbVD3Avw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 20:51:52 -0400
Received: from fire.osdl.org ([65.172.181.4]:17390 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263098AbVD3Avl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 20:51:41 -0400
Date: Fri, 29 Apr 2005 17:51:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: Matthew Dobson <colpatch@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, mbligh@aracnet.com
Subject: Re: [PATCH] Remove struct reclaim_state
Message-Id: <20050429175108.242c410e.akpm@osdl.org>
In-Reply-To: <42718AA1.5010805@us.ibm.com>
References: <42718AA1.5010805@us.ibm.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Dobson <colpatch@us.ibm.com> wrote:
>
> Since shrink_slab() currently returns 0 no matter what happens,
>  I changed it to return the number of slab pages freed.

A sane cleanup, but it conflicts with vmscan-notice-slab-shrinking.patch,
which returns a different thing from shrink_slab() in order to account for
slab reclaim only causing internal fragmentation and not actually freeing
pages yet.

vmscan-notice-slab-shrinking.patch isn't quite complete yet, but we do need
to do something along these lines.  I need to get back onto it.

