Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263046AbUJ1XNS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263046AbUJ1XNS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 19:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262950AbUJ1XMo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 19:12:44 -0400
Received: from colin2.muc.de ([193.149.48.15]:55313 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261326AbUJ1XI1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 19:08:27 -0400
Date: 29 Oct 2004 01:08:24 +0200
Date: Fri, 29 Oct 2004 01:08:24 +0200
From: Andi Kleen <ak@muc.de>
To: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       discuss@x86-64.org
Subject: [PATCH] Fix x86-64 genapic build
Message-ID: <20041028230824.GA80511@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


He x86-64 genapic patch that was recently merged missed some definitions
and doesn't compile at all. This patch fixes it. 

Please apply ASAP.

Add missing defines for genapic

Signed-off-by: Andi Kleen <ak@muc.de>

diff -puN include/asm-x86_64/apicdef.h~kexec-apic-virtwire-on-shutdownx86_64 include/asm-x86_64/apicdef.h
--- 25/include/asm-x86_64/apicdef.h~kexec-apic-virtwire-on-shutdownx86_64	2004-10-16 01:30:50.550815752 -0700
+++ 25-akpm/include/asm-x86_64/apicdef.h	2004-10-16 01:30:50.555814992 -0700
@@ -32,6 +32,8 @@
 #define			SET_APIC_LOGICAL_ID(x)	(((x)<<24))
 #define			APIC_ALL_CPUS		0xFFu
 #define		APIC_DFR	0xE0
+#define			APIC_DFR_CLUSTER		0x0FFFFFFFul
+#define			APIC_DFR_FLAT			0xFFFFFFFFul
 #define		APIC_SPIV	0xF0
 #define			APIC_SPIV_FOCUS_DISABLED	(1<<9)
 #define			APIC_SPIV_APIC_ENABLED		(1<<8)
@@ -87,6 +89,7 @@
 #define			APIC_LVT_REMOTE_IRR		(1<<14)
 #define			APIC_INPUT_POLARITY		(1<<13)
 #define			APIC_SEND_PENDING		(1<<12)
+#define			APIC_MODE_MASK			0x700
 #define			GET_APIC_DELIVERY_MODE(x)	(((x)>>8)&0x7)
 #define			SET_APIC_DELIVERY_MODE(x,y)	(((x)&~0x700)|((y)<<8))
 #define				APIC_MODE_FIXED		0x0
_
