Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267474AbRGTXqC>; Fri, 20 Jul 2001 19:46:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267475AbRGTXpw>; Fri, 20 Jul 2001 19:45:52 -0400
Received: from fmfdns02.fm.intel.com ([132.233.247.11]:25042 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S267474AbRGTXpl>; Fri, 20 Jul 2001 19:45:41 -0400
Message-ID: <9319DDF797C4D211AC4700A0C96B7C9404AC2124@orsmsx42.jf.intel.com>
From: "Raj, Ashok" <ashok.raj@intel.com>
To: "Linux-Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: pci resource mapping problem for PCI-X mode
Date: Fri, 20 Jul 2001 16:44:43 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hello

iam using the PCI macros for address, length calculations. my device has 2
bars.

kvirt = ioremap(pci_resource_start(dev, 0), pci_resource_len(dev, 0));
kvirt1 = ioremap(pci_resource_start(dev, 1), pci_resource_len(dev,1));

issue is in PCI-X mode of operation, the addr is a 64bit addr. these macros
as 
implemented seem to be restricted to 32bit addr. because in pcix mode i
would need to do

kvirt = ioremap(pci_resource_start(dev, 0), pci_resource_len(dev, 0));
kvirt1 = ioremap(pci_resource_start(dev, 2), pci_resource_len(dev,2));

it works for now, since the addr msb's are 0. but if this physical addr is a
true 64bit addr
the above wont work..

in windows NT when the PNP irps come in they provide a 64bit addr, and it
takes care
to provide a 64bit value. correctly (irrespective of the fact that the high
addr is 0)

will this get fixed in a future release?

ashokr


