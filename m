Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267408AbSLSG1g>; Thu, 19 Dec 2002 01:27:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267509AbSLSG1g>; Thu, 19 Dec 2002 01:27:36 -0500
Received: from mail.ilk.de ([194.121.104.8]:42254 "EHLO mail.ilk.de")
	by vger.kernel.org with ESMTP id <S267408AbSLSG1e> convert rfc822-to-8bit;
	Thu, 19 Dec 2002 01:27:34 -0500
Message-ID: <1F6206BC53BCD3119059009027D1D3A2058AA018@OEKAEX01.becker.de>
From: "Jurzitza, Dieter" <JurzitzaD@becker.de>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: SUN SPARC (kernel?) issues
Date: Thu, 19 Dec 2002 07:29:24 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear listmembers,
currently I am facing some difficulties on my SUN SPARC 
(ULTRA 60, Dualprocessor, SuSE Linux 7.3, 360 MHz) you might 
have an idea about:

- kernel is vanilla 2.4.20,

symptom:
Dec 12 11:16:42 oekalux08 kernel: Inspecting  /boot/System.map-2.4.20-SMP
Dec 12 11:16:42 oekalux08 kernel: Loaded 12988 symbols from
/boot/System.map-2.4.20-SMP.
Dec 12 11:16:42 oekalux08 kernel: Symbols match kernel version 2.4.20.
Dec 12 11:16:42 oekalux08 kernel: Error reading kernel symbols - Cannot
allocate memory 

The last line is the one I do not understand and that does 
not match the lines before. Does this impact the system stability?

Secondly I am facing difficulties with regard to network 
stability. After nfs-mounts I repeatedly had the entire 
system crash. This would look like:

(here I saw still a 2.4.19 kernel):

