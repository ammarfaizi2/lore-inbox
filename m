Return-Path: <linux-kernel-owner+w=401wt.eu-S1751192AbXANJKP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbXANJKP (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 04:10:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbXANJKO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 04:10:14 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:1814 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751192AbXANJKM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 04:10:12 -0500
Date: Sun, 14 Jan 2007 10:10:16 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       David Brownell <dbrownell@users.sourceforge.net>,
       Geoff Levand <geoffrey.levand@am.sony.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Tony Olech <tony.olech@elandigitalsystems.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: 2.6.20-rc4-mm1: different values for OHCI_QUIRK_ZFMICRO
Message-ID: <20070114091016.GS7469@stusta.de>
References: <20070111222627.66bb75ab.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070111222627.66bb75ab.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<--  snip  -->

...
  CC      drivers/usb/misc/ftdi-elan.o
/home/bunk/linux/kernel-2.6/linux-2.6.20-rc4-mm1/drivers/usb/misc/ftdi-elan.c:2307:1: warning: "OHCI_QUIRK_ZFMICRO" redefined
In file included from /home/bunk/linux/kernel-2.6/linux-2.6.20-rc4-mm1/drivers/usb/misc/ftdi-elan.c:76:
/home/bunk/linux/kernel-2.6/linux-2.6.20-rc4-mm1/drivers/usb/misc/../host/ohci.h:399:1: warning: this is the location of the previous definition
...
$ grep -r ^#define * | grep OHCI_QUIRK_ZFMICRO  
drivers/usb/host/ohci.h:#define OHCI_QUIRK_ZFMICRO      0x20                   /* Compaq ZFMicro chipset*/
drivers/usb/host/u132-hcd.c:#define OHCI_QUIRK_ZFMICRO 0x10
drivers/usb/misc/ftdi-elan.c:#define OHCI_QUIRK_ZFMICRO 0x10
$ 

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

