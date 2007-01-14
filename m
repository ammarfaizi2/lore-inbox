Return-Path: <linux-kernel-owner+w=401wt.eu-S1751402AbXANRtx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402AbXANRtx (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 12:49:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751442AbXANRtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 12:49:53 -0500
Received: from ns2.uludag.org.tr ([193.140.100.220]:54888 "EHLO uludag.org.tr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751402AbXANRtx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 12:49:53 -0500
From: Faik Uygur <faik@pardus.org.tr>
Organization: =?utf-8?q?T=C3=9CB=C4=B0TAK_/?= UEKAE
To: Jeff Garzik <jeff@garzik.org>
Subject: Re: ahci_softreset prevents acpi_power_off
Date: Sun, 14 Jan 2007 19:50:14 +0200
User-Agent: KMail/1.9.5
Cc: Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Tejun Heo <htejun@gmail.com>
References: <fa.enjQgtLFPdSkeJjKv6eOjULTovQ@ifi.uio.no> <45A9860D.5080506@shaw.ca> <45A9A0F2.4090608@garzik.org>
In-Reply-To: <45A9A0F2.4090608@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200701141950.14782.faik@pardus.org.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

14 Oca 2007 Paz 05:18 tarihinde şunları yazmıştınız:
>> [...]
> > Since you're getting to this point I think this has to be some kind of
> > BIOS interaction causing this. The only thing that happens after the
> > "Entering sleep state" is that the kernel writes to some ACPI registers
> > to tell the hardware to power down. I think some laptop BIOSes do things
> > on ACPI power down like try to park the drive heads, etc. and maybe this
> > change that you found from git bisecting is somehow interfering with it
> > doing this?
> >
> > Might want to check for a BIOS update first of all..
>
> It would be interesting to try -mm, which includes ACPI support for ATA...

With the same .config used and with CONFIG_SATA_ACPI defined as default
in 2.6.20-rc4-mm1 the machine did not poweroff again.

> 	Jeff

Regards,
- Faik
