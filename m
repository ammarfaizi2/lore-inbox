Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267860AbTBKOPv>; Tue, 11 Feb 2003 09:15:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267862AbTBKOPt>; Tue, 11 Feb 2003 09:15:49 -0500
Received: from poup.poupinou.org ([195.101.94.96]:3108 "EHLO poup.poupinou.org")
	by vger.kernel.org with ESMTP id <S267860AbTBKOPr>;
	Tue, 11 Feb 2003 09:15:47 -0500
Date: Tue, 11 Feb 2003 15:25:33 +0100
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: [PATCH] [0/1] acpi_wakeup.S
Message-ID: <20030211142533.GM25625@poup.poupinou.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="aM3YZ0Iwxop3KEKx"
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: Ducrot Bruno <ducrot@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--aM3YZ0Iwxop3KEKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This one correct the arithmetic 0x1000 = 4096.

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.

--aM3YZ0Iwxop3KEKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="00_acpi_wakeup.diff"

--- linux-2.5.60/arch/i386/kernel/acpi_wakeup.S	2003/02/11 13:59:48	1.1
+++ linux-2.5.60/arch/i386/kernel/acpi_wakeup.S	2003/02/11 14:00:41
@@ -160,11 +160,11 @@
 	ALIGN
 
 
-.org	0x2000
+.org	0x800
 wakeup_stack:
-.org	0x3000
+.org	0x900
 ENTRY(wakeup_end)
-.org	0x4000
+.org	0x1000
 
 wakeup_pmode_return:
 	movl	$__KERNEL_DS, %eax

--aM3YZ0Iwxop3KEKx--
