Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750900AbWBJAn5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750900AbWBJAn5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 19:43:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750901AbWBJAn5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 19:43:57 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:55813 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750899AbWBJAn4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 19:43:56 -0500
Date: Fri, 10 Feb 2006 01:43:55 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, David Vrabel <dvrabel@arcom.com>
Cc: linux-kernel@vger.kernel.org, Antonino Daplas <adaplas@pol.net>,
       linux-fbdev-devel@lists.sourceforge.net
Subject: [-mm patch] drivers/video/geode/video_gx.c: make struct gx_pll_table_48MHz static
Message-ID: <20060210004355.GJ3524@stusta.de>
References: <20060207220627.345107c3.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060207220627.345107c3.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2006 at 10:06:27PM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.16-rc1-mm5:
>...
> +fbdev-framebuffer-driver-for-geode-gx.patch
>...
>  fbdev updates/drivers/fixes
>...


There is no good reason for struct gx_pll_table_48MHz being global.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.16-rc2-mm1-full/drivers/video/geode/video_gx.c.old	2006-02-10 00:55:07.000000000 +0100
+++ linux-2.6.16-rc2-mm1-full/drivers/video/geode/video_gx.c	2006-02-10 00:56:13.000000000 +0100
@@ -34,7 +34,7 @@
 #define PREMULT2 ((u32)MSR_GLCP_SYS_RSTPLL_DOTPREMULT2)
 #define PREDIV2  ((u32)MSR_GLCP_SYS_RSTPLL_DOTPOSTDIV3)
 
-struct gx_pll_entry gx_pll_table_48MHz[] = {
+static struct gx_pll_entry gx_pll_table_48MHz[] = {
 	{ 40123, POSTDIV3,	    0x00000BF2 },	/*  24.9230 */
 	{ 39721, 0,		    0x00000037 },	/*  25.1750 */
 	{ 35308, POSTDIV3|PREMULT2, 0x00000B1A },	/*  28.3220 */
