Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268760AbTCCUPJ>; Mon, 3 Mar 2003 15:15:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268761AbTCCUPI>; Mon, 3 Mar 2003 15:15:08 -0500
Received: from serenity.mcc.ac.uk ([130.88.200.93]:63506 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S268760AbTCCUPI>; Mon, 3 Mar 2003 15:15:08 -0500
Date: Mon, 3 Mar 2003 20:25:34 +0000
From: John Levon <levon@movementarian.org>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org,
       ambx1@neo.rr.com
Cc: torvalds@transmeta.com
Subject: Re: [PATCH] Another bitop on boolean in pnpbios
Message-ID: <20030303202534.GA24517@compsoc.man.ac.uk>
References: <20030303054235.GA58427@compsoc.man.ac.uk> <20030303095643.GO1195@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030303095643.GO1195@holomorphy.com>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18pwVC-0000BW-00*vOn38D7kPgo*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 03, 2003 at 01:56:43AM -0800, William Lee Irwin III wrote:

> pnpbios_is_static() could probably use the same treatment.

Sure. Linus, at least one  of the below actually broke...

regards
john

--- linux-linus/include/linux/pnpbios.h	2003-01-13 22:43:41.000000000 +0000
+++ linux/include/linux/pnpbios.h	2003-03-03 20:28:43.000000000 +0000
@@ -85,8 +85,8 @@
 #define PNPBIOS_BOOTABLE		0x0010
 #define PNPBIOS_DOCK			0x0020
 #define PNPBIOS_REMOVABLE		0x0040
-#define pnpbios_is_static(x) ((x)->flags & 0x0100) == 0x0000
-#define pnpbios_is_dynamic(x) (x)->flags & 0x0080
+#define pnpbios_is_static(x) (((x)->flags & 0x0100) == 0x0000)
+#define pnpbios_is_dynamic(x) ((x)->flags & 0x0080)
 
 /* 0x8000 through 0xffff are OEM defined */
 
