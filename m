Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273989AbRIXQ1G>; Mon, 24 Sep 2001 12:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273988AbRIXQ04>; Mon, 24 Sep 2001 12:26:56 -0400
Received: from president.eu.org ([194.45.71.67]:6155 "EHLO president.eu.org")
	by vger.kernel.org with ESMTP id <S273989AbRIXQ0o>;
	Mon, 24 Sep 2001 12:26:44 -0400
Date: Mon, 24 Sep 2001 18:14:45 +0200
From: Hans Freitag <hafre@macro.lan-ks.de>
To: kernel@vger.kernel.org
Subject: Kernel 2.4.10: aironet4500_card.c:62: parse error
Message-ID: <20010924181445.A6886@president.eu.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
X-PGP-Ident: 204D1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline

Hi,

When I want to compile Kernel 2.4.10 the following error occours:

aironet4500_card.c:62: parse error before `__devinitdata'
aironet4500_card.c:62: warning: type defaults to `int' in declaration\
of `__devinitdata'

With the following patch it's compiling, but I could not
test its functionality.

bye
-- 
May the Source be with you!

--huq684BweRXVnRxX
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="aironet.diff"

*** drivers/net/aironet4500_card.c.orig Mon Sep 24 18:04:04 2001
--- drivers/net/aironet4500_card.c      Mon Sep 24 18:06:16 2001
***************
*** 59,65 ****
  
  #include <linux/pci.h>
  
! static struct pci_device_id aironet4500_card_pci_tbl[] __devinitdata = {
        { PCI_VENDOR_ID_AIRONET, PCI_DEVICE_AIRONET_4800_1, PCI_ANY_ID, PCI_ANY_ID, },
        { PCI_VENDOR_ID_AIRONET, PCI_DEVICE_AIRONET_4800, PCI_ANY_ID, PCI_ANY_ID, },
        { PCI_VENDOR_ID_AIRONET, PCI_DEVICE_AIRONET_4500, PCI_ANY_ID, PCI_ANY_ID, },
--- 59,65 ----
  
  #include <linux/pci.h>
  
! static struct pci_device_id aironet4500_card_pci_tbl[] = {
        { PCI_VENDOR_ID_AIRONET, PCI_DEVICE_AIRONET_4800_1, PCI_ANY_ID, PCI_ANY_ID, },
        { PCI_VENDOR_ID_AIRONET, PCI_DEVICE_AIRONET_4800, PCI_ANY_ID, PCI_ANY_ID, },
        { PCI_VENDOR_ID_AIRONET, PCI_DEVICE_AIRONET_4500, PCI_ANY_ID, PCI_ANY_ID, },

--huq684BweRXVnRxX--
