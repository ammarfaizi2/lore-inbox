Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161227AbVKIUeE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161227AbVKIUeE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 15:34:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161229AbVKIUeD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 15:34:03 -0500
Received: from gate.crashing.org ([63.228.1.57]:6061 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1161227AbVKIUeB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 15:34:01 -0500
Subject: Re: [PATCH] ppc64: 64K pages support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mike Kravetz <kravetz@us.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@osdl.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20051109201720.GB5443@w-mikek2.ibm.com>
References: <1130915220.20136.14.camel@gaston>
	 <1130916198.20136.17.camel@gaston> <20051109172125.GA12861@lst.de>
	 <20051109201720.GB5443@w-mikek2.ibm.com>
Content-Type: text/plain
Date: Thu, 10 Nov 2005 07:32:15 +1100
Message-Id: <1131568336.24637.91.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-09 at 12:17 -0800, Mike Kravetz wrote:
> On Wed, Nov 09, 2005 at 06:21:25PM +0100, Christoph Hellwig wrote:
> > Booting current mainline with 64K pagesize enabled gives me a purple (!)
> > screen early during boot.
> 
> I seem to also be having problems with this patch.  My OpenPOWER 720
> stopped booting with 2.6.14-git10(and later).  Just using defconfig.
> 64k page size NOT enabled.  If I back out the 64k page size patch,
> 2.6.14-git10 boots.  I'm trying to get more info but it is painful.
> It dies before xmon is initialized.

There  have been a couple of fixes, try the very latest git. Also, try
enabling early debug in arch/ppc64/kernel/setup.c

> I could have sworn that I booted 2.6.14-git7 with the 64k page size
> patch applied.  But, I can't do that now either.
> 
> Some co-workers have successfully booted other POWER systems with these
> kernels.  So, it must be specific to my hardware/LPAR configuration.

Ok, i'll do more tests here too.

Ben.


