Return-Path: <linux-kernel-owner+w=401wt.eu-S932073AbXAFTOI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbXAFTOI (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 14:14:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932092AbXAFTOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 14:14:08 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:60696 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932073AbXAFTOH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 14:14:07 -0500
Date: Sat, 6 Jan 2007 19:22:42 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Giuseppe Bilotta <bilotta78@hotpop.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: JMicron JMB363 SATA hard disk appears twice (sda + hdg)
Message-ID: <20070106192242.7cd86ce1@localhost.localdomain>
In-Reply-To: <31vxryq446ny.b23nrmopmm4.dlg@40tude.net>
References: <31vxryq446ny.b23nrmopmm4.dlg@40tude.net>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.10.4; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The BIOS is set to use the SATA controllers in AHCI mode, not IDE.
> However, the hard disk appears twice, first as hdg, then as sda.
> Passing ide2=noprobe ide3=noprobe as boot parameters to the kernel
> doesn't seem to have any effect:

You have both the drivers for the Jmicron via drivers/ide and via
drivers/ata (libata) loaded. In that specific combination the two drivers
don't use the same resources so don't spot the other one is busy.

