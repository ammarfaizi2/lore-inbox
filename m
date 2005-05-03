Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261589AbVECOWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261589AbVECOWS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 10:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261572AbVECOVH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 10:21:07 -0400
Received: from firewall.miltope.com ([208.12.184.221]:49706 "EHLO
	smtp.miltope.com") by vger.kernel.org with ESMTP id S261610AbVECOSY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 10:18:24 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: clock drift with two Promise Ultra133 TX2 (PDC 20269) cards
Date: Tue, 3 May 2005 09:18:58 -0500
Message-ID: <66F9227F7417874C8DB3CEB057727417045146@MILEX0.Miltope.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: clock drift with two Promise Ultra133 TX2 (PDC 20269) cards
Thread-Index: AcVPTT5SbPXilsQYQMqO31c0dBm7kQAnKCyQ
From: "Drew Winstel" <DWinstel@Miltope.com>
To: "Oskar Liljeblad" <oskar@osk.mine.nu>, <linux-ide@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


>I'm running 2.6.11.8 on an server with two Promise Ultra133 TX2 (PDC20269)
>PCI cards, same hardware revision (judging from stickers on the cards).
>I'm using the CONFIG_BLK_DEV_PDC202XX_NEW driver.
>Each card has two connected hard drives. Whenever I read from a disk
>on one of the cards (e.g. using 'dd if=/dev/hdX of=/dev/null bs=1M'), and
>at the same time read from a disk on the other card, there is heavy
>software clock drift. It drifts about 2-5 seconds per minute.

>This does not happen if I read from two drives connected on the same
>card, or if I read from a drive connected to the motherboard IDE
>(VIA vt8233a) and a drive on either of the Promise cards.

>Oskar Liljeblad (oskar@osk.mine.nu)

Just to verify your setup:

You have a total of four hard drives connected to your PDC20269, hde, hdg, 
hdi, and hdk, correct?

Are all four drives running in DMA mode?

Please post the output of lspci -vv and hdparm run on each of the four hard 
drives.

Also, you may want to try downloading and using Albert Lee's pata_pdc2027x 
driver (part of libata-dev-2.6 tree).  See info at my thread from earlier:
http://marc.theaimsgroup.com/?l=linux-ide&m=110902518625384&w=2

Download the latest libata-dev patch set at 
http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/

Hope this gets you started.

Drew
