Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130315AbRASC7V>; Thu, 18 Jan 2001 21:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131005AbRASC7M>; Thu, 18 Jan 2001 21:59:12 -0500
Received: from smtp10.atl.mindspring.net ([207.69.200.246]:10249 "EHLO
	smtp10.atl.mindspring.net") by vger.kernel.org with ESMTP
	id <S130315AbRASC7A>; Thu, 18 Jan 2001 21:59:00 -0500
Date: Thu, 18 Jan 2001 21:58:40 -0500 (EST)
From: Jon Eisenstein <jon@dominia.dyn.dhs.org>
Reply-To: jeisen@mindspring.com
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Kernel crash with cron/mail?
Message-ID: <Pine.LNX.4.21.0101182139030.420-100000@dominia>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1] Kernel crash with cron/mail?

2] This problem happened while I was away from the computer, so I can only
say what I could tell. Pine had apparently crashed the kernel, with the
following output:

-----------------------------------------------------------------

Unable to handle kernel paging request at virtual address fffffff0
 printing eip: FldrList   P PrevMsg       - PrevPage D Delete     R Reply
c01361deCMDS > [ViewMsg]  N NextMsg     Spc NextPage U Undelete   F Forward
*pde = 00001063
*pte = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01361de>]
EFLAGS: 00010292
eax: ffffffec   ebx: c11a2ba0   ecx: c0313720   edx: 00000003
esi: ffffffec   edi: c0313720   ebp: c29abf84   esp: c29abf10
ds: 0018   es: 0018   ss: 0018
Process mlock (pid: 9774, stackpage=c29ab000)
Stack: c05e5000 00000000 00000000 00000001 c29aa000 00000004 c010ee04
00000001
       c0313720 c05e5001 00000003 00006223 c0136a98 c05e5005 c29abf84
00000000
       00000001 00000000 c05e5000 00000000 00000000 00000004 00000000
c012badf
Call Trace: [<c010ee04>] [<c0136a98>] [<c012badf>] [<c012bdec>] [<c0108da3>]

Code: 83 78 04 00 0f 84 a2 03 00 00 e9 84 03 00 00 8d 76 00 80 4c

-----------------------------------------------------------

As only that one vc seemed to be affected, I switched to another and
attempted to kill the process. Upon trying ps aux, the new console froze
midway through. I tried at a different console, and it froze at the same
point:

root      9548  0.0  1.6  1848  796 ?        S    18:38   0:00 /USR/SBIN/CRON
mail      9549  0.0  2.1  2148 1008 ?        S    18:38   0:00 /bin/sh -c if [

I tried 'ps 9549', and got the following:

9549 ?        S      0:00 /bin/sh -c   if [ -x /usr/sbin/exim -a -f /etc/exim.c

Realizing the situation was probably hopeless, I rebooted the
machine. However, during the process, it froze at the following line:

Stopping periodic command scheduler: cron


3] crash, cron, mail, exim, pine

4] Linux version 2.4.0 (root@dominia) (gcc version 2.95.3 20001229
(prerelease)) #1 Fri Jan 5 21:43:55 EST 2001

5] Sadly, I was unable to trace the oops.

6] No script known

7] 
7.1] Couldn't find this script

7.2] 
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 5
model           : 2
model name      : Pentium 75 - 200
stepping        : 5
cpu MHz         : 120.275
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : yes
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8
bogomips        : 240.02

7.3]
ppp_deflate            39616   0 (autoclean)
bsd_comp                4208   0 (autoclean)
ppp_async               6288   1 (autoclean)
ppp_generic            12992   3 (autoclean) [ppp_deflate bsd_comp ppp_async]
slhc                    4720   1 (autoclean) [ppp_generic]

7.4]
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial(set)
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(set)
0cf8-0cff : PCI conf1
3000-300f : Intel Corporation 82371FB PIIX IDE [Triton I]
  3000-3007 : ide0
  3008-300f : ide1

00000000-0009fbff : System RAM
0009fc00-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-02ffffff : System RAM
  00100000-001ab0f9 : Kernel code
  001ab0fa-001e79df : Kernel data
f0000000-f01fffff : Trident Microsystems TGUI 9440
f0200000-f020ffff : Trident Microsystems TGUI 9440
ffff0000-ffffffff : reserved

7.5] Couldn't find lspci command.

7.6] No SCSI


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
