Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263310AbTFTQcs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 12:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263315AbTFTQcr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 12:32:47 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:12702 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263310AbTFTQcn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 12:32:43 -0400
Date: Fri, 20 Jun 2003 18:46:17 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Matthew Wilcox <willy@debian.org>
cc: Greg KH <greg@kroah.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI direct access resources
In-Reply-To: <20030620162929.GT24357@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.SOL.4.30.0306201842290.15091-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 20 Jun 2003, Matthew Wilcox wrote:

> +	if (!pci_probe & PCI_PROBE_CONF1)
> +		goto type2;

(!pci_probe & PCI_PROBE_CONF1) will be always FALSE if pci_probe != 0,
correct check is:

	if ((pci_probe & PCI_PROBE_CONF1) == 0)

> +	if (!pci_probe & PCI_PROBE_CONF2)
> +		goto out;

Same comment here.

--
Bartlomiej

