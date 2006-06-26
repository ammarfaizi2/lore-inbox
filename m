Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030267AbWFZOln@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030267AbWFZOln (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 10:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030273AbWFZOlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 10:41:42 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:12232 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030267AbWFZOlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 10:41:42 -0400
Subject: Re: finding pci_dev from scsi_device
From: Arjan van de Ven <arjan@infradead.org>
To: Herbert Rosmanith <kernel@wildsau.enemy.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200606261424.k5QEOolI013449@wildsau.enemy.org>
References: <200606261424.k5QEOolI013449@wildsau.enemy.org>
Content-Type: text/plain
Date: Mon, 26 Jun 2006 16:41:40 +0200
Message-Id: <1151332900.3185.49.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-26 at 16:24 +0200, Herbert Rosmanith wrote:
> > 
> > > > can you share with us what you want to do with this?
> > > 
> > > I need the pci_dev to reconfigure ahci-controllers so that they look like
> > > having been initialised by BIOS at reboot time.
> > 
> > isn't it better to do this in the ahci driver itself instead?
> 
> guess what I'm doing.
> 
> > it for sure will be orders of magnitude easier....
> 
> yes?

static int ahci_host_init(struct ata_probe_ent *probe_ent)
{
        struct ahci_host_priv *hpriv = probe_ent->private_data;
        struct pci_dev *pdev = to_pci_dev(probe_ent->dev);

as you can see, you can easily go from an ata_probe_ent to a pci
device... 

also.. you could just put your code into the remove hook... :)

