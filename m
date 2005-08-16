Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932680AbVHPM2o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932680AbVHPM2o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 08:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932683AbVHPM2n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 08:28:43 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:28887 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S932680AbVHPM2l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 08:28:41 -0400
Subject: Re: [PATCH] IDE: don't offer IDE_GENERIC on ia64
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, B.Zolnierkiewicz@elka.pw.edu.pl,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       linux-ia64@vger.kernel.org
In-Reply-To: <58cb370e050816023845b57a74@mail.gmail.com>
References: <200508111424.43150.bjorn.helgaas@hp.com>
	 <1123836012.22460.16.camel@localhost.localdomain>
	 <200508151507.22776.bjorn.helgaas@hp.com>
	 <58cb370e050816023845b57a74@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 16 Aug 2005 13:55:58 +0100
Message-Id: <1124196958.17555.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-08-16 at 11:38 +0200, Bartlomiej Zolnierkiewicz wrote:
> * removing IDE_ARCH_OBSOLETE_INIT define has some implications,
>   * non-functional ide-cs driver (but there is no PCMCIA on IA64?)

IA64 systems can support PCI->Cardbus/PCMCIA cards so they do actually
need this support. They could also do with cardbus IDE support but that
means a whole pile of patches still although the refcounting stuff means
its a lot closer to doable now

>   * ordering change for ide-pnp interfaces in case of no IDE devices
>     on default IDE PCI ports, (but there aren't any ide-pnp devices on IA64?)

No ISAPnP

