Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264637AbTDYAOj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 20:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264625AbTDYANu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 20:13:50 -0400
Received: from sinfonix.rz.tu-clausthal.de ([139.174.2.33]:64755 "EHLO
	sinfonix.rz.tu-clausthal.de") by vger.kernel.org with ESMTP
	id S264629AbTDYAMp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 20:12:45 -0400
From: "Hemmann, Volker Armin" <volker.hemmann@heim9.tu-clausthal.de>
To: linux-kernel@vger.kernel.org
Subject: [Patch?] SiS 746 AGP-Support
Date: Fri, 25 Apr 2003 02:24:50 +0200
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200304250224.50431.volker.hemmann@heim9.tu-clausthal.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this is my first try of making and submitting a patch, so please, don't kill 
me for it. 

I don't know, if the following changes are 'clean' but they give me a working 
agpsupport for my SiS 746Fx based mobo.

This (attempt) of a patch is against 2.4.21-rc1:

*** /usr/src/linux-2.4.21-rc1/drivers/pci/pci.ids       2003-04-25 01:
52:30.000000000 +0200
--- /usr/src/linux/drivers/pci/pci.ids  2003-04-23 07:18:54.000000000
+0200
***************
*** 1119,1124 ****
--- 1119,1125 ----
        0735  735 Host
        0740  740 Host
        0745  745 Host
+       0756  746 Host
        0900  SiS900 10/100 Ethernet
                1039 0900  SiS900 10/100 Ethernet Adapter
        0961  SiS961 [MuTIOL Media IO]

*** /usr/src/linux-2.4.21-rc1/drivers/char/agp/agpgart_be.c     2003-0
4-25 01:52:29.000000000 +0200
--- /usr/src/linux/drivers/char/agp/agpgart_be.c        2003-04-23 07:
33:48.000000000 +0200
*************** static struct {
*** 4595,4600 ****
--- 4595,4606 ----
                "SiS",
                "745",
                sis_generic_setup },
+       { PCI_DEVICE_ID_SI_746,
+               PCI_VENDOR_ID_SI,
+               SIS_GENERIC,
+               "SiS",
+               "746",
+               sis_generic_setup },
        { PCI_DEVICE_ID_SI_730,
                PCI_VENDOR_ID_SI,
                SIS_GENERIC,

I am doing this since 2.4.21-pre6 without any problems.

Glück Auf,
Volker
