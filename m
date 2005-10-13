Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750972AbVJMLQc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750972AbVJMLQc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 07:16:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932494AbVJMLQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 07:16:32 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:60800 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750925AbVJMLQb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 07:16:31 -0400
Subject: Re: [PATCH] via82cxxx IDE: Support multiple controllers
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Daniel Drake <dsd@gentoo.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       posting@blx4.net, vsu@altlinux.ru
In-Reply-To: <1129139563.7966.4.camel@localhost.localdomain>
References: <43146CC3.4010005@gentoo.org>
	 <58cb370e05083008121f2eb783@mail.gmail.com>	 <43179CC9.8090608@gentoo.org>
	 <58cb370e050927062049be32f8@mail.gmail.com> <434D2DF1.9070709@gentoo.org>
	 <434D3266.9000203@gentoo.org>
	 <1129139563.7966.4.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 13 Oct 2005 12:45:17 +0100
Message-Id: <1129203917.18635.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-10-12 at 18:52 +0100, Alan Cox wrote:
> On Mer, 2005-10-12 at 16:57 +0100, Daniel Drake wrote:
> > Uh, looks like the kernel just assumes 33mhz unless overriden by the user. Is 
> > this assumption generally accurate?
> > If it is not, then there's probably no point displaying timing info...
> 
> A small number of 486 systems use 25Mhz, some boards allow overclock at
> 37.5Mhz on the PCI. I've been looking at this the past couple of days
> for the libata via driver which I've been porting over and unfortunately
> having been through the Northbridge manuals I can find no way to ask the
> chipset what the PCI clock is set too.

Ok I found what seems to be a pattern for the early chipsets with 25MHz
support.

If the bus speed of your 486 is 25Mhz the chipset is at 25MHz as is your
IDE (ie 486/25, DX2/50, 3/75 - not sure about 4/100 etc). Now does
anyone know how you find out if the CPU is 25MHz bus clocked on a 486 8)

