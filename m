Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261563AbULTQ2M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbULTQ2M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 11:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261564AbULTQ2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 11:28:12 -0500
Received: from main.gmane.org ([80.91.229.2]:23462 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261563AbULTQ2G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 11:28:06 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Ed L Cashin <ecashin@coraid.com>
Subject: [PATCH] ETH_P_AOE (was Re: [PATCH] ATA over Ethernet driver for
 2.6.10-rc3-bk11)
Date: Mon, 20 Dec 2004 11:21:05 -0500
Message-ID: <87k6rd7xfy.fsf@coraid.com>
References: <87k6rhc4uk.fsf@coraid.com>
	<1103356085.3369.140.camel@sfeldma-mobl.dsl-verizon.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-34-230-221.asm.bellsouth.net
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
Cancel-Lock: sha1:oFCKUtowUOesj4aGh2sQ9cc81Yo=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Scott Feldman <sfeldma@pobox.com> writes:

> On Fri, 2004-12-17 at 07:38, Ed L Cashin wrote:
>
>> +       ETH_P_AOE = 0x88a2,
>
> include/linux/if_ether.h already defines this as ETH_P_EDP2=0x88A2; use
> that.

Ah, that's old.  It's not just "EtherDrive protocol" but the ATA over
Ethernet protocol.

Here's a patch for 2.6.10-rc3-bk11 that goes on top of the aoe patch
in this thread.


--=-=-=
Content-Disposition: inline; filename=diff

diff -urNp linux-2.6.10-rc3-bk11-aoe/drivers/block/aoe/aoe.h linux-2.6.10-rc3-bk11-aoe-2/drivers/block/aoe/aoe.h
--- linux-2.6.10-rc3-bk11-aoe/drivers/block/aoe/aoe.h	2004-12-20 11:15:04.000000000 -0500
+++ linux-2.6.10-rc3-bk11-aoe-2/drivers/block/aoe/aoe.h	2004-12-20 11:16:23.000000000 -0500
@@ -26,7 +26,6 @@ enum {
 	AOECCMD_FSET,
 
 	AOE_HVER = 0x10,
-	ETH_P_AOE = 0x88a2,
 };
 
 struct aoe_hdr {
diff -urNp linux-2.6.10-rc3-bk11-aoe/include/linux/if_ether.h linux-2.6.10-rc3-bk11-aoe-2/include/linux/if_ether.h
--- linux-2.6.10-rc3-bk11-aoe/include/linux/if_ether.h	2004-12-20 10:51:20.000000000 -0500
+++ linux-2.6.10-rc3-bk11-aoe-2/include/linux/if_ether.h	2004-12-20 11:16:55.000000000 -0500
@@ -69,7 +69,7 @@
 #define ETH_P_ATMFATE	0x8884		/* Frame-based ATM Transport
 					 * over Ethernet
 					 */
-#define ETH_P_EDP2	0x88A2		/* Coraid EDP2			*/
+#define ETH_P_AOE	0x88A2		/* ATA over Ethernet		*/
 
 /*
  *	Non DIX types. Won't clash for 1500 types.

--=-=-=



-- 
  Ed L Cashin <ecashin@coraid.com>

--=-=-=--

