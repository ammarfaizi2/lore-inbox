Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267360AbUBSQiO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 11:38:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267363AbUBSQiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 11:38:13 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:16115 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S267360AbUBSQiI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 11:38:08 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Kianusch Sayah Karadji <kianusch@sk-tech.net>, greg@kroah.com
Subject: Re: PCI-Scan Hangup ...
Date: Thu, 19 Feb 2004 17:44:19 +0100
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0402191426360.27436@kryx.sk-tech.net>
In-Reply-To: <Pine.LNX.4.58.0402191426360.27436@kryx.sk-tech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402191744.19633.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 19 of February 2004 14:35, Kianusch Sayah Karadji wrote:
> Hi!

Hi,

> There I have a Soekris bord with some weird PCI Handup while booting
> Linux during PCI-Scan .
>
> # lspci
>
> 00:00.0 Host bridge: Cyrix Corporation PCI Master
> 00:12.0 ISA bridge: National Semiconductor Corporation: Unknown device 0510
> 00:12.1 Bridge: National Semiconductor Corporation: Unknown device 0511
> 00:12.2 IDE interface: National Semiconductor Corporation SCx200 IDE (rev
> 01) 00:12.5 Bridge: National Semiconductor Corporation: Unknown device 0515
> 00:13.0 USB Controller: Compaq Computer Corporation ZFMicro Chipset USB
> (rev 08)
>
> There was a patch on 2.4.x which worked fine.
>
> Now I tried to patch Kernel 2.6.x - well I'm no programmer
> - I had no idea where to put it ... so I started putting some debug
> messages into some files ... and suddenly including a printk(".") into
> drivers/pci/probe.c fixed the whole PCI-Hangup ??? - That was not what the
> 2.4.x Patch did.
>
> Hmmm ...
>
> I've no idea why that printk fixes the Problem nor if it's a good idea to
> have that printk there ...

printk() adds some delay -> this delay fixes your problem, but I dunno why.

