Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262915AbVDHSRH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262915AbVDHSRH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 14:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262897AbVDHSQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 14:16:54 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:47621 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262913AbVDHSNn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 14:13:43 -0400
Date: Fri, 8 Apr 2005 20:13:40 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Mickael Marchand <marchand@kde.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       jfv@bluesong.net
Subject: [-mm patch] x86_64: kill obsolete check_nmi_watchdog prototype
Message-ID: <20050408181340.GC15688@stusta.de>
References: <20050405000524.592fc125.akpm@osdl.org> <4254DDCB.2070704@kde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4254DDCB.2070704@kde.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2005 at 09:14:19AM +0200, Mickael Marchand wrote:
>...
> -> compiling 2.6.12-rc2-mm1 on amd64 :
> 
> arch/x86_64/kernel/nmi.c:116: error: static declaration of
> 'check_nmi_watchdog' follows non-static declaration
> include/asm/apic.h:102: error: previous declaration of
> 'check_nmi_watchdog' was here

Is this with gcc 4.0?

> I guess the fix is easy enough :)
>...

Yup, fix below.

> Cheers,
> Mik

cu
Adrian


<--  snip  -->


This patch kills an obsolete check_nmi_watchdog prototype 
(check_nmi_watchdog is now static) found by
Mickael Marchand <marchand@kde.org>.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-rc2-mm1-full/include/asm-x86_64/apic.h.old	2005-04-08 20:12:01.000000000 +0200
+++ linux-2.6.12-rc2-mm1-full/include/asm-x86_64/apic.h	2005-04-08 20:12:11.000000000 +0200
@@ -99,7 +99,6 @@
 extern void enable_APIC_timer(void);
 extern void clustered_apic_check(void);
 
-extern int check_nmi_watchdog(void);
 extern void nmi_watchdog_default(void);
 extern int setup_nmi_watchdog(char *);
 

