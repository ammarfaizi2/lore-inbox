Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266091AbSKZDlr>; Mon, 25 Nov 2002 22:41:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266094AbSKZDlr>; Mon, 25 Nov 2002 22:41:47 -0500
Received: from louise.pinerecords.com ([212.71.160.16]:57356 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S266091AbSKZDlq>; Mon, 25 Nov 2002 22:41:46 -0500
Date: Tue, 26 Nov 2002 04:49:00 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Dennis Grant <trog@wincom.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Identifying/activating faster ATAxx modes (WAS kernel config tale of woe)
Message-ID: <20021126034900.GB29196@louise.pinerecords.com>
References: <3de2eee3.16fd.0@wincom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3de2eee3.16fd.0@wincom.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> /dev/hda:
> 
>  Model=Maxtor 6E030L0, FwRev=NAR61590, SerialNo=E106SZLE
>  Config={ Fixed }
>  RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
>  BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=16
>  CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=60058656
>  IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
>  PIO modes:  pio0 pio1 pio2 pio3 pio4
>  DMA modes:  mdma0 mdma1 mdma2
>  UDMA modes: udma0 udma1 udma2 udma3 udma4 udma5 *udma6
>  AdvancedPM=yes: disabled (255) WriteCache=enabled
>  Drive conforms to: (null):  1 2 3 4 5 6 7
> 
> Output from hdparm -tT
> 
> /dev/hda:
>  Timing buffer-cache reads:   128 MB in  0.44 seconds =290.91 MB/sec
>  Timing buffered disk reads:  64 MB in  8.11 seconds =  7.89 MB/sec

This is weird.  Your disk seems to be set up for udma6 (UATA133),
which should provide for transfer rates of at least 40MiB/s.

Could you try a recent -ac kernel?  It comes with a significantly
more modern IDE driver that fixes lots of issues with newer chipsets.

ftp://ftp.kernel.org/pub/linux/kernel/people/alan/linux-2.4/2.4.20/patch-2.4.20-rc2-ac3.gz
(apply on top of patch-2.4.20-rc2 found in /pub/linux/kernel/v2.4/testing/)

-- 
Tomas Szepe <szepe@pinerecords.com>
