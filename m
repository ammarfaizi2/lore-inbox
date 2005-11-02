Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932135AbVKBBUQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135AbVKBBUQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 20:20:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932148AbVKBBUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 20:20:16 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:32009 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932135AbVKBBUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 20:20:15 -0500
Date: Wed, 2 Nov 2005 02:20:11 +0100
From: Adrian Bunk <bunk@stusta.de>
To: zippel@linux-m68k.org
Cc: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: kconfig re-asks questions if a new dependency is added
Message-ID: <20051102012011.GD8009@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roman,

my "schedule obsolete OSS drivers for removal" patch does the following:

...
+config OBSOLETE_OSS_DRIVER
+       bool "Obsolete OSS drivers"
+       depends on SOUND_PRIME
...
 config SOUND_BT878
        tristate "BT878 audio dma"
-       depends on SOUND_PRIME && PCI
+       depends on SOUND_PRIME && PCI && OBSOLETE_OSS_DRIVER
...

The probem is when I'm running "make oldconfig" after applying this 
patch and say yes to OBSOLETE_OSS_DRIVER, I'm re-asked all the options 
now depending on OBSOLETE_OSS_DRIVER I had previously selected.

This is not a big issue in this specific case, but in other cases this 
might be quite annoying.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

