Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261964AbSI1Pkp>; Sat, 28 Sep 2002 11:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261979AbSI1Pkp>; Sat, 28 Sep 2002 11:40:45 -0400
Received: from tom.hrz.tu-chemnitz.de ([134.109.132.38]:56788 "EHLO
	tom.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S261964AbSI1Pkn>; Sat, 28 Sep 2002 11:40:43 -0400
Message-ID: <3D95CE60.30504@informatik.tu-chemnitz.de>
Date: Sat, 28 Sep 2002 17:44:32 +0200
From: Janek Neubert <janek.neubert@informatik.tu-chemnitz.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel Error with i845G
References: <3D920EAE.2020602@informatik.tu-chemnitz.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -5.0 (-----)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *17vJnB-0002o2-00*Oe4PJSBYZac*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Janek Neubert schrieb:
 > Hi,
 >
 > i have a bought an EPOX board (4G4A+) with Intel i845G chipset. While i
 > was trying a 2.4.18 kernel, the machine stops after "Ok, booting the
 > kernel ...". I have to use the lilo command mem=<memory without shared
 > graphic ram>M in megabytes. All kernels newer than 2.4.3 cause this
 > error. Since version 2.4.19, this solution is unusable. I think, this is
 > a kernel problem, because i know from other people having the same
 > problem, but other boards with i845G. I need the 2.4.19 to use my
 > HPT372. Please help and finf the error.
 >
 > I think the problem is a failure in the routine getting the size of
 > memory from BIOS. Linux thinks, i have 640k!!! RAM. Only the
 > mem-parameter can solve it.


I have some more informations for you:

dmesg - output with mem=248M

Linux version 2.4.18 (root@server) (gcc version 2.95.4 20011002 (Debian
prerelease)) #7 SMP Fre Sep 27 23:01:22 CEST 2002
BIOS-provided physical RAM map:
   BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
   BIOS-e820: 00000000000a0000 - 000000000f7f0000 (reserved)
   BIOS-e820: 000000000f7f0000 - 000000000f7f3000 (ACPI NVS)
   BIOS-e820: 000000000f7f3000 - 000000000f800000 (ACPI data)
found SMP MP-table at 000f5b00
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f0000 reserved twice.
hm, page 000f1000 reserved twice.
On node 0 totalpages: 63488
zone(0): 4096 pages.
zone(1): 59392 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.4
      Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #0 Unknown CPU [15:1] APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Processors: 1
...


Someone told me to post the output from the serial port. Sorry, i have used
minicom, cat and a null modem cabel, but there's no output.

When I use 256MB RAM, all works fine with mem=248M, if i use 512MB RAM and 
mem=504M, the maschine crashs after a full memory use like compiling a kernel.

Thx
janek
p.s. please send a cc to my email, i haven't subscribed this list


-- 
|Student of Computer Science, Chemnitz University of Technology
|Reichenhainer Str. 37/395, 09126 Chemnitz
|Telephon: (0177)2530625 URL: http://janek.eocom.de


