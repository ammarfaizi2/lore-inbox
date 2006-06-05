Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750841AbWFEKHH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750841AbWFEKHH (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 06:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750861AbWFEKHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 06:07:07 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:42699 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750841AbWFEKHF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 06:07:05 -0400
Subject: Re: [PATCH 9/9] PCI PM: generic suspend/resume fixes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adam Belay <abelay@novell.com>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
        linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
In-Reply-To: <1149497178.7831.163.camel@localhost.localdomain>
References: <1149497178.7831.163.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 05 Jun 2006 11:21:31 +0100
Message-Id: <1149502891.30554.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-06-05 am 04:46 -0400, ysgrifennodd Adam Belay:
> + * Default suspend method for devices that have no driver provided suspend,
> + * or not even a driver at all.
> + */
> +static void pci_default_suspend(struct pci_dev *pci_dev)
> +{
> +	pci_save_state(pci_dev);
> +	pci_disable_device(pci_dev);
> +}

How much testing has this had ? When people starting doing
disable_device on arbitary hardware various platforms broke horribly
as a result.


