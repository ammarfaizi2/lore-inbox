Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261256AbVFOSQh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261256AbVFOSQh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 14:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261258AbVFOSQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 14:16:37 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:10399 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261256AbVFOSQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 14:16:32 -0400
Subject: Re: DMA mapping (was Re: [PATCH] cciss 2.6; replaces DMA masks
	with kernel defines)
From: Lee Revell <rlrevell@joe-job.com>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Arjan van de Ven <arjan@infradead.org>, Jeff Garzik <jgarzik@pobox.com>,
       mike.miller@hp.com, akpm@osdl.org, axboe@suse.de,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <20050611135411.GJ24611@parcelfarce.linux.theplanet.co.uk>
References: <20050610143453.GA26476@beardog.cca.cpqcorp.net>
	 <42A9C60E.3080604@pobox.com> <1118436000.6423.42.camel@mindpipe>
	 <1118436306.5272.37.camel@laptopd505.fenrus.org>
	 <1118438253.6423.72.camel@mindpipe>
	 <20050610213003.GI24611@parcelfarce.linux.theplanet.co.uk>
	 <1118444891.6423.130.camel@mindpipe>
	 <20050611135411.GJ24611@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Date: Wed, 15 Jun 2005 14:19:03 -0400
Message-Id: <1118859544.23353.14.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-06-11 at 14:54 +0100, Matthew Wilcox wrote:
> On Fri, Jun 10, 2005 at 07:08:11PM -0400, Lee Revell wrote:
> > Should I just add everything from 24 to 63?
> 
> Actually, it'd be useful to have a central list of what DMA masks devices
> really take.  It might provide some arguments for changing the zone allocater.
> 

OK, patch attached.  I don't have time to cover every case, maybe
someone else can run with this.

Lee

Summary: Add DMA mask constants other than 32 and 64 bit

Signed-Off-By: Lee Revell <rlrevell@joe-job.com>

--- linux-2.6.12-rc5-k7/include/linux/dma-mapping.h-orig	2005-06-15 14:14:04.000000000 -0400
+++ linux-2.6.12-rc5-k7/include/linux/dma-mapping.h	2005-06-15 14:17:13.000000000 -0400
@@ -14,7 +14,12 @@
 };
 
 #define DMA_64BIT_MASK	0xffffffffffffffffULL
+#define DMA_40BIT_MASK	0x000000ffffffffffULL
+#define DMA_39BIT_MASK	0x0000007fffffffffULL
 #define DMA_32BIT_MASK	0x00000000ffffffffULL
+#define DMA_31BIT_MASK	0x000000007fffffffULL
+#define DMA_30BIT_MASK	0x000000003fffffffULL
+#define DMA_29BIT_MASK	0x000000001fffffffULL
 
 #include <asm/dma-mapping.h>


