Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129030AbQKDXWs>; Sat, 4 Nov 2000 18:22:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129040AbQKDXWj>; Sat, 4 Nov 2000 18:22:39 -0500
Received: from paloma12.e0k.nbg-hannover.de ([62.159.219.12]:15234 "HELO
	paloma12.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S129030AbQKDXWd>; Sat, 4 Nov 2000 18:22:33 -0500
From: Dieter Nützel <Dieter.Nuetzel@hamburg.de>
Organization: DN
Date: Sun, 5 Nov 2000 00:22:39 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="iso-8859-1"
To: "Rik Faith" <rik@valinux.com>
Cc: "Linux Kernel List" <linux-kernel@vger.kernel.org>,
        "Dri-devel" <Dri-devel@lists.sourceforge.net>
Subject: 2.4.0.-test10: kernel oops - mount / tdfx.o related
MIME-Version: 1.0
Message-Id: <00110500223900.07516@SunWave1>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rik,

I've got a kernel oops with the 'latest' linux kernel and the DRI.
CD mounting was involved.

ksymoops 2.3.4 on i686 2.4.0-test10.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0-test10/ (default)
     -m /boot/System.map (specified)

Nov  4 18:40:05 SunWave1 kernel: Unable to handle kernel paging request at 
virtual address d0c353f3 
Nov  4 18:40:05 SunWave1 kernel: d0c353f3 
Nov  4 18:40:05 SunWave1 kernel: *pde = 0c291063 
Nov  4 18:40:05 SunWave1 kernel: Oops: 0000 
Nov  4 18:40:05 SunWave1 kernel: CPU:    0 
Nov  4 18:40:05 SunWave1 kernel: EIP:    0010:[<d0c353f3>] 
Using defaults from ksymoops -t elf32-i386 -a i386
Nov  4 18:40:05 SunWave1 kernel: EFLAGS: 00010296 
Nov  4 18:40:05 SunWave1 kernel: eax: c147a2a8   ebx: cd3c3bd4   ecx: 
00000001   edx: c147a280 
Nov  4 18:40:05 SunWave1 kernel: esi: cc6e2214   edi: cbc3dd84   ebp: 
cd3c3b80   esp: cbc3dd34 
Nov  4 18:40:05 SunWave1 kernel: ds: 0018   es: 0018   ss: 0018 
Nov  4 18:40:05 SunWave1 kernel: Process mount (pid: 325, stackpage=cbc3d000) 
Nov  4 18:40:05 SunWave1 kernel: Stack: cd3c3b80 cbc3dd84 00000000 00000000 
00000bb8 00000003 00000002 cc6e2214  
Nov  4 18:40:05 SunWave1 kernel:        d0c36d20 00000000 00000000 00000000 
c147a280 d0c35b12 00000000 cbc3dd84  
Nov  4 18:40:05 SunWave1 kernel:        00000000 00000000 00000000 00000003 
0000001b 00000003 0000292e d0c2b3e2  
Nov  4 18:40:05 SunWave1 kernel: Call Trace: [<d0c36d20>] [<d0c35b12>] 
[<d0c2b3e2>] [bread+24/112] [<d0c2b2f8>] [blkdev_get+262/336] 
[do_no_page+168/272]  
Nov  4 18:40:05 SunWave1 kernel: Code:  Bad EIP value. 

>>EIP; d0c353f3 <[tdfx].bss.end+3f538/60041a5>   <=====
Trace; d0c36d20 <[tdfx].bss.end+40e65/60041a5>
Trace; d0c35b12 <[tdfx].bss.end+3fc57/60041a5>
Trace; d0c2b3e2 <[tdfx].bss.end+35527/60041a5>

Thanks,
	Dieter
-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
Cognitive Systems Group
Vogt-Kölln-Straße 30
D-22527 Hamburg, Germany

email: nuetzel@kogs.informatik.uni-hamburg.de
@home: Dieter.Nuetzel@hamburg.de
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
