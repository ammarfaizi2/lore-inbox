Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750732AbVL2OkO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbVL2OkO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 09:40:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbVL2OkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 09:40:14 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:13200 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1750732AbVL2OkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 09:40:12 -0500
Date: Thu, 29 Dec 2005 16:40:06 +0200 (EET)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: kus Kusche Klaus <kus@keba.com>
cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>,
       clameter@sgi.com, mpm@selenic.com
Subject: RE: SLAB-related panic in 2.6.15-rc7-rt1 on ARM
In-Reply-To: <AAD6DA242BC63C488511C611BD51F367323305@MAILIT.keba.co.at>
Message-ID: <Pine.LNX.4.58.0512291637220.25709@sbz-30.cs.Helsinki.FI>
References: <AAD6DA242BC63C488511C611BD51F367323305@MAILIT.keba.co.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Dec 2005, kus Kusche Klaus wrote:
> > From: Pekka J Enberg
> > On Thu, 29 Dec 2005, kus Kusche Klaus wrote:
> > > (note the very early BUG and two "MM: invalid domain"):
> > 
> > I think you'll get those with slob as well. The slab 
> > allocator hasn't had 
> > the chance to initialize itself yet so they're probably not related.
> 
> You're right, these two messages also show up with slob.

You need someone who speaks ARM for these.

On Thu, 29 Dec 2005, kus Kusche Klaus wrote:
> > > Unhandled fault: alignment exception (0xc0207003) at 0x00000163
> > > PC is at get_page_from_freelist+0x1c/0x400
> > > LR is at __alloc_pages+0x68/0x2c0
> > 
> > I am still betting on alloc_pages_node(). You could try the 
> > following to 
> > prove me wrong. It's not a real fix though.
> 
> You're right again, this one-liner makes slab work.
> (by the way, line numbers differ by miles?)

Yes, the bug is not -rt related. The patch was against vanilla. Christoph, 
do you know who did the ARM bits for NUMA-aware page allocator?

				Pekka
