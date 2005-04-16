Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262697AbVDPQdq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262697AbVDPQdq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Apr 2005 12:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262698AbVDPQdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Apr 2005 12:33:46 -0400
Received: from paldo.org ([213.202.245.43]:1697 "EHLO buildd1.paldo.org")
	by vger.kernel.org with ESMTP id S262697AbVDPQdo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Apr 2005 12:33:44 -0400
Subject: Broken nForce2 IDE module loading via hotplug
From: Juerg Billeter <juerg@paldo.org>
To: jgarzik@pobox.com, achew@nvidia.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: paldo
Date: Sat, 16 Apr 2005 18:33:35 +0200
Message-Id: <1113669215.8940.31.camel@juerg-p4.bitron.ch>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

(please cc me)

The sata_nv patch[1] (merged in 2.6.11-rc4) to enable future NVIDIA SATA
pci ids catches all NVIDIA pci devices with the ide class. This breaks
automatic module loading for e.g. nForce2 ide controllers and thereby
renders nForce systems loading modules already in initramfs/initrd via
hotplug/coldplug non-bootable.

I don't know what solutions are possible besides reverting. Is it
somehow possible to influence the order of the modules.pcimap file, i.e.
moving the generic matching lines below the more specific ones?

Thanks for any hints,

Juerg

[1]
http://www.mail-archive.com/bk-commits-24@vger.kernel.org/msg00112.html
-- 
Juerg Billeter <juerg@paldo.org>

