Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262961AbUDYTYt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262961AbUDYTYt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Apr 2004 15:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263225AbUDYTYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Apr 2004 15:24:49 -0400
Received: from imap.gmx.net ([213.165.64.20]:646 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262961AbUDYTYr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Apr 2004 15:24:47 -0400
X-Authenticated: #555161
Message-ID: <408BFD32.7090202@hasw.net>
Date: Sun, 25 Apr 2004 20:02:26 +0200
From: Sebastian Witt <se.witt@gmx.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       linux-kernel@vger.kernel.org, andre@linux-ide.org, frankt@promise.com
Subject: Re: PROBLEM: Oops when using both channels of the PDC20262
References: <40898ADA.8020708@hasw.net> <200404242230.20985.bzolnier@elka.pw.edu.pl> <408B046B.9040306@hasw.net> <200404250331.25606.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200404250331.25606.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
 >
 > Please return back to 2.6.5 and try this patch, it disables PIO autotune.
 > It fixed hangs for people disabling Promise BIOS but...
 >
 >  linux-2.6.6-rc2-bk1-bzolnier/drivers/ide/pci/pdc202xx_old.c |    2 +-
 >  1 files changed, 1 insertion(+), 1 deletion(-)
 >  ...

Thanks, this patch works. I've tested now multiple times a 2.6.5 kernel 
with and without this patch. The BIOS of my controller is also disabled 
if this is important...

PDC20262: IDE controller at PCI slot 0000:00:11.0
PDC20262: chipset revision 1
PDC20262: 100% native mode on irq 17
PDC20262: (U)DMA Burst Bit DISABLED Primary PCI Mode Secondary PCI Mode.
     ide2: BM-DMA at 0xdc00-0xdc07, BIOS settings: hde:DMA, hdf:DMA
     ide3: BM-DMA at 0xdc08-0xdc0f, BIOS settings: hdg:DMA, hdh:DMA

                                 Ultra66 Chipset.
------------------------------- General Status
---------------------------------
Burst Mode                           : disabled
Host Mode                            : Normal
Bus Clocking                         : 33 PCI Internal
IO pad select                        : 4 mA
Status Polling Period                : 9
Interrupt Check Status Polling Delay : 9
--------------- Primary Channel ---------------- Secondary Channel 
-------------
                 enabled                          enabled
66 Clocking     disabled                         disabled
            Mode PCI                         Mode PCI
                 FIFO Empty                       FIFO Empty
--------------- drive0 --------- drive1 -------- drive0 ---------- 
drive1 ------
DMA enabled:    yes              yes             yes               yes
DMA Mode:       UDMA 4           UDMA 4          UDMA 4            UDMA 4
PIO Mode:       PIO ?            PIO ?           PIO ?            PIO ?

-------------

If you need some more testing etc. I'm available.

Thanks,
Sebastian

