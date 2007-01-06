Return-Path: <linux-kernel-owner+w=401wt.eu-S932100AbXAFTZ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbXAFTZ2 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 14:25:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932104AbXAFTZ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 14:25:28 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:41640 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932100AbXAFTZ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 14:25:27 -0500
Date: Sat, 6 Jan 2007 19:35:41 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Luca Tettamanti <kronos.it@gmail.com>
Cc: Giuseppe Bilotta <bilotta78@hotpop.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: JMicron JMB363 SATA hard disk appears twice (sda + hdg)
Message-ID: <20070106193541.1f211289@localhost.localdomain>
In-Reply-To: <20070106182454.GA12426@dreamland.darkstar.lan>
References: <31vxryq446ny.b23nrmopmm4.dlg@40tude.net>
	<20070106182454.GA12426@dreamland.darkstar.lan>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.10.4; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> jmicron: don't touch the controller when it's AHCI mode. As help text
> suggests ("For full support use the libata drivers") the new libata AHCI
> driver will take care of it.

NAK

The kernel drivers work on the basis that if you are using drivers/ide
then the IDE driver will grab all the ports, if you are using libata then
the PCI boot quirks will switch to split AHCI and PATA mode and the
libata drivers will take both. 

If you build both IDE and libata support for the same hardware into your
kernel it should generally end up with only one driver claiming the
hardware but the AHCI case doesn't handle this in 2.6.18.

Alan
