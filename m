Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264709AbRF1WPl>; Thu, 28 Jun 2001 18:15:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264745AbRF1WPb>; Thu, 28 Jun 2001 18:15:31 -0400
Received: from cs159246.pp.htv.fi ([213.243.159.246]:16432 "EHLO
	porkkala.cs140085.pp.htv.fi") by vger.kernel.org with ESMTP
	id <S264709AbRF1WPT>; Thu, 28 Jun 2001 18:15:19 -0400
Message-ID: <3B3BAC65.3ED4CBEF@pp.htv.fi>
Date: Fri, 29 Jun 2001 01:15:01 +0300
From: Jussi Laako <jlaako@pp.htv.fi>
X-Mailer: Mozilla 4.76 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: "Ryan W. Maple" <ryan@guardiandigital.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: VIA 686B/Data Corruption
In-Reply-To: <Pine.LNX.4.10.10106281741070.11750-100000@mastermind.inside.guardiandigital.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Ryan W. Maple" wrote:
> 
> I remember hearing something about Red Hat disabling UDMA on VIA chips
> across the board.  Maybe that has something to do with it?

Dunno, if the kernel lies. There are four HDs on Promise and one HD and one
CDROM on VIA. This is from currently running 2.4.2-2:

----------VIA BusMastering IDE Configuration----------------
Driver Version:                     3.20
South Bridge:                       VIA vt82c686b
Revision:                           ISA 0x40 IDE 0x6
BM-DMA base:                        0xb800
PCI clock:                          33MHz
Master Read  Cycle IRDY:            0ws
Master Write Cycle IRDY:            0ws
BM IDE Status Register Read Retry:  yes
Max DRDY Pulse Width:               No limit
-----------------------Primary IDE-------Secondary IDE------
Read DMA FIFO flush:          yes                 yes
End Sector FIFO flush:         no                  no
Prefetch Buffer:               no                  no
Post Write Buffer:             no                  no
Enabled:                      yes                 yes
Simplex only:                  no                  no
Cable Type:                   40w                 40w
-------------------drive0----drive1----drive2----drive3-----
Transfer Mode:       UDMA       PIO       PIO       PIO

Address Setup:       30ns      30ns     120ns     120ns
Cmd Active:          90ns      90ns     480ns     480ns
Cmd Recovery:        30ns      30ns     480ns     480ns
Data Active:         90ns      90ns     330ns     330ns
Data Recovery:       30ns      30ns     270ns     270ns
Cycle Time:          60ns      90ns      90ns      90ns
Transfer Rate:   33.3MB/s  22.2MB/s  22.2MB/s  22.2MB/s


                                PDC20265 Chipset.
------------------------------- General Status ----------------------------
Burst Mode                           : enabled
Host Mode                            : Normal
Bus Clocking                         : 33 PCI Internal
IO pad select                        : 10 mA
Status Polling Period                : 0
Interrupt Check Status Polling Delay : 2
--------------- Primary Channel ---------------- Secondary Channel --------
                enabled                          enabled 
66 Clocking     enabled                          enabled 
           Mode PCI                         Mode PCI   
                FIFO Empty                       FIFO Empty  
--------------- drive0 --------- drive1 -------- drive0 ---------- drive1 -
DMA enabled:    yes              yes             yes               yes
DMA Mode:       UDMA 4           UDMA 4          UDMA 4            UDMA 4
PIO Mode:       PIO 4            PIO 4           PIO 4             PIO 4


 - Jussi Laako


-- 
PGP key fingerprint: 161D 6FED 6A92 39E2 EB5B  39DD A4DE 63EB C216 1E4B
Available at PGP keyservers
