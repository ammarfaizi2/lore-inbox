Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312488AbSC3OK6>; Sat, 30 Mar 2002 09:10:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312494AbSC3OKr>; Sat, 30 Mar 2002 09:10:47 -0500
Received: from rwcrmhc54.attbi.com ([216.148.227.87]:33951 "EHLO
	rwcrmhc54.attbi.com") by vger.kernel.org with ESMTP
	id <S312488AbSC3OKc>; Sat, 30 Mar 2002 09:10:32 -0500
From: "Ashok Raj" <ashokr2@attbi.com>
To: <linux-kernel@vger.kernel.org>
Subject: linux PCI hotplug
Date: Sat, 30 Mar 2002 06:09:56 -0800
Message-ID: <PPENJLMFIMGBGDDHEPBBAEGGCMAA.ashokr2@attbi.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <20020325.234400.03241011.davem@redhat.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I have a question on pci hotplug capability.

when a new device is inserted, the hotplug driver enumerates pci, and if the
driver is already loaded....

for each new device
	pci_insert->pci_announce->pci_probe

if i need to remove a device, the pci_remove would be called, but it does
not call to check if the device is ready for removal. If there are other
apps working on this device, how would the hotplug removal be authenticated
before removal?

pci_remove() has no return value, means it cannot fail....

ashokr

