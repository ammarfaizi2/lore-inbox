Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261607AbVFTVPR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261607AbVFTVPR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 17:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261603AbVFTVMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 17:12:08 -0400
Received: from mail.dif.dk ([193.138.115.101]:19338 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261548AbVFTVJd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 17:09:33 -0400
Date: Mon, 20 Jun 2005 23:15:03 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: Luc Saillard <luc@saillard.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][2/3] pwc-uncompress cleanup - add missing default switch
 case.
Message-ID: <Pine.LNX.4.62.0506202311270.2369@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a missing default: case to the switch statement in 
drivers/usb/media/pwc/pwc-uncompress.c::pwc_decompress()
This change fixes the following compiler warning:
	drivers/usb/media/pwc/pwc-uncompress.c: In function `pwc_decompress':
	drivers/usb/media/pwc/pwc-uncompress.c:140: warning: unreachable code at beginning of switch statement
and has the added bennefit of making the switch statement function the way 
it's supposed to.

This patch is incremental on top of the previous [PATCH][1/3]


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
---

 drivers/usb/media/pwc/pwc-uncompress.c |    1 +
 1 files changed, 1 insertion(+)

--- linux-2.6.12/drivers/usb/media/pwc/pwc-uncompress.c.with_patch_1	2005-06-20 22:54:15.000000000 +0200
+++ linux-2.6.12/drivers/usb/media/pwc/pwc-uncompress.c	2005-06-20 22:54:42.000000000 +0200
@@ -137,6 +137,7 @@ int pwc_decompress(struct pwc_device *pd
 			case 646:
 			/* TODO & FIXME */
 #endif
+			default:
 			/* No such device or address: missing decompressor */
 				return -ENXIO;
 				break;




