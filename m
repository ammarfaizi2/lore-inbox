Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261856AbVHAJBJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261856AbVHAJBJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 05:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261959AbVHAJBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 05:01:09 -0400
Received: from gate.crashing.org ([63.228.1.57]:33431 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261856AbVHAI74 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 04:59:56 -0400
Subject: Re: revert yenta free_irq on suspend
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <len.brown@intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Daniel Ritz <daniel.ritz@gmx.ch>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Andrew Morton <akpm@osdl.org>, Hugh Dickins <hugh@veritas.com>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20050731212058.GC27433@elf.ucw.cz>
References: <2e00842e116e.2e116e2e0084@columbus.rr.com>
	 <20050731212058.GC27433@elf.ucw.cz>
Content-Type: text/plain
Date: Mon, 01 Aug 2005 10:56:14 +0200
Message-Id: <1122886575.18835.113.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-07-31 at 23:20 +0200, Pavel Machek wrote:
> Hi!
> 
> > Also I'd like to point out that this patch broke APM suspend-to-ram,
> > not ACPI S3.  IMO, it may not be possible to support both APM and ACPI
> > on every system, as their specs are not intended to be compatible.
> > Progress toward proper suspend-to-ram support will, in many cases, be
> > a small setback for APM.  This really can't be avoided.
> 
> Actually, for APM, OS theoretically does *not* need to FREEZE the
> devices (or do anything else). "Doing nothing" should be easy...

Bullshit. See what happens if you try to APM suspend while a IDE DMA
transfer is in progress ... 

Ben.


