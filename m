Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932310AbVJQQBq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932310AbVJQQBq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 12:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932313AbVJQQBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 12:01:46 -0400
Received: from ns1.suse.de ([195.135.220.2]:51897 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932310AbVJQQBp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 12:01:45 -0400
From: Andi Kleen <ak@suse.de>
To: Muli Ben-Yehuda <mulix@mulix.org>
Subject: Re: x86_64: 2.6.14-rc4 swiotlb broken
Date: Mon, 17 Oct 2005 18:02:09 +0200
User-Agent: KMail/1.8
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Ravikiran G Thirumalai <kiran@scalex86.org>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org, tglx@linutronix.de,
       shai@scalex86.org
References: <20051017093654.GA7652@localhost.localdomain> <200510171740.57614.ak@suse.de> <20051017155613.GF21783@granada.merseine.nu>
In-Reply-To: <20051017155613.GF21783@granada.merseine.nu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510171802.09708.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 17 October 2005 17:56, Muli Ben-Yehuda wrote:
> On Mon, Oct 17, 2005 at 05:40:56PM +0200, Andi Kleen wrote:
> > First this problem is definitely not critical. AFAIK it only happens on
> > scalex's unreleased machines. Intel NUMA x86 machines are really rare
> > and on AMD it doesn't happen because the swiotlb is not used there.
>
> It's not used by default, but there are cases where it's used and it
> would be a shame to release a major kernel and knowingly break
> them. For example, any setup that used iommu_force or any non-AMD
> x86-64 machine with more than 4GB of memory and only 32-bit capable
> DMA devices.

... but risk breaking other stuff. Unless you can get the ARM and/or IA64 
people to do some retesting with the proposed fixes it's quite risky.  
Sometimes you have to make compromises before releases.

> Another alternative is to temporarily
> provide a different version of swiotlb_init() for x86-64 and IA64 -
> I can whip up a patch if that's acceptable.

I don't want that.

-Andi

