Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263322AbVGOQeY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263322AbVGOQeY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 12:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263324AbVGOQeY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 12:34:24 -0400
Received: from [217.19.149.7] ([217.19.149.7]:64518 "HELO mail.netline.it")
	by vger.kernel.org with SMTP id S263322AbVGOQeW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 12:34:22 -0400
Date: Fri, 15 Jul 2005 18:34:22 +0200
From: Domenico Andreoli <cavok@libero.it>
To: Bas Vermeulen <bvermeul@blackstar.nl>
Cc: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ATAPI+SATA support in 2.6.13-rc3
Message-ID: <20050715163422.GA1867@raptus.dandreoli.com>
Mail-Followup-To: Bas Vermeulen <bvermeul@blackstar.nl>,
	Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>,
	Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <42D78269.5020809@gmx.net> <1121421557.5110.11.camel@laptop.blackstar.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1121421557.5110.11.camel@laptop.blackstar.nl>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2005 at 11:59:17AM +0200, Bas Vermeulen wrote:
> On Fri, 2005-07-15 at 11:31 +0200, Carl-Daniel Hailfinger wrote:
> > Hi Jeff,

hi all,

> > I have a Intel ICH6M chipset and am using ata_piix as my
> > default disk driver. With the SUSE patched 2.6.11.4 kernel
> > (it has some libata patches) my DVD-RAM drive works, with
> > 2.6.13-rc3 it doesn't work. My .config is nearly identical
> > for both kernels (except options introduced after 2.6.11).

i also have a ICH6M. the SATA HD is correctly seen and used but the
cdrom unit isn't. i'm using a vanilla 2.6.12.2.

> You'll need to enable ATAPI support for ata_piix in
> include/linux/libata.h
> 
> Change:
> #undef ATA_ENABLE_ATAPI
> 
> into
> #define ATA_ENABLE_ATAPI

it works! i'm now able to read and write cdroms :)

> Suse has probably done that for you, it's disabled by default.

why it is disabled by default? what do these macros mean? what is
really happening? thank you.

cheers
domenico

-----[ Domenico Andreoli, aka cavok
 --[ http://people.debian.org/~cavok/gpgkey.asc
   ---[ 3A0F 2F80 F79C 678A 8936  4FEE 0677 9033 A20E BC50
