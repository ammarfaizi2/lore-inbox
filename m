Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264533AbSIVUso>; Sun, 22 Sep 2002 16:48:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264538AbSIVUsO>; Sun, 22 Sep 2002 16:48:14 -0400
Received: from [195.39.17.254] ([195.39.17.254]:10368 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S264534AbSIVUrL>;
	Sun, 22 Sep 2002 16:47:11 -0400
Date: Sat, 21 Sep 2002 23:09:15 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Grover <andrew.grover@intel.com>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Thermal fix
Message-ID: <20020921210915.GA31794@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Without this, thermal support will happily cook your machine. Well if
it does cook it was non-compliant, it should have shut down. Anyway,
this is important, please apply.
								Pavel
PS: Is it possible that broken thermal support killed my harddrive? I
was experiencing some overheats, now drive developed bad sectors :-(.

--- clean/drivers/acpi/processor.c	2002-07-29 20:02:23.000000000 +0200
+++ linux-swsusp/drivers/acpi/processor.c	2002-09-21 13:07:50.000000000 +0200
@@ -1468,6 +1468,9 @@
 	 * performance state.
 	 */
 
+	px = pr->limit.thermal.px;
+	tx = pr->limit.thermal.tx;
+
 	switch (type) {
 
 	case ACPI_PROCESSOR_LIMIT_NONE:

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
