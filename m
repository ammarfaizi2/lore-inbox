Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261296AbUD3VR3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261296AbUD3VR3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 17:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261340AbUD3VEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 17:04:35 -0400
Received: from zero.aec.at ([193.170.194.10]:27405 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S261296AbUD3U7d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 16:59:33 -0400
To: "Alexander v. Buelow" <buelow@lpr.e-technik.tu-muenchen.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Bug on Quad Opteron in 2.6.6-rc3
References: <1QkoR-81m-31@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Fri, 30 Apr 2004 22:59:31 +0200
In-Reply-To: <1QkoR-81m-31@gated-at.bofh.it> (Alexander v. Buelow's message
 of "Thu, 29 Apr 2004 16:10:13 +0200")
Message-ID: <m3ekq59o7g.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Alexander v. Buelow" <buelow@lpr.e-technik.tu-muenchen.de> writes:

> Hi,
>
> I use a quad opteron machine based on the fedora core 2 test 3 release.
> I compiled a kernel 2.6.6-rc3 myself and the machine crashes when
> mounting the rootfs. I tested kernel 2.6.6-rc2 with exact the same
> .config and it works fine, the same with kernel 2.6.6-rc1.

Apply the appended patch.

-Andi

diff -puN include/asm-x86_64/processor.h~a include/asm-x86_64/processor.h
--- 25/include/asm-x86_64/processor.h~a	Fri Apr 30 11:24:58 2004
+++ 25-akpm/include/asm-x86_64/processor.h	Fri Apr 30 11:25:28 2004
@@ -20,6 +20,8 @@
 #include <asm/mmsegment.h>
 #include <linux/personality.h>
 
+#define ARCH_MIN_TASKALIGN L1_CACHE_BYTES
+
 #define TF_MASK		0x00000100
 #define IF_MASK		0x00000200
 #define IOPL_MASK	0x00003000



