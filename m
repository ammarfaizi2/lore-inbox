Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261156AbVFWNGf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbVFWNGf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 09:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261608AbVFWNGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 09:06:34 -0400
Received: from loncoche.terra.com.br ([200.154.55.229]:62182 "EHLO
	loncoche.terra.com.br") by vger.kernel.org with ESMTP
	id S261900AbVFWNFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 09:05:43 -0400
X-Terra-Karma: -2%
X-Terra-Hash: ad739d75e2bbfd0613b92ed992baa12a
Message-ID: <42BAB228.2000404@terra.com.br>
Date: Thu, 23 Jun 2005 09:59:20 -0300
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050423
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, LKML <linux-kernel@vger.kernel.org>,
       jgarzik@pobox.com
Subject: Re: 2.6.12 breaks 8139cp
References: <42B9D21F.7040908@drzeus.cx> <200506221534.03716.bjorn.helgaas@hp.com> <42BA69AC.5090202@drzeus.cx>
In-Reply-To: <42BA69AC.5090202@drzeus.cx>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Pierre,

Pierre Ossman wrote:

>PCI: Using ACPI for IRQ routing
>** PCI interrupts are no longer routed automatically.  If this
>** causes a device to stop working, it is probably because the
>** driver failed to call pci_enable_device().  As a temporary
>** workaround, the "pci=routeirq" argument restores the old
>** behavior.  If this argument makes the device work again,
>** please email the output of "lspci" to bjorn.helgaas@hp.com
>** so I can fix the driver.
>
    As this shows on the 2.6.11 dmesg, and doesn't show on 2.6.12, could
be the cause of the problem.

    Although 8139cp calls pci_enable_device correctly, it may be worth
to try the pci=routeirq thing and see what happens.

    Cheers,

Felipe Damasio
