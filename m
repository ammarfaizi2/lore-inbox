Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264677AbUEJMp6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264677AbUEJMp6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 08:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264674AbUEJMp5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 08:45:57 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:14794 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264677AbUEJMpt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 08:45:49 -0400
Date: Mon, 10 May 2004 14:45:43 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.6-mm1: a different CONFIG_STANDALONE approach
Message-ID: <20040510124543.GI9028@fs.tum.de>
References: <20040510024506.1a9023b6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040510024506.1a9023b6.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2004 at 02:45:06AM -0700, Andrew Morton wrote:
>...
> All 391 patches:
>...
> CONFIG_STANDALONE-default-to-n.patch
>   Make CONFIG_STANDALONE default to N
>...

I'd prefer to solve this issue with the following patch, that makes it 
still possible to select CONFIG_STANDALONE with EXPERIMENTAL=n:


--- init/Kconfig.old	2004-05-10 14:41:42.000000000 +0200
+++ init/Kconfig	2004-05-10 14:42:08.000000000 +0200
@@ -42,7 +42,7 @@
 	  If unsure, say Y
 
 config STANDALONE
-	bool "Select only drivers that don't need compile-time external firmware" if EXPERIMENTAL
+	bool "Select only drivers that don't need compile-time external firmware"
 	default y
 	help
 	  Select this option if you don't have magic firmware for drivers that


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

