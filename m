Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030285AbWFZOsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030285AbWFZOsN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 10:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030292AbWFZOsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 10:48:13 -0400
Received: from wildsau.enemy.org ([193.170.194.34]:17566 "EHLO
	wildsau.enemy.org") by vger.kernel.org with ESMTP id S1030285AbWFZOsN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 10:48:13 -0400
From: Herbert Rosmanith <kernel@wildsau.enemy.org>
Message-Id: <200606261442.k5QEgCA1013471@wildsau.enemy.org>
Subject: Re: finding pci_dev from scsi_device
In-Reply-To: <200606261437.k5QEb8vr013461@wildsau.enemy.org>
To: Herbert Rosmanith <kernel@wildsau.enemy.org>
Date: Mon, 26 Jun 2006 16:42:12 +0200 (MET DST)
CC: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >From the scsi_device, I know I can get a "struct ata_port", from there
> a "struct Scsi_Host", a "struct ata_host_set" and even a generic
> "struct device *".

Arjan> static int ahci_host_init(struct ata_probe_ent *probe_ent)
Arjan> {
Arjan>         struct ahci_host_priv *hpriv = probe_ent->private_data;
Arjan>         struct pci_dev *pdev = to_pci_dev(probe_ent->dev);
Arjan> 
Arjan> as you can see, you can easily go from an ata_probe_ent to a pci
Arjan> device...

ah! that looks promising. looks like "to_pci_dev" is what I've been
searching.

thanks, I'll try immediately :)

kind regards,
h.rosmanith
