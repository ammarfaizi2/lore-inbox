Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267874AbTBKO1d>; Tue, 11 Feb 2003 09:27:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267875AbTBKO1d>; Tue, 11 Feb 2003 09:27:33 -0500
Received: from poup.poupinou.org ([195.101.94.96]:8996 "EHLO poup.poupinou.org")
	by vger.kernel.org with ESMTP id <S267874AbTBKO1b>;
	Tue, 11 Feb 2003 09:27:31 -0500
Date: Tue, 11 Feb 2003 15:37:17 +0100
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net,
       Pavel Machek <pavel@ucw.cz>
Subject: [PATCH] [1/1] acpi_wakeup.S
Message-ID: <20030211143717.GC25632@poup.poupinou.org>
Reply-To: ducrot@poupinou.org
References: <20030211142533.GM25625@poup.poupinou.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
In-Reply-To: <20030211142533.GM25625@poup.poupinou.org>
User-Agent: Mutt/1.4i
From: Ducrot Bruno <poup@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Patch from Pavel Macheck.  Just in case it was
lost..




-- 
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page

--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="01_acpi_wakeup.diff"

--- linux-2.5.60/arch/i386/kernel/acpi_wakeup.S	2003/02/11 14:02:07	1.2
+++ linux-2.5.60/arch/i386/kernel/acpi_wakeup.S	2003/02/11 14:02:54
@@ -31,7 +31,7 @@
 	movw	%cs, %ax
 	movw	%ax, %ds					# Make ds:0 point to wakeup_start
 	movw	%ax, %ss
-	mov	wakeup_stack - wakeup_code, %sp			# Private stack is needed for ASUS board
+	mov	$(wakeup_stack - wakeup_code), %sp		# Private stack is needed for ASUS board
 	movw	$0x0e00 + 'S', %fs:(0x12)
 
 	pushl	$0						# Kill any dangerous flags

--EVF5PPMfhYS0aIcm--
