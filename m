Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750847AbWAEAg4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750847AbWAEAg4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 19:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750853AbWAEAg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 19:36:56 -0500
Received: from dione.cc ([213.195.140.12]:64616 "EHLO dione.ids.pl")
	by vger.kernel.org with ESMTP id S1750846AbWAEAgz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 19:36:55 -0500
Date: Thu, 5 Jan 2006 01:35:32 +0100
From: Krzysztof Baranowski <kgb@dione.ids.pl>
X-Mailer: The Bat! (v3.64.01 Christmas Edition) Professional
Reply-To: Krzysztof Baranowski <kgb@dione.ids.pl>
Organization: =?utf-8?Q?Klub_Nieszkodliwych_Manjak=C3=B3w?=
X-Priority: 3 (Normal)
Message-ID: <1755038059.20060105013532@dione.ids.pl>
To: mj@ucw.cz
CC: linux-kernel@vger.kernel.org, linux.nics@intel.com
Subject: PCI DEVICE ID PROBLEM and Intel Intergrated eth card - a bios bug (?)
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1250
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Im using a PC BOX with Intel P4 HT processor on Gigabyte
GA-8KNXP Rev 2.x) which features Integrated Intel® PRO/1000
CT Network Card. All worked fine on both Linux & Win.
However I recently upgraded BIOS on this MB to the latest
version FK from (not sure now) FH or FJ version (reference
link below).

http://tw.giga-byte.com/Motherboard/Support/BIOS/BIOS_GA-8KNXP%20(Rev%202.x)_More.htm

After the upgrade my network card disappeared from both Linux and Win.

After short investigation I noticed one strange incosistency. Under
the new BIOS the PCI device is reported as PCI VENDOR ID 1459 (
which is gigabyte) DEV_ID 1019. However Windows driver for this
card (the lates from both intel and gigabyte) is looking for
VENDOR_ID 8086 (intel).

I havent booted to Linux yet, just dicovered the thing, but
after looking through the source of Linux E1000 driver in
e1000_main.c in struct pci_device_id is only looking for
Intel vendor device 8086, so the problem is still valid
I guess.

Please Cc when replying as I dont subscribe the list.

Best regards
Kris


