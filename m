Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261951AbVDETR1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261951AbVDETR1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 15:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261964AbVDETPC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 15:15:02 -0400
Received: from hammer.engin.umich.edu ([141.213.40.79]:64223 "EHLO
	hammer.engin.umich.edu") by vger.kernel.org with ESMTP
	id S261951AbVDETKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 15:10:17 -0400
Date: Tue, 5 Apr 2005 15:10:07 -0400 (EDT)
From: Christopher Allen Wing <wingc@engin.umich.edu>
To: Andi Kleen <ak@muc.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: clock runs at double speed on x86_64 system w/ATI RS200 chipset
In-Reply-To: <20050405183141.GA27195@muc.de>
Message-ID: <Pine.LNX.4.58.0504051508520.13242@hammer.engin.umich.edu>
References: <200504031231.j33CVtHp021214@harpo.it.uu.se>
 <Pine.LNX.4.58.0504041050250.32159@hammer.engin.umich.edu> <m18y3x16rj.fsf@muc.de>
 <Pine.LNX.4.58.0504051351200.13242@hammer.engin.umich.edu>
 <20050405183141.GA27195@muc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

here's the patch for x86_64
The kernel is compiling... I'll try it when it finishes.

-Chris



--- linux-2.6.11.6/arch/x86_64/kernel/setup.c.orig	2005-03-25 22:28:14.000000000 -0500
+++ linux-2.6.11.6/arch/x86_64/kernel/setup.c	2005-04-05 15:05:47.656886736 -0400
@@ -333,6 +333,12 @@
 		else if (!memcmp(from, "acpi=strict", 11)) {
 			acpi_strict = 1;
 		}
+
+#ifdef CONFIG_X86_IO_APIC
+		else if (!memcmp(from, "acpi_skip_timer_override", 24))
+			acpi_skip_timer_override = 1;
+#endif
+
 #endif

 		if (!memcmp(from, "nolapic", 7) ||




On Tue, 5 Apr 2005, Andi Kleen wrote:

> Try booting with acpi_skip_timer_override
>
> -Andi
