Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263301AbUFTUTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263301AbUFTUTV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 16:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265941AbUFTUTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 16:19:21 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:7623 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S263301AbUFTUTU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 16:19:20 -0400
Message-ID: <40D5F104.9040409@pacbell.net>
Date: Sun, 20 Jun 2004 13:18:12 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@steeleye.com>
CC: Ian Molton <spyro@f2s.com>, rmk+lkml@arm.linux.org.uk,
       Linux Kernel <linux-kernel@vger.kernel.org>, greg@kroah.com,
       tony@atomide.com, jamey.hicks@hp.com, joshua@joshuawise.com
Subject: Re: DMA API issues
References: <1087584769.2134.119.camel@mulgrave>	<20040618195721.0cf43ec2.spyro@f2s.co <40D34078.5060909@pacbell.net>	<20040618204438.35278560.spyro@f2s.com> <1087588627.2134.155.camel@mulgrave	<40D359BB.3090106@pacbell.net> <1087593282.2135.176.camel@mulgrave>	<40D36EDE.2080803@pacbell.net> <1087600052.2135.197.camel@mulgrave>	<40D4849B.3070001@pacbell.net>	<20040619214126.C8063@flint.arm.linux.org.uk>	<1087681604.2121.96.camel@mulgrave>  <20040619234933.214b810b.spyro@f2s.com> <1087738680.10858.5.camel@mulgrave>
In-Reply-To: <1087738680.10858.5.camel@mulgrave>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:

> The iseries can't because the PCI bus sits behind the hypervisor and has
> to use accessors to get at the on chip memory, it can't simply be mapped
> into the address space like it can on ARM.

So you're saying that the iSeries can't implement dma_alloc_coherent()
for such hardware, yes?  In that case, it should return a polite failure
status.  Meanwhile, hardware that _can_ implement it should do so.

- Dave


