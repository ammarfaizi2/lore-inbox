Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbWBFITq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbWBFITq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 03:19:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750737AbWBFITq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 03:19:46 -0500
Received: from holomorphy.com ([66.93.40.71]:37069 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S1750708AbWBFITp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 03:19:45 -0500
Date: Mon, 6 Feb 2006 00:19:39 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: Hugepages need clear_user_highpage() not clear_highpage()
Message-ID: <20060206081939.GA6789@holomorphy.com>
References: <20060206021853.GC10708@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060206021853.GC10708@localhost.localdomain>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2006 at 01:18:53PM +1100, David Gibson wrote:
> When hugepages are newly allocated to a file in mm/hugetlb.c, we clear
> them with a call to clear_highpage() on each of the subpages.  We
> should be using clear_user_highpage(): on powerpc, at least,
> clear_highpage() doesn't correctly mark the page as icache dirty so if
> the page is executed shortly after it's possible to get strange
> results.
> This is a bugfix and should go into 2.6.16.
> Signed-off-by: David Gibson <dwg@au1.ibm.com>

Not sure how this got past the usual crapfilters. Sorry about that.

Acked-by: William Irwin <wli@holomorphy.com>


-- wli
