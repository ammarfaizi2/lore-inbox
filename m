Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750737AbVL2OpY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbVL2OpY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 09:45:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750739AbVL2OpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 09:45:23 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:22416 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1750737AbVL2OpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 09:45:23 -0500
Date: Thu, 29 Dec 2005 16:45:22 +0200 (EET)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: kus Kusche Klaus <kus@keba.com>
cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>,
       clameter@sgi.com, mpm@selenic.com
Subject: RE: SLAB-related panic in 2.6.15-rc7-rt1 on ARM
In-Reply-To: <Pine.LNX.4.58.0512291637220.25709@sbz-30.cs.Helsinki.FI>
Message-ID: <Pine.LNX.4.58.0512291643430.25770@sbz-30.cs.Helsinki.FI>
References: <AAD6DA242BC63C488511C611BD51F367323305@MAILIT.keba.co.at>
 <Pine.LNX.4.58.0512291637220.25709@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Dec 2005, kus Kusche Klaus wrote:
> > You're right again, this one-liner makes slab work.
> > (by the way, line numbers differ by miles?)

On Thu, 29 Dec 2005, Pekka J Enberg wrote:
> Yes, the bug is not -rt related. The patch was against vanilla. Christoph, 
> do you know who did the ARM bits for NUMA-aware page allocator?

Eh, I'll take that back. I wasn't aware that the slab allocator is so 
heavily patched in -rt. Looks like they took out the NUMA-aware bits but 
left in alloc_pages_node() so my patch is probably the correct fix for 
-rt. Ingo?

				Pekka
