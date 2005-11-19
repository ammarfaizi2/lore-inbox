Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161234AbVKSDZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161234AbVKSDZK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 22:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161235AbVKSDZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 22:25:10 -0500
Received: from holomorphy.com ([66.93.40.71]:53216 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S1161234AbVKSDZI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 22:25:08 -0500
Date: Fri, 18 Nov 2005 19:24:30 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Eric Paris <eparis@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix race in set_max_huge_pages for multiple updaters of nr_huge_pages
Message-ID: <20051119032430.GM6916@holomorphy.com>
References: <1132336300.5151.47.camel@localhost.localdomain> <20051118190950.2cff4e54.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051118190950.2cff4e54.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2005 at 07:09:50PM -0800, Andrew Morton wrote:
> Nope, alloc_fresh_huge_page() does a GFP_HIGHUSER allocation, which can
> sleep and may not be called inside spinlock.  You would have seen a spew of
> might_sleep() warnings if this was tested with the appropriate kernel
> debugging options.
> How about this?

Looks good. My reply got stuck behind a queue of other things to do
since it needed a correction.

Acked-by: William Irwin <wli@holomorphy.com>


-- wli
