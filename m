Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262937AbSKZKqC>; Tue, 26 Nov 2002 05:46:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263276AbSKZKqC>; Tue, 26 Nov 2002 05:46:02 -0500
Received: from rrzs2.rz.uni-regensburg.de ([132.199.1.2]:43392 "EHLO
	rrzs2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id <S262937AbSKZKqB>; Tue, 26 Nov 2002 05:46:01 -0500
Date: Tue, 26 Nov 2002 11:53:16 +0100
From: Christian Guggenberger 
	<Christian.Guggenberger@physik.uni-regensburg.de>
To: Dennis Grant <trog@wincom.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Identifying/activating faster ATAxx modes (WAS kernel config tale of woe)
Message-ID: <20021126115316.A22835@pc9391.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.2.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> /dev/hda:
>> 
>>  Model=Maxtor 6E030L0, FwRev=NAR61590, SerialNo=E106SZLE
>>  Config={ Fixed }
>>  RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
>>  BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=16
>>  CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=60058656
>>  IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
>>  PIO modes:  pio0 pio1 pio2 pio3 pio4
>>  DMA modes:  mdma0 mdma1 mdma2
>>  UDMA modes: udma0 udma1 udma2 udma3 udma4 udma5 *udma6
>>  AdvancedPM=yes: disabled (255) WriteCache=enabled
>>  Drive conforms to: (null):  1 2 3 4 5 6 7
>> 
>> Output from hdparm -tT
>> 
>> /dev/hda:
>>  Timing buffer-cache reads:   128 MB in  0.44 seconds =290.91 MB/sec
>>  Timing buffered disk reads:  64 MB in  8.11 seconds =  7.89 MB/sec
> 
> This is weird.  Your disk seems to be set up for udma6 (UATA133),
> which should provide for transfer rates of at least 40MiB/s.

Dennis,

you have a VIA kt8235 Southbrigde?
You need kernel >= 2.4.20-rc2, to get UDMA working with that chipset.
Of course, as Tomas pointed out, latest ac has much more ide improvements, so 
it probably would do even better with kt8235.

But >= 2.4.20-rc2 works like a charm here for me with the via kt8235.

Christian

