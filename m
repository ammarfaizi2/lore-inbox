Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262600AbVCPOXG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262600AbVCPOXG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 09:23:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262601AbVCPOXF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 09:23:05 -0500
Received: from bernache.ens-lyon.fr ([140.77.167.10]:60623 "EHLO
	bernache.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S262600AbVCPOWt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 09:22:49 -0500
Date: Wed, 16 Mar 2005 15:22:49 +0100
From: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-mm4
Message-ID: <20050316142248.GI29333@ens-lyon.fr>
References: <20050316040654.62881834.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050316040654.62881834.akpm@osdl.org>
User-Agent: Mutt/1.5.8i
X-Spam-Report: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2005 at 04:06:54AM -0800, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11/2.6.11-mm4/
> 
> - fbdev update
>
It doesn't compile with gcc-4.0.

drivers/video/console/fbcon.c:133: error: static declaration of ‘fb_con’
follows non-static declaration
drivers/video/console/fbcon.h:166: error: previous declaration of
‘fb_con’ was here

Signed-off-by: Benoit Boissinot <benoit.boissinot@ens-lyon.org>

--- linux-test/drivers/video/console/fbcon.h	2005-03-16 15:15:57.000000000 +0100
+++ linux/drivers/video/console/fbcon.h	2005-03-16 15:14:18.000000000 +0100
@@ -163,6 +163,4 @@ extern void fbcon_set_tileops(struct vc_
 #endif
 extern void fbcon_set_bitops(struct fbcon_ops *ops);
 
-extern const struct consw fb_con;
-
 #endif /* _VIDEO_FBCON_H */

