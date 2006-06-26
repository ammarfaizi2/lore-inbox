Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932403AbWFZPAT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932403AbWFZPAT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 11:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932355AbWFZPAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 11:00:19 -0400
Received: from wildsau.enemy.org ([193.170.194.34]:19870 "EHLO
	wildsau.enemy.org") by vger.kernel.org with ESMTP id S932403AbWFZPAR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 11:00:17 -0400
From: Herbert Rosmanith <kernel@wildsau.enemy.org>
Message-Id: <200606261454.k5QEsGXW013489@wildsau.enemy.org>
Subject: Re: finding pci_dev from scsi_device
In-Reply-To: <1151332900.3185.49.camel@laptopd505.fenrus.org>
To: Arjan van de Ven <arjan@infradead.org>
Date: Mon, 26 Jun 2006 16:54:16 +0200 (MET DST)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>         struct pci_dev *pdev = to_pci_dev(probe_ent->dev);
> 
> as you can see, you can easily go from an ata_probe_ent to a pci
> device... 

just for the sake of completeness:

static int ahci_ioctl(struct scsi_device *scsidev, int cmd, void __user *arg) {
struct pci_dev *pdev;

	pdev=to_pci_dev(((struct ata_port *)&scsidev->host->hostdata[0])->host_set->dev);

kind regards,
h.rosmanith
