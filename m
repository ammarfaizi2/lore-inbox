Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261437AbVBRSIX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261437AbVBRSIX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 13:08:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261425AbVBRSIX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 13:08:23 -0500
Received: from it4systems-kln-gw.de.clara.net ([212.6.222.118]:57069 "EHLO
	frankbuss.de") by vger.kernel.org with ESMTP id S261453AbVBRSIF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 13:08:05 -0500
From: "Frank Buss" <fb@frank-buss.de>
To: "'Russell King'" <rmk+lkml@arm.linux.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Problems with dma_mmap_writecombine on mach-pxa
Date: Fri, 18 Feb 2005 19:07:56 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <20050217181241.A22752@flint.arm.linux.org.uk>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
Thread-Index: AcUVHN67XMSPg0F1TSWXpf/AWJWRgwAx8RBA
Message-Id: <20050218180757.9BCCC5B8A3@frankbuss.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> Since we map the whole lot in one go, if you get one page, there's no
> reason why you shouldn't get the lot.  This is why I'm wondering if
> it has something to do with your other modifications.

your patch works, thanks, but only for the problem with the ignored offset, 
as expected. Now I can use the original pxafb driver, but with the same 
problem: All writes from user space in the mmap'ed region after the first 
4096 bytes are ignored.

Perhaps it is not a kernel bug, but a configuration problem with the 
platform, because it is a in-house developed platform. Now a colleague is 
working on this problem and reading a book about the Linux 2.6 kernel 
details over weekend and learning how to use the kernel debugger (until now 
we have used printk and flashing new zImages every time, which is very time 
consuming). I'll post the solution next week, if we'll found one.

-- 
Frank Buﬂ, fb@frank-buss.de
http://www.frank-buss.de, http://www.it4-systems.de

