Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262020AbUEGBLT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262020AbUEGBLT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 21:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262085AbUEGBLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 21:11:19 -0400
Received: from gate.crashing.org ([63.228.1.57]:47550 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262020AbUEGBLS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 21:11:18 -0400
Subject: Re: "PowerMac IDE DMA support"
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nicolas Vollmar <nv1@gmx.ch>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <200405061739.39372.nv1@gmx.ch>
References: <200405061739.39372.nv1@gmx.ch>
Content-Type: text/plain
Message-Id: <1083891889.19156.108.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 07 May 2004 11:04:50 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-05-07 at 03:39, Nicolas Vollmar wrote:
> Hi
> 
> I tried to compile a new Kernel on my iBook and get a compile Error from the 
> IDE PMAC Driver. I had some time to find out that "Generic PCI bus-master DMA 
> support" is needed to compile cleanly.
> 
> It may be better if BLK_DEV_IDEDMA_PMAC depends on BLK_DEV_IDEDMA_PCI?

I think the problem is that some of the generic IDE DMA code shouldn't be
under BLK_DEV_IDEDMA_PCI ... It 's used by several non-strictly-PCI
controllers like this one. (Some non-PCI at all). 

Ben.


