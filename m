Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285553AbRLNW1J>; Fri, 14 Dec 2001 17:27:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285555AbRLNW07>; Fri, 14 Dec 2001 17:26:59 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22276 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S285553AbRLNW0p>;
	Fri, 14 Dec 2001 17:26:45 -0500
Message-ID: <3C1A7CA1.D6C119DC@mandrakesoft.com>
Date: Fri, 14 Dec 2001 17:26:41 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kaos@ocs.com.au
CC: Linux-Kernel list <linux-kernel@vger.kernel.org>
Subject: modules.pcimap and 8139's
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Various tools need to pick "8139cp.c" instead of "8139too.c" based on
PCI revision, which is not in modules.pcimap nor struct pci-device-id. 
grep for 'pci_rev' in both those files to see the PCI revision checks
hand-coded currently in the drivers.

What is the preferred -2.4- solution?

a) append pci rev and mask to the end of each modules.pcimap line, and
update struct pci_device_id?
b) create new file modules.pci_rev?
c) other?

Distros at least need to solve this for 2.4...

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno
