Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750765AbVJJMoZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbVJJMoZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 08:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750774AbVJJMoZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 08:44:25 -0400
Received: from seqima.han-solo.net ([83.138.65.243]:9709 "EHLO
	seqima.han-solo.net") by vger.kernel.org with ESMTP
	id S1750765AbVJJMoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 08:44:24 -0400
Message-ID: <434A6220.3000608@gmx.de>
Date: Mon, 10 Oct 2005 14:44:16 +0200
From: Georg Lippold <georg.lippold@gmx.de>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050814)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: hpa@zytor.com
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] Re: THE LINUX/I386 BOOT PROTOCOL - Breaking the 256 limit
References: <4315B668.6030603@gmail.com> <43162148.9040604@zytor.com> <20050831215757.GA10804@taniwha.stupidest.org> <431628D5.1040709@zytor.com> <431DF9E9.5050102@gmail.com> <431DFEC3.1070309@zytor.com> <431E00C8.3060606@gmail.com> <4345A9F4.7040000@uni-bremen.de>
In-Reply-To: <4345A9F4.7040000@uni-bremen.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Peter,

my first post didn't get any attention, maybe it was too short.
Here's a longer version:

hpa@zytor.com wrote on Sept. 6th, 2005:

[ wrt. COMMAND_LINE_SIZE=256 in linux/include/asm-i386/setup.h and 
linux/include/asm-i386/param.h ]

>> I would like to push forward the idea to extend the command-line size...
> [...]
> Already pushed to Andrew.  I will follow it up with a patch to extend 
> the command line, at least to 512.

I would like to know the status of this. In linux-2.6.14-rc3 the 
COMMAND_LINE_SIZE is still 256 chars long.

Here's a patch to fix that to 1024.

Signed-off-by: Georg Lippold <lippold@uni-bremen.de>

--- linux/include/asm-i386/param.h~ 2005-09-21 23:32:23.000000000 +0200
+++ linux/include/asm-i386/param.h  2005-10-10 14:39:34.000000000 +0200
@@ -18,6 +18,6 @@
  #endif

  #define MAXHOSTNAMELEN 64      /* max length of hostname */
-#define COMMAND_LINE_SIZE 256
+#define COMMAND_LINE_SIZE 1024

  #endif
--- linux/include/asm-i386/setup.h~ 2005-10-10 14:39:18.000000000 +0200
+++ linux/include/asm-i386/setup.h  2005-10-10 14:39:45.000000000 +0200
@@ -17,7 +17,7 @@
  #define MAX_NONPAE_PFN (1 << 20)

  #define PARAM_SIZE 4096
-#define COMMAND_LINE_SIZE 256
+#define COMMAND_LINE_SIZE 1024

  #define OLD_CL_MAGIC_ADDR      0x90020
  #define OLD_CL_MAGIC           0xA33F
