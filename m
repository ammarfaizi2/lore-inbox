Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261638AbUBVBH4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 20:07:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261637AbUBVBHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 20:07:55 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:34482 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S261638AbUBVBHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 20:07:04 -0500
Date: Sun, 22 Feb 2004 01:04:25 +0000
From: Dave Jones <davej@redhat.com>
To: Bob Gill <gillb4@telusplanet.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: drivers/ieee1394/sbp2.c:734: error: `host' undeclared (first use in this function) 2.6.3-bk3
Message-ID: <20040222010424.GA16018@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Bob Gill <gillb4@telusplanet.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1077399402.22141.86.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1077399402.22141.86.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 21, 2004 at 02:36:43PM -0700, Bob Gill wrote:
 > Hi.  The whole error message is (when building 2.6.3-bk3):
 > drivers/ieee1394/sbp2.c: In function `sbp2_alloc_device':
 > drivers/ieee1394/sbp2.c:734: error: `host' undeclared (first use in this
 > function)
 > drivers/ieee1394/sbp2.c:734: error: (Each undeclared identifier is
 > reported only once
 > drivers/ieee1394/sbp2.c:734: error: for each function it appears in.)
 > make[2]: *** [drivers/ieee1394/sbp2.o] Error 1
 > make[1]: *** [drivers/ieee1394] Error 2
 > make: *** [drivers] Error 2

I've no hardware to test this, but does this do the right thing for you ?

		Dave

--- linux-2.6.3/drivers/ieee1394/sbp2.c~	2004-02-22 00:54:51.000000000 +0000
+++ linux-2.6.3/drivers/ieee1394/sbp2.c	2004-02-22 00:55:11.000000000 +0000
@@ -727,7 +727,7 @@
 #ifdef CONFIG_IEEE1394_SBP2_PHYS_DMA
 		/* Handle data movement if physical dma is not
 		 * enabled/supportedon host controller */
-		hpsb_register_addrspace(&sbp2_highlevel, host, &sbp2_physdma_ops,
+		hpsb_register_addrspace(&sbp2_highlevel, hi->host, &sbp2_physdma_ops,
 					0x0ULL, 0xfffffffcULL);
 #endif
 	}
