Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265772AbTHBOsd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 10:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267274AbTHBOsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 10:48:32 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:56972
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S265772AbTHBOsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 10:48:32 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: linux-kernel@vger.kernel.org
Subject: More fun with menuconfig...
Date: Sat, 2 Aug 2003 06:05:58 -0400
User-Agent: KMail/1.5
Cc: zippel@linux-m68k.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308020605.58423.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So I have a .config with CONFIG_ADVANCED_PARTION not set, and 
CONFIG_MSDOS_PARTITION=y.  (I.E. the default from arch/i386/defconfig.)

I fire up make menuconfig and expand the advanced partition menu (setting 
CONFIG_ADVANCED_PARTITION to y).  MSDOS partition support is NOT set in the 
newly opened menu, I.E. opening the menu has the side effect of deselecting 
CONFIG_MSDOS_PARTITION.

If I do nothing else, and save with the menu open, it's off.  (Saved as "not 
set".)  If I fire it up again and close the menu, CONFIG_MSDOS_PARTITION 
becomes Y again.

What magic am I failing to understand here?  (This sort of seems intentional, 
but it would make more sense for MSDOS partition support to default to on 
when you first open the menu...)

Rob
