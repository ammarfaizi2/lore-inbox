Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265001AbTFQXNe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 19:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265003AbTFQXNe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 19:13:34 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:31187 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265001AbTFQXNd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 19:13:33 -0400
Date: Wed, 18 Jun 2003 01:27:26 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: James Simmons <jsimmons@infradead.org>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [2.5 patch] fix for drivers/video/sis/init301.c
Message-ID: <20030617232726.GI29247@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

the following patch fixes some nonsense in drivers/video/sis/init301.c . 
I've tested the compilation with 2.5.72.

--- linux-2.5.72/drivers/video/sis/init301.c.old	2003-06-18 01:22:27.000000000 +0200
+++ linux-2.5.72/drivers/video/sis/init301.c	2003-06-18 01:23:23.000000000 +0200
@@ -5282,7 +5282,7 @@
 #ifdef SIS315H	/* 310/325 series */
 
 	if(SiS_Pr->SiS_IF_DEF_CH70xx != 0) {
-		temp =  temp = SiS_GetCH701x(SiS_Pr,0x61);
+		temp = SiS_GetCH701x(SiS_Pr,0x61);
 		if(temp < 1) {
 		   SiS_SetCH701x(SiS_Pr,0xac76);
 		   SiS_SetCH701x(SiS_Pr,0x0066);



Please apply
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

