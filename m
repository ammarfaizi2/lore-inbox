Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267091AbSKSFhB>; Tue, 19 Nov 2002 00:37:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267092AbSKSFhB>; Tue, 19 Nov 2002 00:37:01 -0500
Received: from CPE3236333432363339.cpe.net.cable.rogers.com ([24.114.185.204]:24836
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S267091AbSKSFhA>; Tue, 19 Nov 2002 00:37:00 -0500
From: Shawn Starr <spstarr@sh0n.net>
Organization: sh0n.net
To: linux-kernel@vger.kernel.org
Subject: [PANIC]: 2.5.4x -> .48: Radeon driver sync problem
Date: Tue, 19 Nov 2002 00:44:01 -0500
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200211190044.01726.spstarr@sh0n.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When loading the radeon driver into pre-release X:

XFree86 Version 4.2.99.2 / X Window System
(protocol Version 11, revision 0, vendor release 6600)
Release Date: 14 November 2002

Monitor fails to sync and console is lost. I can still get into the machine 
fine via SSH, is this known? 


>From syslog (cleaned up) (what is PCI GART?)

[drm] AGP 0.99 on Unknown @ 0xf0000000 128MB
[drm] Initialized radeon 1.7.0 20020828 on minor 0
[drm:radeon_do_init_cp] *ERROR* PCI GART not yet supported for Radeon!
[drm:radeon_ati_pcigart_cleanup] *ERROR* no scatter/gather memory!
[drm:radeon_do_cleanup_cp] *ERROR* failed to cleanup PCI GART!
     Unable to handle kernel NULL pointer dereference at virtual address 
0000001c
printing eip
e08d6035
*pde = 1e422067
*pte = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<e08d6035>]    Not tainted
EFLAGS: 00013246
eax: 00000001   ebx: 00000000   ecx: 00000001   edx: fffffff2
esi: 00000000   edi: df1b6180   ebp: e08d77a0   esp: deedbf30
ds: 0068   es: 0068   ss: 0068
Process X (pid: 147, threadinfo=deeda000 task=df0d2140)
Stack: deedbf58 bffffb40 00000008 df12e000 00000000 df12e000 e08d7854 00000000
            bffffb40 00000008 00000001 00000001 df12e000 e08e3618 e08d120c 
de258cfc
            df3b0640 40086442 bffffb40 deeda000 40546440 df3b0640 ffffffe7 
40086442
Call Trace: [<e08d7854>]  [<e08e3618>]  [<e08d120c>][sys_ioctl+234/592]  
[syscall_call+7/11]
Code: 8b 43 1c 83 f8 18 0f 86 b7 00 00 00 8b 13 8b 4b 14 83 e8 18

Can't use ksymoops (busted compile with binutils 2.13.90.0.10 20021010 and  
GCC 3.2.1 20021118 (prerelease))

Can't use kksymoops as its commented out in Kconfig (i386 arch) ;-) and it 
doesnt seem to work uncommented ;(

Shawn.