Nov 26 07:58:41 oekalux08 PAM-unix2[2935]: session started for user root,
service su 
Nov 26 07:58:57 oekalux08 kernel: Unable to handle kernel NULL pointer
dereference
Nov 26 07:58:57 oekalux08 kernel: tsk->{mm,active_mm}->context =
0000000000000775
Nov 26 07:58:57 oekalux08 kernel: tsk->{mm,active_mm}->pgd =
fffff8004c434000
Nov 26 07:58:57 oekalux08 kernel:               \|/ ____ \|/
Nov 26 07:58:57 oekalux08 kernel:               "@'/ .. \`@"
Nov 26 07:58:57 oekalux08 kernel:               /_| \__/ |_\
Nov 26 07:58:57 oekalux08 kernel:                  \__U_/
Nov 26 07:58:57 oekalux08 kernel: mount(2942): Oops
Nov 26 07:58:57 oekalux08 kernel: CPU[0]: local_irq_count[0] irqs_running[0]
Nov 26 07:58:57 oekalux08 kernel: TSTATE: 0000004411009601 
TPC: 00000000004330cc TNPC: 00000000004330d0 Y: 07000000 Tainted: P 
Nov 26 07:58:57 oekalux08 kernel: g0: 00000000000ab638 g1: 0000000000035ff0
g2: 0000000000000000 g3: fffffffffffffff8
Nov 26 07:58:57 oekalux08 kernel: g4: fffff80000000000 g5: 0000000000000000
g6: fffff8004d20c000 g7: 0000000000000000
Nov 26 07:58:57 oekalux08 kernel: o0: 000000000000fc00 o1: 0000000000000011
o2: 0000000000000000 o3: 0000000000000011
Nov 26 07:58:57 oekalux08 kernel: o4: 0000000000000080 o5: 0000000000000000
sp: fffff8004d20f501 ret_pc: 00000000004332d4
Nov 26 07:58:57 oekalux08 kernel: l0: fffff8004d20fdb0 l1: 0000000000000d80
l2: 0000000000010e3c l3: 000000007002a918
Nov 26 07:58:57 oekalux08 kernel: l4: 0000000070044b00 l5: 0000000000000000
l6: 00000000700003d0 l7: 000000007002a194
Nov 26 07:58:57 oekalux08 kernel: i0: 0000000000000000 i1: fffff8004d20feb0
i2: 0000000000000000 i3: 0000000000007fff
Nov 26 07:58:57 oekalux08 kernel: i4: 000000007002b230 i5: 0000000000000000
i6: fffff8004d20f601 i7: 0000000000433400
Nov 26 07:58:57 oekalux08 kernel: Caller[0000000000433400]
Nov 26 07:58:57 oekalux08 kernel: Caller[0000000000410934]
Nov 26 07:58:57 oekalux08 kernel: Caller[000000000001280c]
Nov 26 07:58:57 oekalux08 kernel: Instruction DUMP: 9de3bf00  
1100003f  a007a7af <d6162032> 901223ff  d4162036  80a2c008  d2162034
d424203c 
Nov 26 07:58:57 oekalux08 kernel: CPU[1]: local_irq_count[0] irqs_running[0]
Nov 26 07:58:57 oekalux08 kernel: TSTATE: 0000009900000a04 
TPC: 00000000700e9e74 TNPC: 00000000700e9e78 Y: 0078ebd0    Tainted: P 
Nov 26 07:58:57 oekalux08 kernel: g0: 0000000000000000 g1: 000000006c63feff
g2: 0000000070189c00 g3: fffffffffffff1f0
Nov 26 07:58:57 oekalux08 kernel: g4: 00000000006d6500 g5: 0000000000545a00
g6: 0000000000000000 g7: 0000006b65726e00
Nov 26 07:58:57 oekalux08 kernel: o0: 0000000000000e10 o1: 00000000fffffcf4
o2: 00000000fffffd3c o3: 00000000fffffd2c
Nov 26 07:58:57 oekalux08 kernel: o4: 00000000fffffd60 o5: 0000000000001c20
sp: 00000000efffec70 ret_pc: 00000000700e9e24
Nov 26 07:58:57 oekalux08 kernel: l0: 00004000 l1: 00025d30 l2: 00096820 l3:
0002a3ec l4: 00025400 l5: 00000000 l6: 
00000000 l7: 701878d4
Nov 26 07:58:57 oekalux08 kernel: i0: 3de31bb1 i1: 00000001 i2: fffffc00 i3:
efffed38 i4: 7018bea8 i5: 3de31bb1 i6: 
efffecd8 i7: 700e8d5c

Using 2.4.20 I haven't got this far. Simply:
Dec 12 09:59:11 oekalux08 kernel: nfs_read_super: get root inode failed
Dec 12 09:59:11 oekalux08 kernel: nfs warning: mount version older than
kernel
Dec 12 10:08:31 oekalux08 kernel: Unable to handle kernel paging request at
virtual address 0000000000010000

Any ideas? Many thanks for your support and help in advance, 
have a peaceful christmas eve and a happy new year,
take care



Dieter Jurzitza
 

-- 
________________________________________________

HARMAN BECKER AUTOMOTIVE SYSTEMS

Dr.-Ing. Dieter Jurzitza
Manager Hardware Systems
         ESI

Industriegebiet Ittersbach
Becker-Göring Str. 16
D-76307 Karlsbad / Germany

Phone: +49 (0)7248 71-1577
Fax:   +49 (0)7248 71-1216
eMail: JurzitzaD@Becker.de
Internet: http://www.becker.de


*******************************************
Diese E-Mail enthaelt vertrauliche und/oder rechtlich geschuetzte Informationen. Wenn Sie nicht der richtige Adressat sind oder diese E-Mail irrtuemlich erhalten haben, informieren Sie bitte sofort den Absender und loeschen Sie diese Mail. Das unerlaubte Kopieren sowie die unbefugte Weitergabe dieser Mail ist nicht gestattet.
 
This e-mail may contain confidential and/or privileged information. If you are not the intended recipient (or have received this e-mail in error) please notify the sender immediately and delete this e-mail. Any unauthorised copying, disclosure or distribution of the contents in this e-mail is strictly forbidden.
*******************************************

