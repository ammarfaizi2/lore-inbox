Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264539AbTFQCjX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 22:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264540AbTFQCjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 22:39:23 -0400
Received: from adsl-065-081-070-095.sip.gnv.bellsouth.net ([65.81.70.95]:45517
	"EHLO medicaldictation.com") by vger.kernel.org with ESMTP
	id S264539AbTFQCjW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 22:39:22 -0400
Date: Mon, 16 Jun 2003 22:53:19 -0400
From: Chuck Berg <chuck@encinc.com>
To: linux-kernel@vger.kernel.org, bugs@linux-ide.org
Subject: panic in ide_dma_intr on KT400
Message-ID: <20030616225319.A18522@timetrax.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a machine with a Soyo Dragon motherboard (Via KT400 chipset).

With kernels 2.5.69, 2.5.70, and 2.5.71, it panics in ide_dma_intr() while
detecting the IDE drives. If I boot with pci=noacpi or acpi=off, two of my
drives come up without DMA, rendering the system unusably slow.

With kernels 2.4.20 and 2.4.21, it panics in ide_dma_intr() during heavy
activity on the IDE drives at the same time as heavy activity on the PCI bus.
(therefore, transfering files over NFS crashes the system almost immediately).

2.4 stuff here:
http://marc.theaimsgroup.com/?l=linux-kernel&m=105167850927613&w=2

2.5 stuff: (2.5.71 doesn't behave any differently)

Bootup messages from 2.5.69 with pci=noacpi:
http://encinc.com/~chuck/kt400/2.5.69-pci=noacpi.txt

Bootup messages from 2.5.69 with acpi=off:
http://encinc.com/~chuck/kt400/2.5.69-acpi=off.txt

lspci -vvv, /proc/{cpuinfo,interrupts,iomem,ioports}:
http://encinc.com/~chuck/kt400/2.5.69-pci=noacpi-info.txt

.config:
http://encinc.com/~chuck/kt402/config-2.5.69.txt

