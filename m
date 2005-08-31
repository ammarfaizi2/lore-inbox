Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964810AbVHaNnJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964810AbVHaNnJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 09:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964811AbVHaNnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 09:43:09 -0400
Received: from pilet.ens-lyon.fr ([140.77.167.16]:33158 "EHLO
	relaissmtp.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S964810AbVHaNnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 09:43:07 -0400
Message-ID: <4315A5C5.6080903@ens-lyon.fr>
Date: Wed, 31 Aug 2005 14:42:45 +0200
From: Alexandre Buisse <alexandre.buisse@ens-lyon.fr>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050812)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.13
References: <Pine.LNX.4.58.0508281708040.3243@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508281708040.3243@g5.osdl.org>
Content-Type: multipart/mixed;
 boundary="------------030102050708090104030409"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030102050708090104030409
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

the description of PCI_NAMES is conflicting with its default option (now 
N/y/? instead of Y/n/?). Here is a small patch that should remove the 
confusion in drivers/pci/Kconfig.

Regards,
Alexandre

Signed-off-by : Alexandre Buisse <Alexandre.Buisse@ens-lyon.fr>

--------------030102050708090104030409
Content-Type: text/x-patch;
 name="pci_names_desc_update.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pci_names_desc_update.patch"

--- drivers/pci/Kconfig.old	2005-08-31 14:35:06.000000000 +0200
+++ drivers/pci/Kconfig	2005-08-31 14:35:14.000000000 +0200
@@ -34,7 +34,7 @@
 	bool "PCI device name database"
 	depends on PCI
 	---help---
-	  By default, the kernel contains a database of all known PCI device
+	  The kernel can contain a database of all known PCI device
 	  names to make the information in /proc/pci, /proc/ioports and
 	  similar files comprehensible to the user. 
 
@@ -45,7 +45,7 @@
 	  embedded system where kernel image size really matters, you can disable 
 	  this feature and you'll get device ID numbers instead of names.
 
-	  When in doubt, say Y.
+	  When in doubt, say N.
 
 config PCI_DEBUG
 	bool "PCI Debugging"

--------------030102050708090104030409--
