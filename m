Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266814AbUFRUUz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266814AbUFRUUz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 16:20:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266813AbUFRUUH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 16:20:07 -0400
Received: from gate.crashing.org ([63.228.1.57]:41864 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S266826AbUFRUSM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 16:18:12 -0400
Subject: Re: DMA API issues
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jamey Hicks <jamey.hicks@hp.com>
Cc: James Bottomley <James.Bottomley@SteelEye.com>, Ian Molton <spyro@f2s.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, tony@atomide.com,
       David Brownell <david-b@pacbell.net>, joshua@joshuawise.com
In-Reply-To: <40D340FB.3080309@hp.com>
References: <1087582845.1752.107.camel@mulgrave>
	 <20040618193544.48b88771.spyro@f2s.com>
	 <1087584769.2134.119.camel@mulgrave>  <40D340FB.3080309@hp.com>
Content-Type: text/plain
Message-Id: <1087589651.8210.288.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 18 Jun 2004 15:14:11 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I really think this is a DMA API implementation issue.  The problem 
> touches more than the USB drivers.  I say implementation because the DMA 
> API already takes struct device, so the public interface would not have 
> to change or would not have to change much.  However, we would like to 
> be able to provide device-specific implementations of the dma 
> operations.  One way to implement this would be a pointer to 
> dma_operations from struct device.

I wanted to do just that a while ago, and ended up doing things a bit
differently, but still, I agree that would help. The thing is, you
can do that in your platform code. just use the platform data pointer
in struct device to stuff a ptr to the structure with your "ops"

Ben.


