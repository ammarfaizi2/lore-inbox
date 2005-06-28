Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262182AbVF1WT0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262182AbVF1WT0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 18:19:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261505AbVF1WSO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 18:18:14 -0400
Received: from graphe.net ([209.204.138.32]:32178 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S262182AbVF1WRN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 18:17:13 -0400
Date: Tue, 28 Jun 2005 15:17:05 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Jesse Barnes <jbarnes@virtuousgeek.org>
cc: "David S. Miller" <davem@davemloft.net>, nickpiggin@yahoo.com.au,
       wli@holomorphy.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch 2] mm: speculative get_page
In-Reply-To: <200506281432.30868.jbarnes@virtuousgeek.org>
Message-ID: <Pine.LNX.4.62.0506281514580.6284@graphe.net>
References: <42C0AAF8.5090700@yahoo.com.au> <42C0D717.2080100@yahoo.com.au>
 <20050627.220827.21920197.davem@davemloft.net> <200506281432.30868.jbarnes@virtuousgeek.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jun 2005, Jesse Barnes wrote:

> On ia64 at least, the unlock is only a one way barrier.  The store to 
> realease the lock uses release semantics (since the lock is declared 
> volatile), which implies that prior stores are visible before the 
> unlock occurs, but subsequent accesses can 'float up' above the unlock.  
> See http://www.gelato.unsw.edu.au/linux-ia64/0304/5122.html for some 
> more details.

The manual talks about "accesses" not stores. So this applies to loads and 
stores. Subsequent accesses can float up but only accesses prior to the 
instruction with release semantics (like an unlock) are guaranteed to be 
visible.
