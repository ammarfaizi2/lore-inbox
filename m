Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264682AbUEJM55@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264682AbUEJM55 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 08:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264693AbUEJM55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 08:57:57 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:55241 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264682AbUEJM5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 08:57:47 -0400
Date: Mon, 10 May 2004 14:57:41 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm1: a different CONFIG_STANDALONE approach
Message-ID: <20040510125741.GK9028@fs.tum.de>
References: <20040510024506.1a9023b6.akpm@osdl.org> <20040510124543.GI9028@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040510124543.GI9028@fs.tum.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please discard my previous patch, I meant:


--- linux-2.6.5-mm6-full/init/Kconfig.old	2004-04-16 20:27:07.000000000 +0200
+++ linux-2.6.5-mm6-full/init/Kconfig	2004-04-16 20:27:17.000000000 +0200
@@ -42,7 +42,7 @@
 	  If unsure, say Y
 
 config STANDALONE
-	bool "Select only drivers that don't need compile-time external firmware" if EXPERIMENTAL
+	bool "Select only drivers that don't need compile-time external firmware"
 	default n
 	help
 	  Select this option if you don't have magic firmware for drivers that


applied on top of your patch to make it possible to select STANDALONE 
with EXPERIMENTAL=n.


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

