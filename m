Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262544AbVAUWfw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262544AbVAUWfw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 17:35:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262532AbVAUWdg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 17:33:36 -0500
Received: from ozlabs.org ([203.10.76.45]:49383 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262564AbVAUWcH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 17:32:07 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16881.33367.660452.55933@cargo.ozlabs.ibm.com>
Date: Sat, 22 Jan 2005 09:29:43 +1100
From: Paul Mackerras <paulus@samba.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: "David S. Miller" <davem@davemloft.net>, Hugh Dickins <hugh@veritas.com>,
       akpm@osdl.org, linux-ia64@vger.kernel.org, torvalds@osdl.org,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: Extend clear_page by an order parameter
In-Reply-To: <Pine.LNX.4.58.0501211210220.25925@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0501041512450.1536@schroedinger.engr.sgi.com>
	<Pine.LNX.4.44.0501082103120.5207-100000@localhost.localdomain>
	<20050108135636.6796419a.davem@davemloft.net>
	<Pine.LNX.4.58.0501211210220.25925@schroedinger.engr.sgi.com>
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter writes:

> The zeroing of a page of a arbitrary order in page_alloc.c and in hugetlb.c may benefit from a
> clear_page that is capable of zeroing multiple pages at once (and scrubd
> too but that is now an independent patch). The following patch extends
> clear_page with a second parameter specifying the order of the page to be zeroed to allow an
> efficient zeroing of pages. Hope I caught everything....

Wouldn't it be nicer to call the version that takes the order
parameter "clear_pages" and then define clear_page(p) as
clear_pages(p, 0) ?

Paul.
