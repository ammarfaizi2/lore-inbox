Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318750AbSICKuc>; Tue, 3 Sep 2002 06:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318751AbSICKuc>; Tue, 3 Sep 2002 06:50:32 -0400
Received: from WARSL402PIP7.highway.telekom.at ([195.3.96.94]:32280 "EHLO
	SSP1NO65.highway.telekom.at") by vger.kernel.org with ESMTP
	id <S318750AbSICKub>; Tue, 3 Sep 2002 06:50:31 -0400
To: linux-kernel@vger.kernel.org
Subject: Kernel Oops after X-Server shutdown
Message-ID: <1031050498.3d7495028d2e6@webmail.jet2web.at>
Date: Tue, 03 Sep 2002 12:54:58 +0200 (DFT)
From: Thomas Koller <kt@aon.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.3
X-Originating-IP: 193.154.25.249
X-Forwarded-For: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

shutting down the x-server with dri support on a i830M graficcard lets the 
kernel produce an oops and left the screen black.

Aug 31 18:16:45 mobile kernel:  printing eip:
Aug 31 18:16:45 mobile kernel: c0124e20
Aug 31 18:16:45 mobile kernel: Oops: 0000
Aug 31 18:16:45 mobile kernel: CPU:    0
Aug 31 18:16:45 mobile kernel: EIP:    0010:[unlock_page+4/100]    Not 
tainted
Aug 31 18:16:45 mobile kernel: EIP:    0010:[<c0124e20>]    Not tainted
Aug 31 18:16:45 mobile kernel: EFLAGS: 00013246
Aug 31 18:16:45 mobile kernel: eax: 01000000   ebx: 01000000   ecx: 
c1510ba8   edx: 00000000
Aug 31 18:16:45 mobile kernel: esi: dd789000   edi: dea37800   ebp: 
00000000   esp: de5d3ee4
Aug 31 18:16:45 mobile kernel: ds: 0018   es: 0018   ss: 0018
Aug 31 18:16:45 mobile kernel: Process X (pid: 4077, stackpage=de5d3000)
Aug 31 18:16:45 mobile kernel: Stack: c1510ba8 dd789000 e0934d9f c1510ba8 
de6a88c0 dda3e000 e0934def dea37800
Aug 31 18:16:45 mobile kernel:        dd789000 de5d3f34 bffff924 de5d3f78 
e09353da dea37800 00000040 dea37800
Aug 31 18:16:45 mobile kernel:        df65ed60 40446440 00000000 dea37800 
00000002 00000000 00000000 00000000
Aug 31 18:16:45 mobile kernel: Call Trace:    
[hid:__insmod_hid_S.bss_L96+672703/77201149] [hid:__insmod_hid_S.bss_L96+67
Aug 31 18:16:45 mobile kernel: Call Trace:    [<e0934d9f>] [<e0934def>] 
[<e09353da>] [<e0930de2>] [<c013cf87>]
Aug 31 18:16:45 mobile kernel:   [system_call+51/56]
Aug 31 18:16:45 mobile kernel:   [<c010857b>]
Aug 31 18:16:45 mobile kernel:
Aug 31 18:16:45 mobile kernel: Code: 0f b6 43 1b 8b 14 85 1c c5 31 c0 69 c3 
01 00 37 9e 8b 8a 98


without dri support there are no problems with i830M graficcards.

Kernel:     	    	2.4.19
KernelPatches: 

DRI Modules http://www.xfree86.org/~alanh/linux-drm-4.2.0-
kernelsource.tar.gz

ACPI-Patches (acpi.sourceforge.net) acpi-20020821-2.4.19

X-Server: Xfree86 4.2.0

Hardware: TravelMate 621LV

Is there a chance to get Xfree 4.2.0 working with DRI on that hardware? 
maybe this is a bug in the kernel.

best regards
thomas


-------------------------------------------
Versendet durch AonWebmail (www.jet2mail.at)
