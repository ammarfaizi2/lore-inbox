Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750841AbVKQOOX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750841AbVKQOOX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 09:14:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbVKQOOX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 09:14:23 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:40920 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750835AbVKQOOW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 09:14:22 -0500
Subject: Re: [PATCH] mm: populated_zone
From: Dave Hansen <haveblue@us.ibm.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <200511180101.43084.kernel@kolivas.org>
References: <200511180101.43084.kernel@kolivas.org>
Content-Type: text/plain
Date: Thu, 17 Nov 2005 15:14:14 +0100
Message-Id: <1132236854.5834.67.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-11-18 at 01:01 +1100, Con Kolivas wrote:
> +static inline int populated_zone(struct zone *zone)
> +{
> +	return (!!zone->present_pages);
> +}

I really like when people do (zone->present_pages != 0) instead.  I
always do a double-take at the !! stuff.  Hard to understand at a
glance.

A good patch otherwise.  I had to go change a bunch of reference to
present_pages to spanned_pages when testing memory hotplug, and this
would make doing that much easier.

-- Dave

