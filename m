Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932747AbWCQOO1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932747AbWCQOO1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 09:14:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932736AbWCQOO1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 09:14:27 -0500
Received: from n36.shimpinomori.net ([219.127.89.36]:42666 "HELO ldh.org")
	by vger.kernel.org with SMTP id S932747AbWCQOO0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 09:14:26 -0500
From: vido@ldh.org
Date: Fri, 17 Mar 2006 23:14:03 +0900
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, sdhci-devel@list.drzeus.cx
Subject: [2.6.16-rc6-mm1] sdhci driver purrrfect
Message-ID: <20060317141403.GA19753@z.shimpinomori.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm sending this on behalf the SDHCI-devel people. I tested today the
latest SDHCI driver on my Thinkpad X40 with the 2.6.16-rc6-mm1 kernel.

The SD card reader itself is a Ricoh :
0000:02:00.1 0805: Ricoh Co Ltd R5C822 SD/SDIO/MMC/MS/MSPro Host Adapter (rev 13)


The initialisation part is normal, here is the dmesg portion :

sdhci: Secure Digital Host Controller Interface driver, 0.11
sdhci: Copyright(c) Pierre Ossman
PCI: Found IRQ 5 for device 0000:02:00.1
PCI: Sharing IRQ 5 with 0000:00:1f.3
PCI: Sharing IRQ 5 with 0000:00:1f.5
PCI: Sharing IRQ 5 with 0000:00:1f.6
cs: IO port probe 0x100-0x4ff: excluding 0x170-0x177 0x370-0x377
cs: IO port probe 0x800-0x8ff: clean.
cs: IO port probe 0xc00-0xcff: clean.
cs: IO port probe 0xa00-0xaff: clean.
mmc0: SDHCI at 0xd0210000 irq 5 PIO


I tested with 5 different SD card models (no MMC), correctly identified
upon insertion as shown below :
- Hagiwara "Super High Speed" 1 Gb (ac41 SK01G 967680KiB)
- Kingmax "Platinum" 1 Gb (b368 SD01G 999936KiB)
- SanDisk 512 Mb (a95c SD512 495488KiB)
- Generic 128 Mb (cdef SD128 118272KiB)
- Toshiba 16 Mb (6f52 SD016 14560KiB)

I found no problem to read, write or delete.

My opinion is that this patch is mature enough to become part of
the regular Linux kernel. 
Andrew please consider pushing the code to Linus in time for 2.6.16,
as it's a device with no current driver.

Regards,

-- 
Augustin Vidovic  --   http://augustin.vidovic.org

Can you doubt in french ?
Check it out at http://www.forum-zetetique.com
