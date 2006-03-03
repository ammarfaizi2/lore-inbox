Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751258AbWCCLA7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbWCCLA7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 06:00:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbWCCLA6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 06:00:58 -0500
Received: from ns.suse.de ([195.135.220.2]:22952 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751244AbWCCLA4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 06:00:56 -0500
From: Andi Kleen <ak@suse.de>
To: Chris Wedgwood <cw@f00f.org>
Subject: Re: PCI-DMA: Out of IOMMU space on x86-64 (Athlon64x2), with solution
Date: Fri, 3 Mar 2006 12:00:12 +0100
User-Agent: KMail/1.9.1
Cc: Michael Monnerie <m.monnerie@zmi.at>, linux-kernel@vger.kernel.org,
       suse-linux-e@suse.com
References: <200603020023.21916@zmi.at> <200603020203.49128.ak@suse.de> <20060303081654.GA11559@taniwha.stupidest.org>
In-Reply-To: <20060303081654.GA11559@taniwha.stupidest.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603031200.13639.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 03 March 2006 09:16, Chris Wedgwood wrote:
> On Thu, Mar 02, 2006 at 02:03:48AM +0100, Andi Kleen wrote:
> 
> > Nvidia hardware SATA cannot directly DMA to > 4GB, so it has to go
> > through the IOMMU.
> 
> do you know if that is an actual hardware limitation or simply a
> something we don't know how to do for lack of docs?

I assume that's a hardware limitation. I guess they'll move to AHCI
at some point though - that should fix that.

> 
> > And in that kernel the Nforce ethernet driver also didn't do >4GB
> > access, although the ethernet HW is theoretically capable.
> 
> hrm, again, with a lack of docs is that likely to occur anytime soon?

That has been already fixed, just not in the kernel version Michael
is using.

-Andi
