Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313898AbSEMPhE>; Mon, 13 May 2002 11:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314061AbSEMPhE>; Mon, 13 May 2002 11:37:04 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:58244
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S313898AbSEMPhD>; Mon, 13 May 2002 11:37:03 -0400
Date: Mon, 13 May 2002 08:36:22 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.15 IDE 62
Message-ID: <20020513153622.GE721@opus.bloom.county>
In-Reply-To: <Pine.LNX.4.44.0205052046590.1405-100000@home.transmeta.com> <3CDFAEC0.6050403@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2002 at 02:17:04PM +0200, Martin Dalecki wrote:

> Mon May 13 12:38:11 CEST 2002 ide-clean-62

Hello.  Since include/linux/ide.h has a 'u8', a 'u16', and a 'u64' can
you apply the following so that it doesn't rely in <asm/types.h> being
included indirectly?

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

===== include/linux/ide.h 1.60 vs edited =====
--- 1.60/include/linux/ide.h	Thu May  9 11:43:58 2002
+++ edited/include/linux/ide.h	Mon May 13 08:34:32 2002
@@ -17,6 +17,7 @@
 #include <linux/bitops.h>
 #include <asm/byteorder.h>
 #include <asm/hdreg.h>
+#include <asm/types.h>
 
 /*
  * This is the multiple IDE interface driver, as evolved from hd.c.
