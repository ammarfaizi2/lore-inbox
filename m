Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261212AbUKHUNd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261212AbUKHUNd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 15:13:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261213AbUKHUNd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 15:13:33 -0500
Received: from fw.osdl.org ([65.172.181.6]:53905 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261212AbUKHUNc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 15:13:32 -0500
Date: Mon, 8 Nov 2004 12:13:01 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: adaplas@pol.net
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [Linux-fbdev-devel] Re: [PATCH] fbdev: Fix IO access in rivafb
In-Reply-To: <200411090402.22696.adaplas@hotpop.com>
Message-ID: <Pine.LNX.4.58.0411081211270.2301@ppc970.osdl.org>
References: <200411080521.iA85LbG6025914@hera.kernel.org>
 <200411081706.55261.adaplas@hotpop.com> <Pine.LNX.4.58.0411080719460.24286@ppc970.osdl.org>
 <200411090402.22696.adaplas@hotpop.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 9 Nov 2004, Antonino A. Daplas wrote:
> 
> In big endian machines, the read*/write* accessors do a byteswap for an
> inherently little endian PCI bus.  However, rivafb puts the hardwire in big
> endian register access, thus the byteswap is not needed. So, instead of
> read*/write*, use __raw_read*/__raw_write*.

This fix should make the #ifdef CONFIG_PCC entirely superfluous afaik. 

The thing is, once riva does its HW accesses right, the special cases just 
go away. There's a reason we have abstractions.. 

Does anybody have the hardware to test with?

		Linus
