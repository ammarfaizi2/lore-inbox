Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266587AbUFRTlC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266587AbUFRTlC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 15:41:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266599AbUFRTkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 15:40:47 -0400
Received: from stat1.steeleye.com ([65.114.3.130]:13454 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S266587AbUFRTaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 15:30:14 -0400
Subject: Re: DMA API issues
From: James Bottomley <James.Bottomley@steeleye.com>
To: Ian Molton <spyro@f2s.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, greg@kroah.com,
       tony@atomide.com, david-b@pacbell.net, jamey.hicks@hp.com,
       joshua@joshuawise.com
In-Reply-To: <20040618195721.0cf43ec2.spyro@f2s.com>
References: <1087582845.1752.107.camel@mulgrave>
	<20040618193544.48b88771.spyro@f2s.com>
	<1087584769.2134.119.camel@mulgrave> 
	<20040618195721.0cf43ec2.spyro@f2s.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 18 Jun 2004 14:30:01 -0500
Message-Id: <1087587004.2078.137.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-06-18 at 13:57, Ian Molton wrote:
> In *theory* the OHCI driver is doing everything right - its asking for DMAable memory and using it. if the DMA api simply understood the device in question, and alocated accordingly, it would just work.
> 
> there are two solutions:
> 
> 1) Break up the OHCI driver and make it into a chip driver as you describe
> 2) Make the DMA API do the right thing with these devices

Could you please just describe what the problem actually is.

The ohci driver looks to be reasonably modular already, with a chip
piece and a bus attachment piece.

Is your problem that you'd like the dma pools it uses to come out of the
on chip buffer?

James


