Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317473AbSHCTZP>; Sat, 3 Aug 2002 15:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317488AbSHCTZO>; Sat, 3 Aug 2002 15:25:14 -0400
Received: from pl204.dhcp.adsl.tpnet.pl ([217.98.31.204]:1697 "EHLO
	blurp.slackware.pl") by vger.kernel.org with ESMTP
	id <S317473AbSHCTY4>; Sat, 3 Aug 2002 15:24:56 -0400
Date: Sat, 3 Aug 2002 21:26:49 +0200 (CEST)
From: Pawel Kot <pkot@linuxnews.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Message-ID: <Pine.LNX.4.33.0208032115080.32383-100000@blurp.slackware.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The problem I reported once, still exist in 2.4.19. See my previous emails
for the reference:
http://marc.theaimsgroup.com/?l=linux-kernel&m=102495067602135&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=102277249800423&w=2
It is fixed in -ac series though.

As Bartek Zolnierkiewicz pointed me, the problem was introduced by two
factors:
 - checking the return value of pci_enable_device(dev)
 - some settings problem with PCI resources -- BIOS/controller does
prepare them for XP
(these are more-less Bartek's words).

What helped me was using fixup_device_piix() from -ac in
ide_scan_pcidev(). My controler's ID is DEVID_ICH3M.
It is used in a different, more generic way in -ac, so I don't post the
patch.

Alan, Marcelo: is there any chance that this change will be ported from
-ac in 2.4.20?

many thanks to Bartek,
pkot
-- 
mailto:pkot@linuxnews.pl :: mailto:pkot@slackware.pl
http://kt.linuxnews.pl/ :: Kernel Traffic po polsku











