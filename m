Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbTFXKn5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 06:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261887AbTFXKn4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 06:43:56 -0400
Received: from mail018.syd.optusnet.com.au ([210.49.20.176]:14287 "EHLO
	mail018.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261872AbTFXKnP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 06:43:15 -0400
Date: Tue, 24 Jun 2003 20:56:05 +1000
To: trivial@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Subject: [TRIVIAL PATCH] Fix for no boot logo
Message-ID: <20030624105605.GB8052@cancer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Stewart Smith <stewart@linux.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Discussed a while ago, someone submitted this patch to get the boot logo to reappear. Russell King resubmitted it a while ago, but it doesn't seem to have come up anywhere, so I'm taking the job of trivializing it :)

Worked for me when I tried it :)

--- linux-2.5.73/drivers/video/cfbimgblt.c	2003-05-05 09:53:31.000000000 +1000
+++ linux-2.5.73-stew1/drivers/video/cfbimgblt.c	2003-06-24 20:53:17.000000000 +1000
@@ -325,7 +325,7 @@
 		else 
 			slow_imageblit(image, p, dst1, fgcolor, bgcolor,
 					start_index, pitch_index);
-	} else if (image->depth == bpp) 
+	} else if (image->depth <= bpp) 
 		color_imageblit(image, p, dst1, start_index, pitch_index);
 }
 



-- 
Stewart Smith
Vice President, Linux Australia
http://www.linux.org.au (personal: http://www.flamingspork.com)
