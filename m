Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750758AbVHUBdu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbVHUBdu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 21:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbVHUBdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 21:33:50 -0400
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:48012 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S1750758AbVHUBdt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 21:33:49 -0400
Date: Sun, 21 Aug 2005 03:32:57 +0200
To: linux-usb-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problems with connect/disconnect cycles
Message-ID: <20050821013257.GA31597@gamma.logic.tuwien.ac.at>
References: <20050321090537.GI14614@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050321090537.GI14614@gamma.logic.tuwien.ac.at>
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi USB developers, hi Andrew!

On Mon, 21 Mär 2005, preining wrote:
> Dear usb developers, dear Andrew!
> 
> I found that my builtin sd card reader connected via USB port
> experiences several connect/reconnect cycles every time I boot.
> 
> I am using 2.6.11-mm4.

Same now with 2.6.13-rc6-mm1. This time it got really bad:

Aug 20 14:00:19 gandalf vmunix: usb 2-2: USB disconnect, address 2
Aug 20 14:00:19 gandalf kernel: usb 2-2: new full speed USB device using uhci_hcd and address 3
Aug 20 14:00:19 gandalf kernel: scsi1 : SCSI emulation for USB Mass Storage devices
Aug 20 14:00:19 gandalf kernel: usb-storage: device found at 3
Aug 20 14:00:19 gandalf kernel: usb-storage: waiting for device to settle before scanning
Aug 20 14:00:21 gandalf usb.agent[6109]:      usb-storage: already loaded
Aug 20 14:00:24 gandalf vmunix:   Vendor: Generic   Model: Flash R/W         Rev: 2002
Aug 20 14:00:24 gandalf vmunix:   Type:   Direct-Access                      ANSI SCSI revision: 02
Aug 20 14:00:24 gandalf vmunix: Attached scsi removable disk sda at scsi1, channel 0, id 0, lun 0
Aug 20 14:00:24 gandalf kernel: usb-storage: device scan complete
Aug 20 14:00:26 gandalf scsi.agent[6154]:      sd_mod: loaded successfully (for disk)

....

Aug 21 01:55:44 gandalf vmunix: usb 2-2: USB disconnect, address 32
Aug 21 01:55:44 gandalf kernel: usb 2-2: new full speed USB device using uhci_hcd and address 33
Aug 21 01:55:44 gandalf kernel: scsi32 : SCSI emulation for USB Mass Storage devices
Aug 21 01:55:44 gandalf kernel: usb-storage: device found at 33
Aug 21 01:55:44 gandalf kernel: usb-storage: waiting for device to settle before scanning
Aug 21 01:55:47 gandalf usb.agent[17503]:      usb-storage: already loaded
Aug 21 01:55:49 gandalf vmunix:   Vendor: Generic   Model: Flash R/W         Rev: 2002
Aug 21 01:55:49 gandalf vmunix:   Type:   Direct-Access                      ANSI SCSI revision: 02
Aug 21 01:55:49 gandalf kernel: Attached scsi removable disk sda at scsi32, channel 0, id 0, lun 0
Aug 21 01:55:49 gandalf vmunix: usb-storage: device scan complete
Aug 21 01:55:50 gandalf scsi.agent[17544]:      sd_mod: loaded successfully (for disk)


uuu, now many of these

Aug 21 02:09:18 gandalf vmunix:     ACPI-0131: *** Error: Invalid owner_id: 00


and many many more of these:

Aug 21 03:07:19 gandalf vmunix:     ACPI-0096: *** Error: Could not allocate new owner_id (32 max), AE_OWNER_ID_LIMIT



Unfortunately I cannot in any way track down this problem to specific
kernels, or specific work situations. It sometimes happens, sometimes
not. 

If anyone has any idea how to debug such a stupid problem, I would be
glad. 

Best wishes

Norbert

-------------------------------------------------------------------------------
Dr. Norbert Preining <preining AT logic DOT at>             Università di Siena
sip:preining@at43.tuwien.ac.at                             +43 (0) 59966-690018
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
HUCKNALL (vb.)
To crouch upwards: as in the movement of a seated person's feet and
legs made in order to allow a cleaner's hoover to pass beneath them.
			--- Douglas Adams, The Meaning of Liff
