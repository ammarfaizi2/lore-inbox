Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267725AbUBTIJt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 03:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267727AbUBTIJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 03:09:49 -0500
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:54758 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S267725AbUBTIJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 03:09:47 -0500
Message-ID: <4035C068.8050605@pacbell.net>
Date: Fri, 20 Feb 2004 00:08:08 -0800
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Linus Torvalds <torvalds@osdl.org>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux-USB <linux-usb-devel@lists.sourceforge.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB update for 2.6.3
References: <20040220012802.GA16523@kroah.com>	 <Pine.LNX.4.58.0402192156240.2244@ppc970.osdl.org>	 <1077256996.20789.1091.camel@gaston>	 <Pine.LNX.4.58.0402192221560.2244@ppc970.osdl.org> <1077258504.20781.1121.camel@gaston>
In-Reply-To: <1077258504.20781.1121.camel@gaston>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:

> Yes. I also remember a time where the dma mask for the DMA API was all
> broken too (would not be possible to map the PCI one on top of it),
> but I think that got fixed. 

I thought it was still broken.  Last I compared different asm-* arch
implementations of dma_supported(), the semantics were inconsistent.
The "mask" was sometimes ignored, sometimes treated as an upper
bound on the address, once I recall it even being used as a mask!
Some of that inconsistency seemed to come from PCI though.

- Dave


