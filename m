Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270935AbTGQUWO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 16:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270948AbTGQUWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 16:22:14 -0400
Received: from pd146.bielsko.sdi.tpnet.pl ([217.96.247.146]:34834 "EHLO
	aquila.wombb.edu.pl") by vger.kernel.org with ESMTP id S270935AbTGQUWD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 16:22:03 -0400
Date: Thu, 17 Jul 2003 22:36:56 +0200
From: =?iso-8859-2?Q?Przemys=B3aw_Stanis=B3aw?= Knycz 
	<zolw@wombb.edu.pl>
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [linux-2.6.0-test1] Missing #include lines with alsa at alpha
Message-ID: <20030717203656.GA30959@aquila.wom.lan>
References: <20030717092432.5737d88c.zolw@wombb.edu.pl> <s5hsmp5zdwg.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <s5hsmp5zdwg.wl@alsa2.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 17, 2003 at 11:43:59AM +0200, Takashi Iwai wrote:
> could you tell me which file exactly?

sound/
./pcmcia/vx/vxpocket.c
./pci/rme9652/hdsp.c
./drivers/opl4/opl4_lib.c

--- ./sound/pcmcia/vx/vxpocket.c~     2003-07-14 05:31:21.000000000 +0200
+++ ./sound/pcmcia/vx/vxpocket.c      2003-07-16 22:06:22.000000000 +0200
@@ -35,6 +35,7 @@
 #include <pcmcia/version.h>
 #include "vxpocket.h"
 #include <sound/initval.h>
+#include <linux/init.h>
  
 /*
  */
--- ./sound/pci/rme9652/hdsp.c~       2003-07-14 05:32:41.000000000 +0200
+++ ./sound/pci/rme9652/hdsp.c        2003-07-16 22:03:09.000000000 +0200
@@ -26,6 +26,7 @@
 #include <linux/interrupt.h>
 #include <linux/slab.h>
 #include <linux/pci.h>
+#include <linux/init.h>
  
 #include <sound/core.h>
 #include <sound/control.h>
--- ./sound/drivers/opl4/opl4_lib.c~  2003-07-17 22:07:25.000000000 +0200
+++ ./sound/drivers/opl4/opl4_lib.c   2003-07-17 22:15:24.000000000 +0200
@@ -21,6 +21,7 @@
 #include <sound/initval.h>
 #include <linux/ioport.h>
 #include <asm/io.h>
+#include <linux/init.h>
  
 MODULE_AUTHOR("Clemens Ladisch <clemens@ladisch.de>");
 MODULE_DESCRIPTION("OPL4 driver");


This patches allow to build it without problems. Happy bugtracking :)

-- 
.----[ a d m i n at w o m b b dot e d u dot p l ]----.
| Przemys³aw Stanis³aw Knycz,  Registered Linux User |
| Net/Sys Administrator, PLD Developer,       213344 |
`------ "Linux - the choice of GNU generation" ------'
