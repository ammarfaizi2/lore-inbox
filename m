Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262584AbTFOSc5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 14:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262589AbTFOSci
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 14:32:38 -0400
Received: from ossipee.unh.edu ([132.177.137.39]:22492 "EHLO ossipee.unh.edu")
	by vger.kernel.org with ESMTP id S262584AbTFOSb4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 14:31:56 -0400
Date: Sun, 15 Jun 2003 14:45:46 -0400
From: Samuel Thibault <Samuel.Thibault@ens-lyon.fr>
To: linux-kernel@vger.kernel.org
Subject: [2.5 patch] ma600.c won't compile
Message-ID: <20030615184546.GA759@bouh.unh.edu>
Reply-To: Samuel Thibault <samuel.thibault@fnac.net>
Mail-Followup-To: Samuel Thibault <Samuel.Thibault@ens-lyon.fr>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i-nntp
X-MailScanner-Information: http://pubpages.unh.edu/notes/mailfiltering.html
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-8.7, required 5,
	BAYES_01, PATCH_UNIFIED_DIFF, USER_AGENT_MUTT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

At least gcc 3.3 complains about this (silly ?) thing in the ASSERT
macro of drivers/net/irda/ma600.c (func is generally 'return -1;')

Regards,
Samuel Thibault

--- linux-2.5.71-orig/drivers/net/irda/ma600.c	2003-05-26 21:00:39.000000000 -0400
+++ linux-2.5.71-perso/drivers/net/irda/ma600.c	2003-06-14 17:30:28.000000000 -0400
@@ -52,7 +52,7 @@
 	if(!(expr)) { \
 	        printk( "Assertion failed! %s,%s,%s,line=%d\n",\
         	#expr,__FILE__,__FUNCTION__,__LINE__); \
-	        ##func}
+	        func}
 #endif
 
 /* convert hex value to ascii hex */
