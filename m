Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314542AbSDXFZ3>; Wed, 24 Apr 2002 01:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314543AbSDXFZ2>; Wed, 24 Apr 2002 01:25:28 -0400
Received: from mail.mesatop.com ([208.164.122.9]:31245 "EHLO thor.mesatop.com")
	by vger.kernel.org with ESMTP id <S314542AbSDXFZ2>;
	Wed, 24 Apr 2002 01:25:28 -0400
Subject: [PATCH] 2.5.9-dj1, add to help text in arch/s390/Config.help.
From: Steven Cole <elenstev@mesatop.com>
To: schwidefsky@de.ibm.com
Cc: Dave Jones <davej@suse.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1019625712.29005.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution/1.0.2-5mdk 
Date: 23 Apr 2002 23:23:05 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following snippet is from arch/s390/config.in:

if [ "$CONFIG_IPL" = "y" ]; then
  choice 'IPL method generated into head.S' \
          "tape                   CONFIG_IPL_TAPE \
           vm_reader              CONFIG_IPL_VM" tape
fi

This patch adds help for the vm_reader choice option.

Steven

--- linux-2.5.9-dj1/arch/s390/Config.help.orig	Tue Apr 23 20:28:41 2002
+++ linux-2.5.9-dj1/arch/s390/Config.help	Tue Apr 23 23:13:04 2002
@@ -155,7 +155,10 @@
   IPL device.
 
 CONFIG_IPL_TAPE
-  Select this option if you want to IPL the image from a Tape.
+  Select "tape" if you want to IPL the image from a Tape.
+
+  Select "vm_reader" if you are running under VM/ESA and want
+  to IPL the image from the emulated card reader.
 
 CONFIG_FAST_IRQ
   Select this option in order to get the interrupts processed faster



