Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264833AbUFTQ0p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264833AbUFTQ0p (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 12:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264561AbUFTQ0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 12:26:44 -0400
Received: from havoc.gtf.org ([216.162.42.101]:25033 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S264702AbUFTQ0b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 12:26:31 -0400
Date: Sun, 20 Jun 2004 12:26:11 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Ian Molton <spyro@f2s.com>
Cc: James Bottomley <James.Bottomley@SteelEye.com>, rmk+lkml@arm.linux.org.uk,
       david-b@pacbell.net, linux-kernel@vger.kernel.org, greg@kroah.com,
       tony@atomide.com, jamey.hicks@hp.com, joshua@joshuawise.com
Subject: Re: DMA API issues
Message-ID: <20040620162611.GB16038@havoc.gtf.org>
References: <40D359BB.3090106@pacbell.net> <1087593282.2135.176.camel@mulgrave> <40D36EDE.2080803@pacbell.net> <1087600052.2135.197.camel@mulgrave> <40D4849B.3070001@pacbell.net> <20040619214126.C8063@flint.arm.linux.org.uk> <1087681604.2121.96.camel@mulgrave> <20040619234933.214b810b.spyro@f2s.com> <1087738680.10858.5.camel@mulgrave> <20040620165042.393f2756.spyro@f2s.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040620165042.393f2756.spyro@f2s.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 20, 2004 at 04:50:42PM +0100, Ian Molton wrote:
> Those two statements are contradictory. clearly the iseries cant use the
> DMA API *now* so I dont see how that makes any difference. We're talking
> about adding propper support for *addresssable* memory mapped devices
> with limited size DMA-able windows to the DMA API, not adding support
> for a whole new weird way of talking to devices. These devices work the
> same way as all the other devices that use the DMA API but are simply
> restricted in the range of addresses they can DMA from. they require no
> special 'accessors'.
> 
> iseries cant work the usual way now and wont with these modifications -
> so nothing is made worse.

Are you purposefully ignoring James?

He is saying the DMA API must be uniform across all platforms.  Your
proposal 

1) breaks this

2) is unneeded, as many other drivers in this same situation simply use
ioremap

