Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262387AbUK3WvA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262387AbUK3WvA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 17:51:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262382AbUK3WvA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 17:51:00 -0500
Received: from gate.crashing.org ([63.228.1.57]:65430 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262393AbUK3Wul (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 17:50:41 -0500
Subject: Re: [1/7] Xen VMM #3: add ptep_establish_new to make va available
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, Steven.Hand@cl.cam.ac.uk,
       Christian.Limpach@cl.cam.ac.uk, Keir.Fraser@cl.cam.ac.uk,
       Andrew Morton <akpm@osdl.org>, "David S. Miller" <davem@redhat.com>
In-Reply-To: <E1CYxP0-0005Hy-00@mta1.cl.cam.ac.uk>
References: <E1CYxP0-0005Hy-00@mta1.cl.cam.ac.uk>
Content-Type: text/plain
Date: Wed, 01 Dec 2004 09:49:51 +1100
Message-Id: <1101854992.5174.14.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-11-30 at 02:06 +0000, Ian Pratt wrote:
> This patch adds 'ptep_establish_new', in keeping with the
> existing 'ptep_establish', but for use where a mapping is being
> established where there was previously none present. This
> function is useful (rather than just using set_pte) because
> having the virtual address available enables a very important
> optimisation for arch-xen. We introduce
> HAVE_ARCH_PTEP_ESTABLISH_NEW and define a generic implementation
> in asm-generic/pgtable.h, following the pattern of the existing
> ptep_establish.

I would rather move toward that patch that David Miller proposed a while
ago that makes sure the necessary infos (mm, address, ...) are always
passed to all PTE functions.

Is there also a need for ptep_establish and ptep_establish_new to be 2
different functions ?

Ben.


