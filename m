Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283591AbRLRBdb>; Mon, 17 Dec 2001 20:33:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283581AbRLRBdW>; Mon, 17 Dec 2001 20:33:22 -0500
Received: from chmls16.mediaone.net ([24.147.1.151]:63109 "EHLO
	chmls16.mediaone.net") by vger.kernel.org with ESMTP
	id <S283439AbRLRBdE>; Mon, 17 Dec 2001 20:33:04 -0500
Subject: Re: Poor performance during disk writes
From: jlm <jsado@mediaone.net>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1008637755.2501.9.camel@localhost.localdomain>
In-Reply-To: <1008636811.226.0.camel@PC2> 
	<1008637755.2501.9.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 17 Dec 2001 20:36:07 -0500
Message-Id: <1008639370.226.2.camel@PC2>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2001-12-17 at 20:09, Reid Hekman wrote:

> Specific kernel version, df, & hdparm output would all be helpful. 
/usr 24> uname -a
Linux PC2 2.4.16 #1 Sun Dec 2 15:26:09 EST 2001 i586 unknown
/usr 25> df . 
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/hdb1              6047724   3472788   2267728  61% /usr
/usr 26> hdparm -I /dev/hdb

/dev/hdb:

non-removable ATA device, with non-removable media
        Model Number:           ST320413A                               
        Serial Number:          6ED2305M            
        Firmware Revision:      3.39    
Standards:
        Supported: 1 2 3 4 5 
        Likely used: 5
Configuration:
        Logical         max     current
        cylinders       16383   16383
        heads           16      16
        sectors/track   63      63
        bytes/track:    0               (obsolete)
        bytes/sector:   0               (obsolete)
        current sector capacity: 16514064
        LBA user addressable sectors = 39102336
Capabilities:
        LBA, IORDY(can be disabled)
        Buffer size: 512.0kB    Queue depth: 1
        Standby timer values: spec'd by standard
        r/w multiple sector transfer: Max = 16  Current = 16
        DMA: mdma0 mdma1 *mdma2 udma0 udma1 udma2 udma3 udma4 udma5 
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4 
             Cycle time: no flow control=240ns  IORDY flow control=120ns
Commands/features:
        Enabled Supported:
           *    READ BUFFER cmd
           *    WRITE BUFFER cmd
           *    Host Protected Area feature set
           *    look-ahead
           *    write cache
           *    Power Management feature set
                Security Mode feature set
                SMART feature set
                SET MAX security extension
           *    DOWNLOAD MICROCODE cmd
Security: 
        Master password revision code = 65534
                supported
        not     enabled
        not     locked
        not     frozen
        not     expired: security count
        not     supported: enhanced erase
HW reset results:
        CBLID- above Vih
        Device num = 1
Checksum: correct

My hdb hard drive is where I found the problem originally. Also, I'm
running the ext2 filesystem.

-- 
MACINTOSH = Machine Always Crashes If Not The Operating System Hangs
"Life would be so much easier if we could just look at the source code."
- Dave Olson

