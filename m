Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267771AbTAHHvq>; Wed, 8 Jan 2003 02:51:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267773AbTAHHvq>; Wed, 8 Jan 2003 02:51:46 -0500
Received: from adsl-66-112-90-25-rb.spt.centurytel.net ([66.112.90.25]:11392
	"EHLO carthage") by vger.kernel.org with ESMTP id <S267771AbTAHHvo>;
	Wed, 8 Jan 2003 02:51:44 -0500
Date: Wed, 8 Jan 2003 01:55:39 -0600
From: James Curbo <phoenix@sandwich.net>
To: andre@linux-ide.org
Cc: linux-kernel@vger.kernel.org
Subject: small fix for nforce ide chipset driver in 2.5.54
Message-ID: <20030108075539.GA4128@carthage>
Reply-To: James Curbo <phoenix@sandwich.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Debian GNU/Linux
Organization: Henderson State University, Arkadelphia, AR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently acquired an Epox 8RDA motherboard, which uses the Nforce2
chipset. While trying to compile 2.5.54 I ran across an error in
drivers/ide/pci/nvidia.c. Several times the define
PCI_DEVICE_ID_NVIDIA_NFORCE_IDE is referenced, but is not defined
anywhere. It seems it is missing from include/linux/pci_ids.h. On my
board it shows up as:

00:09.0 IDE interface: nVidia Corporation: Unknown device 0065 (rev a2)
(prog-if 8a [Master SecP PriP])

so I added a #define for PCI_DEVICE_ID_NVIDIA_NFORCE_IDE as 0x0065. It
compiled fine and I am in fact running that kernel now. I would have
just sent a patch but I am new to kernel hacking, this is just a one
liner and I'm sure you know where it goes better than I do.

thanks, James

-- 
James Curbo <hannibal@adtrw.org> <phoenix@sandwich.net>
