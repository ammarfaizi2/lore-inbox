Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261198AbVDSCDX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261198AbVDSCDX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 22:03:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261269AbVDSCDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 22:03:23 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:37645 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261198AbVDSCDS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 22:03:18 -0400
Date: Tue, 19 Apr 2005 04:03:12 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, jkmaline@cc.hut.fi
Cc: linux-kernel@vger.kernel.org, hostap@shmoo.com, jgarzik@pobox.com,
       netdev@oss.sgi.com
Subject: 2.6.12-rc2-mm3: hostap: do not #include .c files
Message-ID: <20050419020312.GR5489@stusta.de>
References: <20050411012532.58593bc1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050411012532.58593bc1.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2005 at 01:25:32AM -0700, Andrew Morton wrote:
>...
> All 819 patches:
>...
> bk-netdev.patch
>...

drivers/net/wireless/hostap/hostap.c:#include "hostap_crypt.c"
drivers/net/wireless/hostap/hostap.c:#include "hostap_ap.c"
drivers/net/wireless/hostap/hostap.c:#include "hostap_info.c"
drivers/net/wireless/hostap/hostap.c:#include "hostap_ioctl.c"
drivers/net/wireless/hostap/hostap.c:#include "hostap_proc.c"
drivers/net/wireless/hostap/hostap.c:#include "hostap_80211_rx.c"
drivers/net/wireless/hostap/hostap.c:#include "hostap_80211_tx.c"
drivers/net/wireless/hostap/hostap_cs.c:#include "hostap_hw.c"
drivers/net/wireless/hostap/hostap_hw.c:#include "hostap_download.c"
drivers/net/wireless/hostap/hostap_hw.c:#include "hostap_callback.c"
drivers/net/wireless/hostap/hostap_pci.c:#include "hostap_hw.c"
drivers/net/wireless/hostap/hostap_plx.c:#include "hostap_hw.c"

Please do not #include .c files.

A proper separation in a .c file and a header file is the better 
solution.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

