Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265668AbUFSBCY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265668AbUFSBCY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 21:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266758AbUFRT6h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 15:58:37 -0400
Received: from stat1.steeleye.com ([65.114.3.130]:18069 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S266787AbUFRT5W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 15:57:22 -0400
Subject: Re: DMA API issues
From: James Bottomley <James.Bottomley@steeleye.com>
To: Ian Molton <spyro@f2s.com>
Cc: David Brownell <david-b@pacbell.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>, greg@kroah.com,
       tony@atomide.com, jamey.hicks@hp.com, joshua@joshuawise.com
In-Reply-To: <20040618204438.35278560.spyro@f2s.com>
References: <1087582845.1752.107.camel@mulgrave>
	<20040618193544.48b88771.spyro@f2s.com>
	<1087584769.2134.119.camel@mulgrave>
	<20040618195721.0cf43ec2.spyro@f2s.com> <40D34078.5060909@pacbell.net> 
	<20040618204438.35278560.spyro@f2s.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 18 Jun 2004 14:57:01 -0500
Message-Id: <1087588627.2134.155.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-06-18 at 14:44, Ian Molton wrote:
> > For example, if usbaudio uses usb_buffer_alloc to stream data,
> > that eliminates dma bouncing.  That's dma_alloc_coherent at
> > its core ... it should allocate from that 32K region.
> 
> Agreed.

There are complications to this: not all platforms can access PCI memory
directly.  That's why ioremap and memcpy_toio and friends exist.  What
should happen on these platforms?

James


