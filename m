Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263785AbTEOEQJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 00:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263796AbTEOEQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 00:16:09 -0400
Received: from adsl-065-081-070-095.sip.gnv.bellsouth.net ([65.81.70.95]:44996
	"HELO medicaldictation.com") by vger.kernel.org with SMTP
	id S263785AbTEOEQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 00:16:08 -0400
Date: Thu, 15 May 2003 00:29:27 -0400
From: Chuck Berg <chuck@encinc.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.69 panic in ide_dma_intr on Via KT400
Message-ID: <20030515002927.A31045@timetrax.localdomain>
References: <20030514005607.A17701@timetrax.localdomain> <1052911495.2103.11.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1052911495.2103.11.camel@dhcp22.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Wed, May 14, 2003 at 12:24:57PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 14, 2003 at 12:24:57PM +0100, Alan Cox wrote:
> On Mer, 2003-05-14 at 05:56, Chuck Berg wrote:
> > I have a machine with a Soyo Dragon motherboard (Via KT400 chipset) that
> > when booting 2.5.69 panics while detecting the ide drives. First I get
> > "hde: lost interrupt" and after a few more errors, a panic.
> 
> Disable ACPI

Booting with pci=noacpi or acpi=off results in hda and hdc coming
up without DMA, which leaves the disk unusably slow. hdparm -d1 says
"HDIO_SET_DMA failed: Operation not permitted" (I tried with -X34 and
-X66 also).

Bootup messages from 2.5.69 with pci=noacpi:
http://encinc.com/~chuck/kt400/2.5.69-pci=noacpi.txt

Bootup messages from 2.5.69 with acpi=off:
http://encinc.com/~chuck/kt400/2.5.69-acpi=off.txt

lspci -vvv, /proc/{cpuinfo,interrupts,iomem,ioports}:
http://encinc.com/~chuck/kt400/2.5.69-pci=noacpi-info.txt

.config:
http://encinc.com/~chuck/kt402/config-2.5.69.txt

