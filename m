Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317851AbSHZCd7>; Sun, 25 Aug 2002 22:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317852AbSHZCd7>; Sun, 25 Aug 2002 22:33:59 -0400
Received: from mta03bw.bigpond.com ([139.134.6.86]:20186 "EHLO
	mta03bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S317851AbSHZCd6> convert rfc822-to-8bit; Sun, 25 Aug 2002 22:33:58 -0400
Content-Type: text/plain; charset=US-ASCII
From: Iain <iain@myspinach.org>
To: linux-kernel@vger.kernel.org
Subject: Promise 20267 in DMA mode?
Date: Mon, 26 Aug 2002 12:31:22 +1000
User-Agent: KMail/1.4.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208251437.19398.iain@myspinach.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

How do I enable DMA for my Promise 20267 raid controller? I'm using kernel 
2.4.18 with relevant config details:

CONFIG_BLK_DEV_PDC202XX=y
CONFIG_PDC202XX_BURST=y
# CONFIG_PDC202XX_FORCE is not set
CONFIG_BLK_DEV_ATARAID_PDC=y

cat /proc/ide/pdc202xx gives:

                                PDC20267 Chipset.
------------------------------- General Status 
---------------------------------
Burst Mode                           : enabled
Host Mode                            : Normal
Bus Clocking                         : 66 External
IO pad select                        : 10 mA
Status Polling Period                : 0
Interrupt Check Status Polling Delay : 0
--------------- Primary Channel ---------------- Secondary Channel 
-------------
                enabled                          enabled
66 Clocking     disabled                         disabled
           Mode MASTER                      Mode MASTER
                FIFO Empty                       FIFO Empty
--------------- drive0 --------- drive1 -------- drive0 ---------- drive1 
------
DMA enabled:    no               no              no                no
DMA Mode:       UDMA 4           NOTSET          UDMA 4            NOTSET
PIO Mode:       PIO ?            NOTSET           PIO ?            NOTSET

If I try hdparm -d1 /dev/hde it gives:

/dev/hde:
 setting using_dma to 1 (on)
 HDIO_SET_DMA failed: Operation not permitted
 using_dma    =  0 (off)

Please CC replies to me.

thanks, Iain.

-- 
PGP info: http://www.myspinach.org/~iain/pgpinfo.html


