Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261977AbVFWCv2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261977AbVFWCv2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 22:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262025AbVFWCv2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 22:51:28 -0400
Received: from mx1.redhat.com ([66.187.233.31]:18882 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261977AbVFWCvR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 22:51:17 -0400
Date: Wed, 22 Jun 2005 22:51:01 -0400 (EDT)
From: Rik Van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       andrea@suse.de, mason@suse.de
Subject: Re: [patch 1/2] vm early reclaim orphaned pages (take 2)
In-Reply-To: <1119252756.6240.27.camel@npiggin-nld.site>
Message-ID: <Pine.LNX.4.61.0506222250250.17731@chimarrao.boston.redhat.com>
References: <1118978590.5261.4.camel@npiggin-nld.site> 
 <1119252194.6240.22.camel@npiggin-nld.site> <1119252756.6240.27.camel@npiggin-nld.site>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.61.0506222250252.17731@chimarrao.boston.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jun 2005, Nick Piggin wrote:

> +       if (PageLRU(page) && PageActive(page)) {
> +               list_move(&page->lru, &zone->inactive_list);
> +               ClearPageActive(page);
> +       }

Unless I'm missing something subtle, you might want to
update zone->nr_active and zone->nr_inactive ...

-- 
The Theory of Escalating Commitment: "The cost of continuing mistakes is
borne by others, while the cost of admitting mistakes is borne by yourself."
  -- Joseph Stiglitz, Nobel Laureate in Economics
