Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135611AbRDXNiu>; Tue, 24 Apr 2001 09:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135610AbRDXNiq>; Tue, 24 Apr 2001 09:38:46 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:62731 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135613AbRDXNgv>; Tue, 24 Apr 2001 09:36:51 -0400
Subject: Re: serial driver not properly detecting modem
To: srwalter@yahoo.com (Steven Walter)
Date: Tue, 24 Apr 2001 14:38:08 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010423223847.A3945@hapablap.dyn.dhs.org> from "Steven Walter" at Apr 23, 2001 10:38:48 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14s318-00023o-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've fixed this here merely by adding an entry to the PCI table of
> serial.c for PCI_CLASS_COMMUNICATION_OTHER.  Is this the best way to fix
> this?  Is there some reason that this shouldn't be done in general?  If
> not, I'd like to see it fix in the kernel proper.

Most class other devices wont be 16x50 compatible.

> It should be noted that the modem is listed in serial.c's pci_boards,
> perhaps it would be best for the serial driver to list PCI_ID_ANY for a
> class, and only use pci_boards to further identify serial ports?  Or
> would this be too inefficient to correct for a few misguided hardware
> makers?

Probably serial.c should look for class serial || (class_other && in table)

