Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263761AbUFTUPy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263761AbUFTUPy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 16:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265940AbUFTUPy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 16:15:54 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:29360 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S263761AbUFTUPx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 16:15:53 -0400
Message-ID: <40D5F053.9000209@pacbell.net>
Date: Sun, 20 Jun 2004 13:15:15 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Ian Molton <spyro@f2s.com>, James Bottomley <James.Bottomley@SteelEye.com>,
       rmk+lkml@arm.linux.org.uk, linux-kernel@vger.kernel.org, greg@kroah.com,
       tony@atomide.com, jamey.hicks@hp.com, joshua@joshuawise.com
Subject: Re: DMA API issues
References: <40D359BB.3090106@pacbell.net> <1087593282.2135.176.camel@mulgrave> <40D36EDE.2080803@pacbell.net> <1087600052.2135.197.camel@mulgrave> <40D4849B.3070001@pacbell.net> <20040619214126.C8063@flint.arm.linux.org.uk> <1087681604.2121.96.camel@mulgrave> <20040619234933.214b810b.spyro@f2s.com> <1087738680.10858.5.camel@mulgrave> <20040620165042.393f2756.spyro@f2s.com> <20040620162611.GB16038@havoc.gtf.org>
In-Reply-To: <20040620162611.GB16038@havoc.gtf.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> 2) is unneeded, as many other drivers in this same situation simply use
> ioremap

But ioremap() only solves the problem of allocating virtual address
space to match this memory.  It doesn't solve the problem of then
allocating/freeing such memory through dma_alloc_coherent(), so that
the drivers that need to share access to that memory can do so.




