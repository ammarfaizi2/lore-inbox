Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270546AbRHNKtj>; Tue, 14 Aug 2001 06:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270545AbRHNKta>; Tue, 14 Aug 2001 06:49:30 -0400
Received: from mailgate.indstate.edu ([139.102.15.118]:19454 "EHLO
	mailgate.indstate.edu") by vger.kernel.org with ESMTP
	id <S270541AbRHNKtZ>; Tue, 14 Aug 2001 06:49:25 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rich Baum <richbaum@acm.org>
To: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH] fixed fix 2.4.8 compile errors
Date: Tue, 14 Aug 2001 05:49:27 -0500
X-Mailer: KMail [version 1.2.9]
In-Reply-To: <100C620A6B75@coral.indstate.edu> <1013D72A35C6@coral.indstate.edu> <20010814114446.A23566@flint.arm.linux.org.uk>
In-Reply-To: <20010814114446.A23566@flint.arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <1014201B0F4F@coral.indstate.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed.  Sorry.

On Tuesday 14 August 2001 05:44 am, you wrote:
> On Tue, Aug 14, 2001 at 05:32:16AM -0500, Rich Baum wrote:
> > Thanks for the input.  I've fixed this patch to include the fis.
>
> You missed the one below.
>

diff -urN -X dontdiff linux-2.4.8/drivers/video/Config.in 
rb/drivers/video/Config.in
--- linux-2.4.8/drivers/video/Config.in	Sat Aug 11 11:10:30 2001
+++ rb/drivers/video/Config.in	Mon Aug 13 20:43:46 2001
@@ -103,7 +103,8 @@
    fi
    tristate '  NEC PowerVR 2 display support' CONFIG_FB_PVR2
    dep_bool '    Debug pvr2fb' CONFIG_FB_PVR2_DEBUG $CONFIG_FB_PVR2
-   bool '  Epson 1355 framebuffer support' CONFIG_FB_E1355
+   if [ "$ARCH" = "sh" ]; then
+      bool '  Epson 1355 framebuffer support' CONFIG_FB_E1355
+   fi
    if [ "$CONFIG_FB_E1355" = "y" ]; then
       hex '    Register Base Address' CONFIG_E1355_REG_BASE a8000000
       hex '    Framebuffer Base Address' CONFIG_E1355_FB_BASE a8200000
