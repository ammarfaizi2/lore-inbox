Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265275AbUGSPoi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265275AbUGSPoi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 11:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265287AbUGSPoi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 11:44:38 -0400
Received: from web41110.mail.yahoo.com ([66.218.93.26]:7095 "HELO
	web41110.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265275AbUGSPo0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 11:44:26 -0400
Message-ID: <20040719154425.8372.qmail@web41110.mail.yahoo.com>
Date: Mon, 19 Jul 2004 08:44:25 -0700 (PDT)
From: Malik Ali <alimalik98@yahoo.com>
Subject: How do I enable UDMA mode of IDE on Promise FastTrak100
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had install RH8 with Promise Fasttrak100 driver. I
had followed the instruction as mentioned in readme of
driver downloaded from intel download center. I had
Intel S845WD1-E board with on board PDC20267
controller. 

The installation completed without hickups. I found
/dev/sda as my Raid-0 device and finally I mounted the
ext3 filesystem on it.

But the Problem is that I didn't get the performance
from raid-0 device even poor performance then regular
non-raid device. However here is part of dmesg
...
Kernel command line: ro root=LABEL=/ ide0=0x1f0,0x3f6
ide1=0x170,0x376 ide2=0 ide3=0 ide4=0 ide5=0 ide6=0
ide7=0 ide8=0 ide9=0
...
ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hdaMA,
hdbMA
PDC20267: IDE controller on PCI bus 02 dev 70
PCI: Found IRQ 9 for device 02:0e.0
PDC20267: chipset revision 2
PDC20267: not 100% native mode: will probe irqs later
PDC20267: (U)DMA Burst Bit ENABLED Primary MASTER Mode
Secondary MASTER Mode.
PDC20267: too many IDE interfaces, no room in table
PDC20267: too many IDE interfaces, no room in table
PDC20267: neither IDE port enabled (BIOS)
...
--> Look at last three lines, isn't questionable?
Why these two ides got room in table?
Why neither IDE port enabled (BIOS)?

now look here

# cat /proc/ide/pdc202xx

PDC20267 Chipset.
------------------------------- General Status
---------------------------------
Burst Mode : enabled
Host Mode : Normal
Bus Clocking : 66 External
IO pad select : 10 mA
Status Polling Period : 0
Interrupt Check Status Polling Delay : 0
--------------- Primary Channel ----------------
Secondary Channel -------------
enabled enabled
66 Clocking disabled disabled
Mode MASTER Mode MASTER
FIFO Empty FIFO Empty
--------------- drive0 --------- drive1 --------
drive0 ---------- drive1 ------
DMA enabled: no no no no
DMA Mode: UDMA 4 NOTSET UDMA 4 NOTSET
PIO Mode: PIO 4 NOTSET PIO 4 NOTSET

--> DMA enabled no no ...?

Wht I feel that if I somehow I enabled DMA i might get
the performance.

please any one could help me it will be
appreciateable.
If my arguments are wrong plz let me correct.

THX 

MALIK


		
__________________________________
Do you Yahoo!?
Vote for the stars of Yahoo!'s next ad campaign!
http://advision.webevents.yahoo.com/yahoo/votelifeengine/

