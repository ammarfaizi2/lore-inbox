Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135856AbRECRzN>; Thu, 3 May 2001 13:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135871AbRECRzG>; Thu, 3 May 2001 13:55:06 -0400
Received: from green.mif.pg.gda.pl ([153.19.42.8]:5895 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S135868AbRECRyQ>; Thu, 3 May 2001 13:54:16 -0400
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200105031754.TAA17827@green.mif.pg.gda.pl>
Subject: [PATCH] menuconfig
To: torvalds@transmeta.com (Linus Torvalds),
        alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Thu, 3 May 2001 19:54:02 +0200 (CEST)
Cc: linux-kernel@vger.kernel.org (kernel list)
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
   The following one-liner patch fixes the problem in menuconfig with
handling choice lists containing parentheses (in 2.4.4-ac4 and 2.4.5-pre1).
Please apply...


--- scripts/Menuconfig~	Mon Nov 13 23:14:29 2000
+++ scripts/Menuconfig	Thu May  3 19:45:25 2001
@@ -347,7 +347,7 @@
 
 	echo -e "
 	function $firstchoice () \
-		{ l_choice '$title' \"$choices\" $current ;}" >>MCradiolists
+		{ l_choice '$title' \"$choices\" \"$current\" ;}" >>MCradiolists
 }
 
 } # END load_functions()


-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk
