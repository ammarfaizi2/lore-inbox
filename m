Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964941AbVIKMaH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964941AbVIKMaH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 08:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964947AbVIKMaH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 08:30:07 -0400
Received: from dialup-63-108-131-22.nehp.net ([63.108.131.22]:10919 "EHLO
	waltsathlon.localhost.net") by vger.kernel.org with ESMTP
	id S964941AbVIKMaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 08:30:05 -0400
Message-ID: <43242339.1000205@lorettotel.net>
Date: Sun, 11 Sep 2005 07:29:45 -0500
From: Walt H <walt_h@lorettotel.net>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050723)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: asmith@vtrl.co.uk
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: kernel performance problem
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>This is my first ever posting  to this list, so please excuse me if I've 
>f**cked up and broken protocol.
>I use an IDE LG DVD-RW drive for backup(GSA-4081B).
>Back around 2.6.10 it wrote at typically 1.6-1.7x speed, but thereafter  
>it dropped to  around 0.6-0.7 x.
>
>
>%hdparm -I /dev/hdd
>
>/dev/hdd:
>
>ATAPI CD-ROM, with removable media
>        Model Number:       HL-DT-ST DVDRAM GSA-4081B              
>        Serial Number:      K2B3CFE4600        
>        Firmware Revision:  A100   
>Standards:
>        Likely used CD-ROM ATAPI-1
>Configuration:
>        DRQ response: 50us.
>        Packet size: 12 bytes
>Capabilities:
>        LBA, IORDY(can be disabled)
>        DMA: mdma0 mdma1 mdma2 udma0 udma1 *udma2
>             Cycle time: min=120ns recommended=120ns
>        PIO: pio0 pio1 pio2 pio3 pio4
>             Cycle time: no flow control=120ns  IORDY flow control=120ns
>HW reset results:
>        CBLID- below Vih
>        Device num = 1
>

Hi Andrew,

I know that hdparm shows udma2 mode selected for data transfers, but 
check that dma is *actually* turned on.  ie:  hdparm -d1 /dev/hdd

I don't remember exactly when this went in, but there were some IDE 
patches around the 2.6.11 or so timeframe that seemed to change the way 
these devices get setup at boot.  I believe this happened when the 
autotune= syntax was deprecated.  HTH,

-Walt



