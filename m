Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262092AbTLLWef (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 17:34:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262131AbTLLWef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 17:34:35 -0500
Received: from p508B5CF9.dip.t-dialin.net ([80.139.92.249]:36280 "EHLO
	mail.linux-mips.net") by vger.kernel.org with ESMTP id S262092AbTLLWcl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 17:32:41 -0500
Date: Fri, 12 Dec 2003 23:30:10 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.24-pre1: ask for CONFIG_INDYDOG only on mips
Message-ID: <20031212223009.GB19807@linux-mips.org>
References: <Pine.LNX.4.44.0312101417080.1546-100000@logos.cnet> <20031210204628.GA9103@fs.tum.de> <20031211225819.GA20373@linux-mips.org> <20031212213137.GE1825@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031212213137.GE1825@fs.tum.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 12, 2003 at 10:31:37PM +0100, Adrian Bunk wrote:

> Was the removal of the i386 Mwave support option in the same patch an 
> accident that should be reverted, or was there a reason for it?

Another accident, sigh ...  I've already sent below patch to Marcelo.

  Ralf

===== drivers/char/Config.in 1.61 vs edited =====
--- 1.61/drivers/char/Config.in	Wed Dec 10 18:51:15 2003
+++ edited/drivers/char/Config.in	Fri Dec 12 23:10:02 2003
@@ -389,4 +389,9 @@
 if [ "$CONFIG_MIPS_ITE8172" = "y" ]; then
   tristate ' ITE GPIO' CONFIG_ITE_GPIO
 fi
+
+if [ "$CONFIG_X86" = "y" ]; then
+   tristate 'ACP Modem (Mwave) support' CONFIG_MWAVE
+fi
+
 endmenu
