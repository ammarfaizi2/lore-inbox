Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262495AbUJ0QTo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262495AbUJ0QTo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 12:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262501AbUJ0QQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 12:16:53 -0400
Received: from siaag2af.compuserve.com ([149.174.40.136]:14287 "EHLO
	siaag2af.compuserve.com") by vger.kernel.org with ESMTP
	id S262495AbUJ0QOL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 12:14:11 -0400
Date: Wed, 27 Oct 2004 12:10:50 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [BK PATCHES] ide-2.6 update
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200410271213_MC3-1-8D44-F2D8@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Oct 2004 at 15:07:14 +0200 Bartlomiej Zolnierkiewicz wrote:

>@@ -585,7 +564,8 @@
>       struct pci_dev *dev = hwif->pci_dev;
> 
>       /* PDC20265 has problems with large LBA48 requests */
>-      if (dev->device == PCI_DEVICE_ID_PROMISE_20265)
>+      if ((dev->device == PCI_DEVICE_ID_PROMISE_20267) ||
>+          (dev->device == PCI_DEVICE_ID_PROMISE_20265))
>               hwif->rqsize = 256;
> 
>       hwif->autodma = 0;


   You forgot to update the comment...


   I added this and the smart_thresholds() fix to my 2.6.9-base patches.

   Now I have these ide fixes:

        - smart_thresholds() fix
        - pdc202xx_old LBA48 fix
        - accept bad Maxtor drive serial number
        - allow drive that reports no geometry

   Should anything more really be in there?


--Chuck Ebbert  27-Oct-04  12:04:38
