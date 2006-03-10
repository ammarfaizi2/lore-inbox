Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932073AbWCJTeQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbWCJTeQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 14:34:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932104AbWCJTeQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 14:34:16 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:27154 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932085AbWCJTeP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 14:34:15 -0500
Date: Fri, 10 Mar 2006 20:34:14 +0100
From: Adrian Bunk <bunk@stusta.de>
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: drivers/scsi/ahci.c:ahci_interrupt(): NULL pointer dereference
Message-ID: <20060310193414.GT21864@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Coverity checker spotted this bug (note the ap dereference)

<--  snip  -->

...
                if (ap) {
...
                } else {
                        VPRINTK("port %u (no irq)\n", i);
                        if (ata_ratelimit()) {
                                struct pci_dev *pdev =
                                        to_pci_dev(ap->host_set->dev);
...

<--  snip  -->


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

