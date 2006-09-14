Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751099AbWINTqQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbWINTqQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 15:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751100AbWINTqQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 15:46:16 -0400
Received: from mxsf11.cluster1.charter.net ([209.225.28.211]:1690 "EHLO
	mxsf11.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S1751099AbWINTqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 15:46:15 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17673.45444.235935.556763@smtp.charter.net>
Date: Thu, 14 Sep 2006 15:46:12 -0400
From: "John Stoffel" <john@stoffel.org>
To: Al Boldi <a1426z@gawab.com>
Cc: "John Stoffel" <john@stoffel.org>, Jens Axboe <axboe@kernel.dk>,
       linux-kernel@vger.kernel.org
Subject: Re: What's in linux-2.6-block.git
In-Reply-To: <200609132052.53984.a1426z@gawab.com>
References: <200609131359.04972.a1426z@gawab.com>
	<200609131435.31390.a1426z@gawab.com>
	<17672.5209.158911.963437@smtp.charter.net>
	<200609132052.53984.a1426z@gawab.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Al" == Al Boldi <a1426z@gawab.com> writes:

Al> Thanks for your input!

You're welcome, sorry I've been delayed in getting more details to
you.  I'll try and run some tests tonight, but the six month old kept
me up alot last niht.

Al> Are you running UDMA5?  Can you dump the full hdparm -I

Here's the info for each drive.  They're on an HPT302 Rev 1 controller
in my system.

/dev/hde:

ATA device, with non-removable media
        Model Number:       WDC WD1200JB-00CRA1                     
        Serial Number:      WD-WMA8C4365875
        Firmware Revision:  17.07W17
Standards:
        Supported: 5 4 3 
        Likely used: 6
Configuration:
        Logical         max     current
        cylinders       16383   16383
        heads           16      16
        sectors/track   63      63
        --
        CHS current addressable sectors:   16514064
        LBA    user addressable sectors:  234441648
        device size with M = 1024*1024:      114473 MBytes
        device size with M = 1000*1000:      120034 MBytes (120 GB)
Capabilities:
        LBA, IORDY(can be disabled)
        bytes avail on r/w long: 40
        Standby timer values: spec'd by Standard, with device specific
minimum
        R/W multiple sector transfer: Max = 16  Current = 16
        Recommended acoustic management value: 128, current value: 254
        DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5 
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4 
             Cycle time: no flow control=120ns  IORDY flow
control=120ns
Commands/features:
        Enabled Supported:
           *    SMART feature set
                Security Mode feature set
           *    Power Management feature set
           *    Write cache
           *    Look-ahead
           *    Host Protected Area feature set
           *    WRITE_BUFFER command
           *    READ_BUFFER command
           *    DOWNLOAD_MICROCODE
                SET_MAX security extension
                Automatic Acoustic Management feature set
           *    Device Configuration Overlay feature set
           *    SMART error logging
           *    SMART self-test
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
Checksum: correct



/dev/hdg:

ATA device, with non-removable media
        Model Number:       WDC WD1200JB-00EVA0                     
        Serial Number:      WD-WMAEK2844058
        Firmware Revision:  15.05R15
Standards:
        Supported: 6 5 4 
        Likely used: 6
Configuration:
        Logical         max     current
        cylinders       16383   65535
        heads           16      1
        sectors/track   63      63
        --
        CHS current addressable sectors:    4128705
        LBA    user addressable sectors:  234441648
        LBA48  user addressable sectors:  234441648
        device size with M = 1024*1024:      114473 MBytes
        device size with M = 1000*1000:      120034 MBytes (120 GB)
Capabilities:
        LBA, IORDY(can be disabled)
        Standby timer values: spec'd by Standard, with device specific
minimum
        R/W multiple sector transfer: Max = 16  Current = 16
        Recommended acoustic management value: 128, current value: 254
        DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5 
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4 
             Cycle time: no flow control=120ns  IORDY flow
control=120ns
Commands/features:
        Enabled Supported:
           *    SMART feature set
                Security Mode feature set
           *    Power Management feature set
           *    Write cache
           *    Look-ahead
           *    Host Protected Area feature set
           *    WRITE_BUFFER command
           *    READ_BUFFER command
           *    DOWNLOAD_MICROCODE
                SET_MAX security extension
                Automatic Acoustic Management feature set
           *    48-bit Address feature set
           *    Device Configuration Overlay feature set
           *    Mandatory FLUSH_CACHE
           *    FLUSH_CACHE_EXT
           *    SMART error logging
           *    SMART self-test
Security: 
                supported
        not     enabled
        not     locked
        not     frozen
        not     expired: security count
        not     supported: enhanced erase
HW reset results:
        CBLID- above Vih
        Device num = 0 determined by CSEL
Checksum: correct


Al> What thruput do you get with cat /dev/hd[eg] > /dev/null?

Al> What does cat /sys/block/hde/queue/read_ahead_kb say?

    > cat /sys/block/hde/queue/max_hw_sectors_kb 
    128
    > cat /sys/block/hde/queue/max_sectors_kb
    128
    > cat /sys/block/hde/queue/read_ahead_kb
    1024
    > cat /sys/block/hde/queue/scheduler 
    noop [anticipatory] deadline cfq 
    > cat /sys/block/hde/queue/nr_requests
    128

    > cat /sys/block/hdg/queue/max_hw_sectors_kb 
    1024
    > cat /sys/block/hdg/queue/max_sectors_kb 
    512
    > cat /sys/block/hdg/queue/read_ahead_kb
    1024
    > cat /sys/block/hdg/queue/scheduler 
    noop [anticipatory] deadline cfq 
    > cat /sys/block/hdg/queue/nr_requests 
    128

Al> Then try this for best performance:
Al> echo 192 > /sys/block/hde/queue/max_sectors_kb
Al> echo 192 > /sys/block/hde/queue/read_ahead_kb

Al> and repeat the thruput test reporting vmstat results.

I'll try and do this all tonight if I get a chance.

>From looking at my setup, I've got two identical drives which are
slightly different in terms of BIOS levels, as well as in native
capabilities, so this should be a useful test.

I've got a third drive of the same type, but it's in a USB/FireWire
enclosure and I can't hdparm it directly.  

John
