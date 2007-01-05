Return-Path: <linux-kernel-owner+w=401wt.eu-S965137AbXAEJ25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965137AbXAEJ25 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 04:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965138AbXAEJ25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 04:28:57 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:50403 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S965137AbXAEJ24 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 04:28:56 -0500
Date: Fri, 5 Jan 2007 09:39:01 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Marcin Juszkiewicz <openembedded@hrw.one.pl>
Cc: linux-kernel@vger.kernel.org, Richard Purdie <rpurdie@rpsys.net>
Subject: Re: [PATCH] backlight control for Frontpath ProGear HX1050+
Message-ID: <20070105093901.7f2ef1f8@localhost.localdomain>
In-Reply-To: <200701050903.31859.openembedded@hrw.one.pl>
References: <200701050903.31859.openembedded@hrw.one.pl>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.10.4; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> +struct pci_dev *pmu_dev = NULL;
> +struct pci_dev *sb_dev  = NULL;

static ?

> +	pmu_dev = pci_find_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M7101, 0);

pci_find_device is going away, please use pci_get_device and the get/put
functions to refcount it. This makes the system hotplug safe.
