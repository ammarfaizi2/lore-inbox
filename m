Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267659AbUINEnQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267659AbUINEnQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 00:43:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268937AbUINEnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 00:43:16 -0400
Received: from border.scrd.bc.ca ([24.207.24.31]:46350 "EHLO border.scrd.bc.ca")
	by vger.kernel.org with ESMTP id S267659AbUINEnO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 00:43:14 -0400
Message-ID: <1174450A1968D111AAAF00805FC162AE012070F7@deep_thought.secure.scrd.bc.ca>
From: Kris Boutilier <Kris.Boutilier@scrd.bc.ca>
To: Kris Boutilier <Kris.Boutilier@scrd.bc.ca>, linux-kernel@vger.kernel.org
Subject: RE: libata/sata_sil doesn't detect drives on second SiL3112A base
	d ad apter w/kernel 2.4.27?
Date: Mon, 13 Sep 2004 21:42:32 -0700
Importance: low
X-Priority: 5
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The issue was not libata/sata_sil but rather pci device detection on this
box - note the second card was absent from the original lspci output. After
moving the cards to the secondary (64/33) bus everything popped up fine.
Haven't tried the tertiary bus slots.

Interestingly the machine would not boot up at all with the cards in certain
combinations of slots on the primary bus - probably irratated something in
the proprietary Compaq BIOS. 

> -----Original Message-----
> From: Kris Boutilier [mailto:Kris.Boutilier@scrd.bc.ca]
> Sent: September 10, 2004 2:24 PM
> To: linux-kernel@vger.kernel.org
> Subject: libata/sata_sil doesn't detect drives on second 
> SiL3112A based
> ad apter w/kernel 2.4.27?
> 
> 
> I am running a custom compile of kernel 2.4.27, patched with 
> uml skas3 on a
> very basic Debian Woody install. The host is a Compaq DL760 
> with 8 CPUs/8gb
> RAM (Corollary Profusion Chipset). The host includes a a 
> variety of SCSI
> storage controllers, one IDE controller and now two SiL-3112a 
> based SATA
> adapters (lspci -v attached). Both sata adapters have two 
> ports and each
> port has a Seagate ST3200822AS drive attached. One drive 
> (sda) has been
> partitioned, tested and works fine - the others have been left blank.
> 
> The problem is that sata_sil appears to detect both 
> controllers, but doesn't
> initialize drives 3 and 4 on the second card. 
{clip}
