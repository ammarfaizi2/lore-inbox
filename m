Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266835AbUHISY5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266835AbUHISY5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 14:24:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266833AbUHISWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 14:22:41 -0400
Received: from adsl-67-114-19-185.dsl.pltn13.pacbell.net ([67.114.19.185]:8600
	"EHLO bastard.smallmerchant.com") by vger.kernel.org with ESMTP
	id S266831AbUHISTX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 14:19:23 -0400
Message-ID: <4117C028.7080905@tupshin.com>
Date: Mon, 09 Aug 2004 11:19:20 -0700
From: Tupshin Harper <tupshin@tupshin.com>
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: /dev/hdl not showing up because of	fix-ide-probe-double-detection
 patch
References: <411013F7.7080800@tupshin.com> <4111651E.1040406@tupshin.com>	 <20040804224709.3c9be248.akpm@osdl.org> <1091720165.8041.4.camel@localhost.localdomain>
In-Reply-To: <1091720165.8041.4.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> Two disks are not permitted to have the same serial number. If you can
>
>give me the full ident data I'll take a detailed look - could be I'm not
>comparing enough bytes if its only different on the last digit.
>
>Alan
>
>  
>
I originally thought that the problem might be not enough bytes being 
checked, but now I'm concerned that Maxtor has some problem with not 
having a proper serial number recorded for some drives. hdparm -i also 
show M0000000000000000000 for both of these drives. Below is the output 
of hdparm -i for the two drives, and below that, the output of catting 
/dev/ide/hdk and hdl.

Doing a google search on "M0000000000000000000" shows that there have a 
been a handful of reports of maxtor drives showing this as the serial 
number, but I don't see any explanation of why.

-Tupshin



 hdparm -i /dev/hdl

/dev/hdl:

 Model=Maxtor 4R120L0, FwRev=RAMB1TU0, SerialNo=M0000000000000000000
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
 BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=240121728
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 udma2 udma3 udma4 udma5 *udma6
 AdvancedPM=yes: disabled (255) WriteCache=enabled
 Drive conforms to: (null):

 * signifies the current active mode

rescue:/home/tupshin# hdparm -i /dev/hdk

/dev/hdk:

 Model=Maxtor 4R120L0, FwRev=RAMB1TU0, SerialNo=M0000000000000000000
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
 BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=240121728
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 udma2 udma3 udma4 udma5 *udma6
 AdvancedPM=yes: disabled (255) WriteCache=enabled
 Drive conforms to: (null):

 * signifies the current active mode

 cat /proc/ide/hdl/identify
0040 3fff c837 0010 0000 0000 003f 0000
0000 0000 4d30 3030 3030 3030 3030 3030
3030 3030 3030 3030 0003 1000 0039 5241
4d42 3154 5530 4d61 7874 6f72 2034 5231
3230 4c30 2020 2020 2020 2020 2020 2020
2020 2020 2020 2020 2020 2020 2020 8010
0000 2f00 4000 0200 0000 0007 3fff 0010
003f fc10 00fb 0110 f780 0e4f 0000 0007
0003 0078 0078 0078 0078 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
00fe 001e 7c6b 7b09 4003 7c68 3a01 4003
407f 0000 0000 0000 fffe 6b00 c0c0 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0001 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0001 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 8aa5

 cat /proc/ide/hdk/identify
0040 3fff c837 0010 0000 0000 003f 0000
0000 0000 4d30 3030 3030 3030 3030 3030
3030 3030 3030 3030 0003 1000 0039 5241
4d42 3154 5530 4d61 7874 6f72 2034 5231
3230 4c30 2020 2020 2020 2020 2020 2020
2020 2020 2020 2020 2020 2020 2020 8010
0000 2f00 4000 0200 0000 0007 3fff 0010
003f fc10 00fb 0110 f780 0e4f 0000 0007
0003 0078 0078 0078 0078 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
00fe 001e 7c6b 7b09 4003 7c68 3a01 4003
407f 0000 0000 0000 fffe 603b c0c0 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0001 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0001 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 5aa5

