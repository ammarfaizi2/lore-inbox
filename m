Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261725AbVECPM4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261725AbVECPM4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 11:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261712AbVECPM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 11:12:56 -0400
Received: from firewall.miltope.com ([208.12.184.221]:5475 "EHLO
	smtp.miltope.com") by vger.kernel.org with ESMTP id S261702AbVECPMr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 11:12:47 -0400
Content-class: urn:content-classes:message
Subject: RE: clock drift with two Promise Ultra133 TX2 (PDC 20269) cards
Date: Tue, 3 May 2005 10:13:17 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <66F9227F7417874C8DB3CEB057727417045148@MILEX0.Miltope.local>
X-MS-Has-Attach: 
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-MS-TNEF-Correlator: 
Thread-Topic: clock drift with two Promise Ultra133 TX2 (PDC 20269) cards
Thread-Index: AcVP7jOBG0SQDj6uQCemhONaegOUKgAANaZQ
From: "Drew Winstel" <DWinstel@Miltope.com>
To: "Oskar Liljeblad" <oskar@osk.mine.nu>
Cc: <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> geometry     = 30515/255/63, sectors = 490234752, start = 0

>/dev/hde:

> Model=Maxtor 6B250R0, FwRev=BAH41BM0, SerialNo=<...>
> Config={ Fixed }
> RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
> BuffType=DualPortCache, BuffSize=16384kB, MaxMultSect=16, MultSect=off
> CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=268435455
> IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
> PIO modes:  pio0 pio1 pio2 pio3 pio4 
> DMA modes:  mdma0 mdma1 mdma2 
> UDMA modes: udma0 udma1 udma2 udma3 udma4 udma5 *udma6 
> AdvancedPM=yes: disabled (255) WriteCache=enabled
> Drive conforms to: (null): 

> * signifies the current active mode

Hmm... that puzzles me, although for no other reason than I'm not familiar 
with how Maxtor drives report themselves.  Having the BIOS-reported LBA 
sectors not equal to the OS-reported geometry may not be a problem, but 
I must defer to the experts on that one.  

As an FYI just in case, the new libata-based driver will treat your drives 
as SCSI drives, so you'll see the drives as sda, sdb, and so forth instead of
hd?.  

Good luck!

Drew
