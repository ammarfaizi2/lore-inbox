Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130464AbQLSX0j>; Tue, 19 Dec 2000 18:26:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130656AbQLSX03>; Tue, 19 Dec 2000 18:26:29 -0500
Received: from virtualro.ic.ro ([194.102.78.138]:21262 "EHLO virtualro.ic.ro")
	by vger.kernel.org with ESMTP id <S130464AbQLSX0U>;
	Tue, 19 Dec 2000 18:26:20 -0500
Date: Wed, 20 Dec 2000 00:56:01 +0200 (EET)
From: Jani Monoses <jani@virtualro.ic.ro>
To: linux-kernel@vger.kernel.org
Subject: pci.c question [recent changes undone]
Message-ID: <Pine.LNX.4.10.10012200048180.18898-100000@virtualro.ic.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hi 
	I'm curios what was that change & undo about in test12
and test13pre3ac3 regarding the disabling of PCI IO and MM access while
writing to the config registers in pci_read_bases().

These lines were cut from test 12 and now they are back.      

      /* Disable IO and memory while we fiddle */
       pci_read_config_word(dev, PCI_COMMAND, &cmd);
       tmp = cmd & ~(PCI_COMMAND_IO | PCI_COMMAND_MEMORY);
       pci_write_config_word(dev, PCI_COMMAND, tmp);
	[.....]
       pci_write_config_word(dev, PCI_COMMAND, cmd);

Why were they cut in the first place?
Can anyone enlighten me?

Thanks,
Jani.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
