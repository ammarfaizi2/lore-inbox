Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264514AbUFRVPv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264514AbUFRVPv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 17:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264513AbUFRVPl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 17:15:41 -0400
Received: from stat1.steeleye.com ([65.114.3.130]:57771 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S264500AbUFRVOt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 17:14:49 -0400
Subject: Re: DMA API issues
From: James Bottomley <James.Bottomley@steeleye.com>
To: David Brownell <david-b@pacbell.net>
Cc: Ian Molton <spyro@f2s.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       greg@kroah.com, tony@atomide.com, jamey.hicks@hp.com,
       joshua@joshuawise.com
In-Reply-To: <40D359BB.3090106@pacbell.net>
References: <1087582845.1752.107.camel@mulgrave>	<20040618193544.48b88771.spyro@f2s.com>
		<1087584769.2134.119.camel@mulgrave>	<20040618195721.0cf43ec2.spyro@f2s.com
	> <40D34078.5060909@pacbell.net> 	<20040618204438.35278560.spyro@f2s.com>
	<1087588627.2134.155.camel@mulgrave>  <40D359BB.3090106@pacbell.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 18 Jun 2004 16:14:41 -0500
Message-Id: <1087593282.2135.176.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-06-18 at 16:08, David Brownell wrote:
> I'm not following you.  This isn't using the PCI DMA calls.
> These dots don't connect:  different hardware needs different
> solutions.  How would those calls make dma_alloc_coherent work?


The statement was "That's dma_alloc_coherent at its core ... it should
allocate from that 32K region." and what I was pointing out is that not
all platforms can treat an on-chip memory region as a real memory area. 
That's why we have the iomem accessor functions.

James


