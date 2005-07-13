Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261545AbVGMSr3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261545AbVGMSr3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 14:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262323AbVGMSpx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 14:45:53 -0400
Received: from mail.kroah.org ([69.55.234.183]:6115 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261545AbVGMSop (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 14:44:45 -0400
Date: Wed, 13 Jul 2005 11:43:50 -0700
From: Greg KH <gregkh@suse.de>
To: mkrufky@m1k.net
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk
Subject: [07/11] v4l cx88 hue offset fix
Message-ID: <20050713184350.GI9330@kroah.com>
References: <20050713184130.GA9330@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050713184130.GA9330@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------

Changed hue offset to 128 to correct behavior in cx88 cards.  Previously, 
setting 0% or 100% hue was required to avoid blue/green people on screen.  
Now, 50% Hue means no offset, just like bt878 stuff.

Signed-off-by: Michael Krufky <mkrufky@m1k.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
Signed-off-by: Chris Wright <chrisw@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/media/video/cx88/cx88-video.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.12.2.orig/drivers/media/video/cx88/cx88-video.c	2005-06-17 12:48:29.000000000 -0700
+++ linux-2.6.12.2/drivers/media/video/cx88/cx88-video.c	2005-07-13 10:56:14.000000000 -0700
@@ -261,7 +261,7 @@
 			.default_value = 0,
 			.type          = V4L2_CTRL_TYPE_INTEGER,
 		},
-		.off                   = 0,
+		.off                   = 128,
 		.reg                   = MO_HUE,
 		.mask                  = 0x00ff,
 		.shift                 = 0,
