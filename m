Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263823AbUACTg5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 14:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263834AbUACTg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 14:36:57 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:39186 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263823AbUACTgz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 14:36:55 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: 2.6.0 performance problems
Date: Sat, 03 Jan 2004 14:37:02 -0500
Organization: TMR Associates, Inc
Message-ID: <bt74u9$cnk$1@gatekeeper.tmr.com>
References: <Pine.LNX.4.58.0312291420370.1586@home.osdl.org> <Pine.LNX.4.58.0312291803420.5835@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1073157897 13044 192.168.12.10 (3 Jan 2004 19:24:57 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
In-Reply-To: <Pine.LNX.4.58.0312291803420.5835@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Molina wrote:
> 
> On Mon, 29 Dec 2003, Linus Torvalds wrote:
> 
> 
>>
>>On Mon, 29 Dec 2003, Thomas Molina wrote:
>>
>>>I just finished a couple of comparisons between 2.4 and 2.6 which seem to 
>>>confirm my impressions.  I understand that the comparison may not be 
>>>apples to apples and my methods of testing may not be rigorous, but here 
>>>it is.  In contrast to some recent discussions on this list, this test is 
>>>a "real world" test at which 2.6 comes off much worse than 2.4.  
>>
>>Are you sure you have DMA enabled on your laptop disk? Your 2.6.x system 
>>times are very high - much bigger than the user times. That sounds like 
>>PIO to me.
> 
> 
> 
> Sorry.  One other bit of data from 2.6:
> 
> [root@lap bitkeeper]# hdparm -i /dev/hda
> 
> /dev/hda:
> 
>  Model=IBM-DJSA-220, FwRev=JS4OAC3A, SerialNo=44V44FT3300
>  Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
>  RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
>  BuffType=DualPortCache, BuffSize=1874kB, MaxMultSect=16, MultSect=16
>  CurCHS=17475/15/63, CurSects=16513875, LBA=yes, LBAsects=39070080
>  IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
>  PIO modes:  pio0 pio1 pio2 pio3 pio4
>  DMA modes:  mdma0 mdma1 mdma2
>  UDMA modes: udma0 udma1 *udma2 udma3 udma4
>  AdvancedPM=yes: mode=0x80 (128) WriteCache=enabled
>  Drive conforms to: ATA/ATAPI-5 T13 1321D revision 1:
> 
>  * signifies the current active mode

What mode does 2.4 use?
-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
