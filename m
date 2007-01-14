Return-Path: <linux-kernel-owner+w=401wt.eu-S1751447AbXANSHH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447AbXANSHH (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 13:07:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751449AbXANSHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 13:07:07 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:37285 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751447AbXANSHG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 13:07:06 -0500
Subject: Re: ahci_softreset prevents acpi_power_off
From: Arjan van de Ven <arjan@infradead.org>
To: Faik Uygur <faik@pardus.org.tr>
Cc: Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>
In-Reply-To: <200701141959.40673.faik@pardus.org.tr>
References: <fa.enjQgtLFPdSkeJjKv6eOjULTovQ@ifi.uio.no>
	 <fa.kpxGqupQMKJxBBFrktFUzuoKc7c@ifi.uio.no> <45A9860D.5080506@shaw.ca>
	 <200701141959.40673.faik@pardus.org.tr>
Content-Type: text/plain; charset=UTF-8
Organization: Intel International BV
Date: Sun, 14 Jan 2007 10:06:18 -0800
Message-Id: <1168797978.3123.997.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2007-01-14 at 19:59 +0200, Faik Uygur wrote:
> 14 Oca 2007 Paz 03:23 tarihinde, Robert Hancock şunları yazmıştı: 
> >> [...]
> >> > Since you're getting to this point I think this has to be some kind of 
> > BIOS interaction causing this. The only thing that happens after the
> > "Entering sleep state" is that the kernel writes to some ACPI registers
> > to tell the hardware to power down. I think some laptop BIOSes do things
> > on ACPI power down like try to park the drive heads, etc. and maybe this
> > change that you found from git bisecting is somehow interfering with it
> > doing this?
> >
> > Might want to check for a BIOS update first of all..
> 
> Checked from the Sony support page for the laptop model and seems the BIOS 
> version is the latest.
> 
> So it is nothing interesting but a broken BIOS.

Hi,

I'd be interested in finding out how to best test this; if the bios is
really broken I'd love to add a test to the Linux-ready Firmware
Developer Kit for this, so that BIOS developers can make sure future
bioses do not suffer from this bug...

Greetings,
   Arjan van de Ven

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

