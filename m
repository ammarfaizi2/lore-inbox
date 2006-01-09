Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751597AbWAIWou@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751597AbWAIWou (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 17:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751595AbWAIWou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 17:44:50 -0500
Received: from mail1.kontent.de ([81.88.34.36]:17833 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S1751261AbWAIWot (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 17:44:49 -0500
From: Oliver Neukum <oliver@neukum.org>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] [PATCH] UDC support for MIPS/AU1200 and Geode/CS5536
Date: Mon, 9 Jan 2006 23:44:55 +0100
User-Agent: KMail/1.8
Cc: "Jordan Crouse" <jordan.crouse@amd.com>, linux-mips@linux-mips.org,
       linux-kernel@vger.kernel.org, info-linux@ldcmail.amd.com,
       thomas.dahlmann@amd.com
References: <20060109180356.GA8855@cosmic.amd.com>
In-Reply-To: <20060109180356.GA8855@cosmic.amd.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601092344.55988.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 9. Januar 2006 19:03 schrieb Jordan Crouse:
> >From the "two-birds-one-stone" department, I am pleased to present USB UDC
> support for both the MIPS Au1200 SoC and the Geode CS5535 south bridge.  
> Also, coming soon (in the next few days), OTG, which has been removed from
> the usb_host patch, and put into its own patch (as per David's comments).
> 
> This patch is against current linux-mips git, but it should apply for Linus's
> tree as well.
> 
> Regards,
> Jordan
> 
+        VDBG("udc_read_bytes(): %d bytes\n", bytes);
+
+        /* dwords first */
+        for (i = 0; i < bytes / UDC_DWORD_BYTES; i++) {
+               *((u32*) (buf + (i<<2))) = readl(dev->rxfifo); 
+        }

Is there any reason you don't increment by 4?

	Regards
		Oliver
