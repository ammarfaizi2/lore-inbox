Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263043AbTCSPB6>; Wed, 19 Mar 2003 10:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263049AbTCSPB5>; Wed, 19 Mar 2003 10:01:57 -0500
Received: from fep01.superonline.com ([212.252.122.40]:38137 "EHLO
	fep01.superonline.com") by vger.kernel.org with ESMTP
	id <S263043AbTCSPB4>; Wed, 19 Mar 2003 10:01:56 -0500
Message-ID: <3E788796.4060703@superonline.com>
Date: Wed, 19 Mar 2003 17:07:02 +0200
From: "O.Sezer" <sezero@superonline.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: HPT372N not supported?
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pci_ids.h also has to be patched; something like this one:

--- linux/include/linux/pci_ids.h.orig	2003-03-11 18:50:01
+++ linux/include/linux/pci_ids.h	2003-03-19 16:16:09
@@ -975,6 +975,7 @@
  #define PCI_DEVICE_ID_TTI_HPT372	0x0005
  #define PCI_DEVICE_ID_TTI_HPT302	0x0006
  #define PCI_DEVICE_ID_TTI_HPT371	0x0007
+#define PCI_DEVICE_ID_TTI_HPT372N	0x0009
  #define PCI_DEVICE_ID_TTI_HPT374	0x0008

  #define PCI_VENDOR_ID_VIA		0x1106

--
O.Sezer




"Alan Cox" wrote:

On Mon, 2003-03-17 at 17:28, Henning Schroeder wrote:
 > I don=C5=BDt like that solution very much, though, because the highpoint
 > driver uses the scsi subsystem. Looking through highpoints hpt.c file
 > I could not find very much differences in the way the HPT372N is
 > accessed from the HPT372-way. Maybe somebody (Andre Hedrick?) could
 > look through the code and integrate the HPT372N into
 > linux/drivers/ide/pci/hpt366.c? This feat is regrettably way beyound
 > my own programming capability.

Try the patch attached below. The 372N doesn't seem to be that different
except that we have to use different pci timing thresholds. The patch
below isn't tested as I don't have a 372N.

 > I would love to hear about the current status of that chip. I do not
 > need the RAID capability, just the extra IDE ports.

hptraid should already support the raid bits

