Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267024AbTAZWKg>; Sun, 26 Jan 2003 17:10:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267027AbTAZWKg>; Sun, 26 Jan 2003 17:10:36 -0500
Received: from mgr4.xmission.com ([198.60.22.204]:32992 "EHLO
	mgr4.xmission.com") by vger.kernel.org with ESMTP
	id <S267024AbTAZWKe>; Sun, 26 Jan 2003 17:10:34 -0500
Message-ID: <3E345F07.60307@xmission.com>
Date: Sun, 26 Jan 2003 15:19:51 -0700
From: Frank Jacobberger <f1j1@xmission.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030123
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: tom@qwws.net
CC: linux-kernel@vger.kernel.org
Subject: Re: poor IDE performance on ASUS P4PE with WD800JB
References: <200301262039.38783.tom@qwws.net>
In-Reply-To: <200301262039.38783.tom@qwws.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Winkler wrote:

>Hi,
>
>I've asked this question in several Newsgroups but nobody was really
>able to answer it. That's why I decided to send it to LKM. Please CC
>me on your replies. Thanks!
>
>I've got a question related to ide performance.
>First of all my hardware:
>Mainboard: ASUS P4PE (using onboard IDE but not S-ATA)
>   http://www.asus.com/products/mb/socket478/p4pe/overview.htm
>Harddisk: Western Digital WD800JB
>   http://www.westerndigital.com/products/products.asp?DriveID=32
>

Well I have the same P4PE and here are mine:

hdparm -I /dev/hda

/dev/hda:

ATA device, with non-removable media
        Model Number:       WDC WD300BB-00AUA1
        Serial Number:      WD-WMA6W2128969
        Firmware Revision:  18.20D18
Standards:
        Supported: 5 4 3 2
        Likely used: 6
Configuration:
        Logical         max       current
        cylinders       16383   16383
        heads             16        16
        sectors/track   63        63
        --
        CHS current addressable sectors:   16514064
        LBA    user addressable sectors:    58633344
        device size with M = 1024*1024:       28629 MBytes
        device size with M = 1000*1000:       30020 MBytes (30 GB)
Capabilities:
        LBA, IORDY(can be disabled)
        bytes avail on r/w long: 40     Queue depth: 1
        Standby timer values: spec'd by Standard, with device specific 
minimum
        R/W multiple sector transfer: Max = 16  Current = 16
        Recommended acoustic management value: 128, current value: 254
        DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
        Enabled Supported:
           *    READ BUFFER cmd
           *    WRITE BUFFER cmd
           *    Host Protected Area feature set
           *    Look-ahead
           *    Write cache
           *    Power Management feature set
                Security Mode feature set
                SMART feature set
                Automatic Acoustic Management feature set
                SET MAX security extension
           *    DOWNLOAD MICROCODE cmd
Security:
                supported
        not     enabled
        not     locked
        not     frozen
        not     expired: security count
        not     supported: enhanced erase
HW reset results:
        CBLID- above Vih
        Device num = 0 determined by the jumper
-------------------------------------------------------------------------------------------
hdparm -tT /dev/hda

/dev/hda:
 Timing buffer-cache reads:   128 MB in  0.35 seconds =365.71 MB/sec
 Timing buffered disk reads:  64 MB in  2.00 seconds = 32.00 MB/sec
------------------------------------------------------------------------------------------
cat /proc/ide/hda/settings
name                        value           min             
max             mode
----                            -----           ---                 
---             ----
acoustic                        0               0               
254             rw
address                         0               0               
2                 rw
bios_cyl                      3649          0               65535         rw
bios_head                   255            0               
255             rw
bios_sect                     63              0               
63               rw
breada_readahead        8               0               255             rw
bswap                           0              0               
1                 r
current_speed               69            0               
70               rw
failures                        0               0               
65535         rw
file_readahead            124            0               16384         rw
init_speed                   69              0               
70               rw
io_32bit                      0               0               
3                  rw
keepsettings                0               0               
1                  rw
lun                              0               0               
7                  rw
max_failures                1              0               65535         rw
max_kb_per_request  128           1               255            rw
multcount                   16             0               
16               rw
nice1                           1              0               
1                 rw
nowerr                        0              0               
1                 rw
number                       0              0               
3                 rw
pio_mode                write-only    0               255           w
slow                            0              0               
1                 rw
unmaskirq                   0              0               
1                 rw
using_dma                  1              0               
1                 rw
wcache                       0              0               
1                  rw






