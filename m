Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263049AbTCLAzp>; Tue, 11 Mar 2003 19:55:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263093AbTCLAzp>; Tue, 11 Mar 2003 19:55:45 -0500
Received: from ns.splentec.com ([209.47.35.194]:30733 "EHLO pepsi.splentec.com")
	by vger.kernel.org with ESMTP id <S263049AbTCLAzo>;
	Tue, 11 Mar 2003 19:55:44 -0500
Message-ID: <3E6E880F.8050101@splentec.com>
Date: Tue, 11 Mar 2003 20:06:23 -0500
From: Luben Tuikov <luben@splentec.com>
Organization: Splentec Ltd.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] missing header file in asm-i386/xor.h
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Missing include macro for header file asm/i387.h in asm-i386/xor.h
for kernel_fpu_begin() and kernel_fpu_end().

I get compilation warnings/linkage problems.

-- 
Luben


--- linux-2.5.64bk6/include/asm-i386/xor.h.orig	2003-03-11 19:15:36.000000000 -0500
+++ linux-2.5.64bk6/include/asm-i386/xor.h	2003-03-11 17:04:35.000000000 -0500
@@ -18,6 +18,8 @@
   * Copyright (C) 1998 Ingo Molnar.
   */

+#include <asm/i387.h>
+
  #define LD(x,y)		"       movq   8*("#x")(%1), %%mm"#y"   ;\n"
  #define ST(x,y)		"       movq %%mm"#y",   8*("#x")(%1)   ;\n"
  #define XO1(x,y)	"       pxor   8*("#x")(%2), %%mm"#y"   ;\n"

