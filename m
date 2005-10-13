Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751575AbVJMPBI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751575AbVJMPBI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 11:01:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751559AbVJMPBH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 11:01:07 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:51652 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750823AbVJMPBG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 11:01:06 -0400
Subject: Re: [PATCH] via82cxxx IDE: Support multiple controllers
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mark Lord <liml@rtr.ca>
Cc: Daniel Drake <dsd@gentoo.org>,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       posting@blx4.net, vsu@altlinux.ru
In-Reply-To: <434E7237.1070508@rtr.ca>
References: <43146CC3.4010005@gentoo.org>
	 <58cb370e05083008121f2eb783@mail.gmail.com>	 <43179CC9.8090608@gentoo.org>
	 <58cb370e050927062049be32f8@mail.gmail.com> <434D2DF1.9070709@gentoo.org>
	 <434D3266.9000203@gentoo.org>
	 <1129139563.7966.4.camel@localhost.localdomain>
	 <1129203917.18635.1.camel@localhost.localdomain>  <434E7237.1070508@rtr.ca>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 13 Oct 2005 16:29:04 +0100
Message-Id: <1129217344.18635.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-10-13 at 10:41 -0400, Mark Lord wrote:
> Alan Cox wrote:
> >
> > If the bus speed of your 486 is 25Mhz the chipset is at 25MHz as is your
> > IDE (ie 486/25, DX2/50, 3/75 - not sure about 4/100 etc). Now does
> > anyone know how you find out if the CPU is 25MHz bus clocked on a 486 8)
> 
> Same method as /proc/cpuinfo, for an approximation?  :)

Unfortunately cpuinfo doesn't know the difference between a 100Mhz
(4x25) and 100Mhz (3x33). Late 486s have cpuid which helps a bit but
many do not have that (it comes in with writeback cache) and they don't
have rdmsr to access the processor boot bus speed bits as the preventium
and later do.

Alan

