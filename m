Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261624AbVAXVdS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbVAXVdS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 16:33:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261595AbVAXVbe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 16:31:34 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:40083 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261633AbVAXUeF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 15:34:05 -0500
Date: Mon, 24 Jan 2005 12:33:47 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: "David S. Miller" <davem@davemloft.net>
cc: akpm@osdl.org, hugh@veritas.com, linux-ia64@vger.kernel.org,
       torvalds@osdl.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: Extend clear_page by an order parameter
In-Reply-To: <20050124122350.1142ee81.davem@davemloft.net>
Message-ID: <Pine.LNX.4.58.0501241232330.17210@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0501041512450.1536@schroedinger.engr.sgi.com>
 <Pine.LNX.4.44.0501082103120.5207-100000@localhost.localdomain>
 <20050108135636.6796419a.davem@davemloft.net>
 <Pine.LNX.4.58.0501211210220.25925@schroedinger.engr.sgi.com>
 <20050122234517.376ef3f8.akpm@osdl.org> <Pine.LNX.4.58.0501240835041.15963@schroedinger.engr.sgi.com>
 <20050124122350.1142ee81.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jan 2005, David S. Miller wrote:

> On Mon, 24 Jan 2005 08:37:15 -0800 (PST)
> Christoph Lameter <clameter@sgi.com> wrote:
>
> > Then it may also be better to pass the page struct to clear_pages
> > instead of a memory address.
>
> What is more generally available at the call sites at this time?
> Consider both HIGHMEM and non-HIGHMEM setups in your estimation
> please :-)

The only call site is prep_zero_page which has a GFP flag, the order and
the pointer to struct page.

The patch makes the huge page code call prep_zero_page and scrubd will
also call prep_zero_page.
