Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287794AbSBNIba>; Thu, 14 Feb 2002 03:31:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287966AbSBNIbK>; Thu, 14 Feb 2002 03:31:10 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:19979 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S287794AbSBNIbD>; Thu, 14 Feb 2002 03:31:03 -0500
Date: Thu, 14 Feb 2002 02:30:50 -0600
To: Alessandro Suardi <alessandro.suardi@oracle.com>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        Jaroslav Kysela <perex@perex.cz>
Subject: [upatch] Re: linux-2.5.5-pre1
Message-ID: <20020214083050.GF1598@cadcamlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Alessandro Suardi]
>   More issues:
>
>     - xconfig broken

Untested but obvious..

--- 2.5.5pre1/sound/Config.in~	Wed Feb 13 20:57:11 2002
+++ 2.5.5pre1/sound/Config.in	Thu Feb 14 02:26:21 2002
@@ -19,13 +19,13 @@
   source sound/core/Config.in
   source sound/drivers/Config.in
 fi
-if [ "$CONFIG_SND" != "n" -a "$CONFIG_ISA" == "y" ]; then
+if [ "$CONFIG_SND" != "n" -a "$CONFIG_ISA" = "y" ]; then
   source sound/isa/Config.in
 fi
-if [ "$CONFIG_SND" != "n" -a "$CONFIG_PCI" == "y" ]; then
+if [ "$CONFIG_SND" != "n" -a "$CONFIG_PCI" = "y" ]; then
   source sound/pci/Config.in
 fi
-if [ "$CONFIG_SND" != "n" -a "$CONFIG_PPC" == "y" ]; then
+if [ "$CONFIG_SND" != "n" -a "$CONFIG_PPC" = "y" ]; then
   source sound/ppc/Config.in
 fi
 
