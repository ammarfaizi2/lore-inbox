Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271265AbRHTO63>; Mon, 20 Aug 2001 10:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271267AbRHTO6T>; Mon, 20 Aug 2001 10:58:19 -0400
Received: from freya.yggdrasil.com ([209.249.10.20]:46569 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S271265AbRHTO6M>; Mon, 20 Aug 2001 10:58:12 -0400
Date: Mon, 20 Aug 2001 07:58:26 -0700
From: "Adam J. Richter" <adam@yggdrasil.com>
To: linux-atm-general@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: PATCH: linux-2.4.9/drivers/atm to new module_{init,exit} + some pci_device_id tables
Message-ID: <20010820075826.A368@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	The following patch moves linux-2.4.9/drivers/atm
to the relatively new module_{init,exit} interface, simplifying
the code and removing the reference to the ATM drivers from
linux/drivers/genhd.c (this is partly motivated by my effort to get
rid of genhd.c).  The changes also include some pci_device_id tables,
which enable automatic loading of the modules via pcimodules (or
a similar program).  These changes are also all steps toward porting
the atm drivers to the new PCI interface.  In the case zatm.c, I
have actually ported it to the new PCI interface, although it
shares the stock zatm driver's deficiency of not supporting
module removal.

	Note that this change deletes linux-2.4.9/drivers/atmdev_init.c,
since the conversion to module_{init,exit} completely obseletes that file.

	If these changes look OK, I would like to get them
into the stock kernel.  If there is a maintainer on linux-atm-general
who shepherds these patches to Alan and Linus, and if these changes
are good, please let me know if you are going to "officially" send them
to Alan and Linus or if you want me to do so or if there is some other
procedure that I should follow.

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
