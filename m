Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266682AbSKOU51>; Fri, 15 Nov 2002 15:57:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266688AbSKOU51>; Fri, 15 Nov 2002 15:57:27 -0500
Received: from pc-62-31-12-35-bf.blueyonder.co.uk ([62.31.12.35]:60432 "EHLO
	carrot.sunnyroyd.coldcomfortfarm.org") by vger.kernel.org with ESMTP
	id <S266682AbSKOU50>; Fri, 15 Nov 2002 15:57:26 -0500
Subject: Re: Anyone use HPT366 + UDMA in Linux?
From: Ian Castle <ian.castle@coldcomfortfarm.net>
To: mailinglist@ichilton.co.uk
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1037394252.1755.12.camel@kerberos.sunnyroyd.coldcomfortfarm.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 15 Nov 2002 21:04:13 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BP6 + HPT366 (on board) with latest BIOS

[root@penguin /root]# dmesg -s 32786 | grep UDMA
hde: IBM-DPTA-372050, 19574MB w/1961kB Cache, CHS=39770/16/63, UDMA(66)
hdg: IC35L060AVVA07-0, 58644MB w/1863kB Cache, CHS=119150/16/63,
UDMA(66)

[root@penguin /root]# hdparm -i /dev/hde

/dev/hde:

 Model=IBM-DPTA-372050, FwRev=P76OA30A, SerialNo=JMYJMT3F033
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=34
 BuffType=3(DualPortCache), BuffSize=1961kB, MaxMultSect=16,
MultSect=off
 DblWordIO=no, OldPIO=2, DMA=yes, OldDMA=2
 CurCHS=65535/1/63, CurSects=-4128706, LBA=yes, LBAsects=40088160
 tDMA={min:120,rec:120}, DMA modes: mword0 mword1 mword2
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, PIO modes: mode3 mode4
 UDMA modes: mode0 mode1 mode2 mode3 *mode4

[root@penguin /root]# hdparm -i /dev/hdg

/dev/hdg:

 Model=IC35L060AVVA07-0, FwRev=VA3OA52A, SerialNo=VNC302A3G8LZ9A
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=52
 BuffType=3(DualPortCache), BuffSize=1863kB, MaxMultSect=16,
MultSect=off
 DblWordIO=no, OldPIO=2, DMA=yes, OldDMA=2
 CurCHS=65535/1/63, CurSects=-4128706, LBA=yes, LBAsects=120103200
 tDMA={min:120,rec:120}, DMA modes: mword0 mword1 mword2
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, PIO modes: mode3 mode4
 UDMA modes: mode0 mode1 mode2 mode3 *mode4 mode5

[root@penguin /root]# uname -r
2.2.19-3smp

[root@penguin /root]# uptime
  8:55pm  up 23 days,  8:24,  2 users,  load average: 0.00, 0.00, 0.00

This is 2.2.19 + the IDE patch. It is had this configuration for a few
years - and tends to go down with powercuts etc. rather than anything
else. No disk corruption.

There is another with a similar configuration which is on a UPS and has
a lot more uptime.

I'm just using SCSI at the moment on my 2.4 kernel BP6 box - but I never
noticed any problems with IDE when I was using it (I had to do a small
patch for a bug which made hdparm refuse to change back to mode4 once it
had gone down to a lower mode - this with 2.4.18 and lower.).

Ian Chilton wrote:
> Hello,
> 
> I am interested in anyone that has this sucessfully working - if you
> have maybe you can drop me a mail telling me how you did it :)
-- 
Ian Castle <ian.castle@coldcomfortfarm.net>

