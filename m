Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261211AbVF0Bip@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261211AbVF0Bip (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 21:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261341AbVF0Bip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 21:38:45 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:25048 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S261211AbVF0Bim (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 21:38:42 -0400
From: Grant Coady <grant_lkml@dodo.com.au>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Andrew Morton <akpm@osdl.org>, greg@kroah.com, rajesh.shah@intel.com,
       linux-kernel@vger.kernel.org
Subject: Re: ACPI-based PCI resources: PCMCIA bugfix, but resources missing in trees
Date: Mon, 27 Jun 2005 11:38:34 +1000
Organization: <http://scatter.mine.nu/>
Message-ID: <06lub192nippc5a4fkju7gfr18kmv33aqn@4ax.com>
References: <20050626040329.3849cf68.akpm@osdl.org> <20050626140411.GA8597@dominikbrodowski.de>
In-Reply-To: <20050626140411.GA8597@dominikbrodowski.de>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Jun 2005 16:04:12 +0200, Dominik Brodowski <linux@dominikbrodowski.net> wrote:

>On Sun, Jun 26, 2005 at 04:03:29AM -0700, Andrew Morton wrote:
>> - Lots of merges.  I'm holding off on the 80-odd pcmcia patches until we get
>>   the recent PCI breakage sorted out.
>
>pci-yenta-cardbus-fix.patch and the following patch should solve the
>initialization time trouble. However, the ACPI-based PCI resource handling
>is badly broken, IMHO:
>

Well this patch doesn't do it for Toshiba laptop, ToPIC-100 ZV 
bridge in 'auto' mode.

"-mm2b" info set on http://scatter.mine.nu/test/linux-2.6/tosh/

--- ioports-2.6.12.1a   2005-06-27 09:00:21.000000000 +1000
+++ ioports-2.6.12-mm2b 2005-06-27 09:54:45.000000000 +1000
@@ -10,20 +10,13 @@
 00f0-00ff : fpu
 0170-0177 : ide1
 01f0-01f7 : ide0
-02f8-02ff : 0000:00:07.0
 0376-0376 : ide1
 0378-037a : parport0
 03c0-03df : vesafb
 03f6-03f6 : ide0
 03f8-03ff : serial
 0cf8-0cff : PCI conf1
-1c00-1cff : 0000:00:07.0
-4000-40ff : PCI CardBus #02
-  4000-407f : 0000:02:00.0
-    4000-407f : xircom_cb
-4400-44ff : PCI CardBus #02
-fc00-fcff : 0000:00:0c.0
-  fc00-fcff : ESS Maestro
+fc00-fcff : ESS Maestro
 fd00-fd3f : motherboard
 fe00-fe3f : 0000:00:05.3
   fe00-fe3f : motherboard
@@ -40,8 +33,6 @@
 fe90-fe97 : motherboard
 fe9e-fe9e : motherboard
 feac-feac : motherboard
-ff80-ff9f : 0000:00:05.2
-  ff80-ff9f : uhci_hcd
-fff0-ffff : 0000:00:05.1
-  fff0-fff7 : ide0
-  fff8-ffff : ide1
+ff80-ff9f : uhci_hcd
+fff0-fff7 : ide0
+fff8-ffff : ide1

--Grant.

