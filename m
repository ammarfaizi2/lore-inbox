Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286207AbSBKCAc>; Sun, 10 Feb 2002 21:00:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286303AbSBKCAW>; Sun, 10 Feb 2002 21:00:22 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:60429 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S286207AbSBKCAK>; Sun, 10 Feb 2002 21:00:10 -0500
Message-ID: <3C6725A6.9E9AEC14@delusion.de>
Date: Mon, 11 Feb 2002 03:00:06 +0100
From: "Udo A. Steinberg" <reality@delusion.de>
Organization: Disorganized
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.3 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Gerd Knorr <kraxel@bytesex.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: bttv driver broken in 2.5.4-pre
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Gerd,

The latest changes in the 2.5.4 prepatches throw linker errors which seem to be caused by
bttv-driver.c using obsolete functions:

drivers/media/media.o: In function `make_vbitab':
drivers/media/media.o(.text+0x77ff): undefined reference to `virt_to_bus_not_defined_use_pci_map'
drivers/media/media.o(.text+0x7806): undefined reference to `virt_to_bus_not_defined_use_pci_map'
drivers/media/media.o(.text+0x78a2): undefined reference to `virt_to_bus_not_defined_use_pci_map'
drivers/media/media.o(.text+0x78cc): undefined reference to `virt_to_bus_not_defined_use_pci_map'
drivers/media/media.o(.text+0x7952): undefined reference to `virt_to_bus_not_defined_use_pci_map'
drivers/media/media.o(.text+0x797c): more undefined references to `virt_to_bus_not_defined_use_pci_map' follow

Do you have a patch for this problem?

Regards,
Udo.
