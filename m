Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262912AbVAFRL6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262912AbVAFRL6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 12:11:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262915AbVAFRL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 12:11:58 -0500
Received: from hs-grafik.net ([80.237.205.72]:36062 "EHLO
	ds80-237-205-72.dedicated.hosteurope.de") by vger.kernel.org
	with ESMTP id S262912AbVAFRLy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 12:11:54 -0500
From: Alexander Gran <alex@zodiac.dnsalias.org>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.10-mm2
Date: Thu, 6 Jan 2005 18:11:51 +0100
User-Agent: KMail/1.7.1
References: <20050106002240.00ac4611.akpm@osdl.org>
In-Reply-To: <20050106002240.00ac4611.akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Need-Girlfriend: always
X-Ignorant-User: yes
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501061811.51659@zodiac.zodiac.dnsalias.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 6. Januar 2005 09:22 schrieben Sie:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10/2.6.10
>-mm2/
>
> - Various minorish updates and fixes

Booting with 2.6.10-mm2 results in:
Jan  6 18:05:39 t40 kernel: agpgart: Putting AGP V2 device at 0000:01:00.0 
into 4x mode
Jan  6 18:05:39 t40 kernel: Unable to handle kernel NULL pointer dereference 
at virtual address 00000004
Jan  6 18:05:39 t40 kernel:  printing eip:
Jan  6 18:05:39 t40 kernel: c02ae588
Jan  6 18:05:39 t40 kernel: *pde = 1dd40067
Jan  6 18:05:39 t40 kernel: *pte = 00000000
Jan  6 18:05:39 t40 kernel: Oops: 0000 [#1]
Jan  6 18:05:39 t40 kernel: PREEMPT 
Jan  6 18:05:39 t40 kernel: Modules linked in: uhci_hcd irtty_sir sir_dev
Jan  6 18:05:39 t40 kernel: CPU:    0
Jan  6 18:05:39 t40 kernel: EIP:    0060:[<c02ae588>]    Not tainted VLI
Jan  6 18:05:39 t40 kernel: EFLAGS: 00013246   (2.6.10-mm2-orig) 
Jan  6 18:05:39 t40 kernel: EIP is at agp_bind_memory+0x58/0x80
Jan  6 18:05:39 t40 kernel: eax: 00000000   ebx: 00000000   ecx: 00000000   
edx: 00000000
Jan  6 18:05:39 t40 kernel: esi: dd8f5ac0   edi: 00000000   ebp: dd8f5b40   
esp: df2d3f0c
Jan  6 18:05:39 t40 kernel: ds: 007b   es: 007b   ss: 0068
Jan  6 18:05:39 t40 kernel: Process X (pid: 2357, threadinfo=df2d2000 
task=df9ae060)
Jan  6 18:05:39 t40 kernel: Stack: bffffa50 c0246fd4 00000000 c14fb800 
df474ce0 c02ba20f df2d3f24 df2d3f24 
Jan  6 18:05:39 t40 kernel:        00000000 00000004 00000001 00000000 
c14fb800 00000036 c02ba180 c02b5ce5 
Jan  6 18:05:39 t40 kernel:        bffffa50 00000000 df2d3ef0 df2d3f58 
df2d3f58 00000008 00000000 40086436 
Jan  6 18:05:39 t40 kernel: Call Trace:
Jan  6 18:05:39 t40 kernel:  [<c0246fd4>] copy_from_user+0x34/0x70
Jan  6 18:05:39 t40 kernel:  [<c02ba20f>] drm_agp_bind+0x8f/0xe0
Jan  6 18:05:39 t40 kernel:  [<c02ba180>] drm_agp_bind+0x0/0xe0
Jan  6 18:05:39 t40 kernel:  [<c02b5ce5>] drm_ioctl+0xe5/0x1bc
Jan  6 18:05:39 t40 kernel:  [<c0162a9a>] do_ioctl+0x6a/0x80
Jan  6 18:05:39 t40 kernel:  [<c0162cb4>] sys_ioctl+0x74/0x1f0
Jan  6 18:05:39 t40 kernel:  [<c0151c07>] sys_write+0x47/0x80
Jan  6 18:05:39 t40 kernel:  [<c0102f11>] sysenter_past_esp+0x52/0x75
Jan  6 18:05:39 t40 kernel: Code: 8b 4e 20 8b 58 04 89 f0 ff 53 40 85 c0 75 09 
c6 46 28 01 31 c0 89 7e 1c 8b 5c 24 08 8b 74 24 0c 8b 7c 24 10 83 c4 14 c3 8b 
46 08 <8b> 40 04 ff 50 34 c6 46 29 01 eb c4 89 74 24 04 c7 04 24 80 6a 

Y stays black, I need sysrq to reboot. mm1 works fine.
0000:00:01.0 PCI bridge: Intel Corp. 82855PM Processor to AGP Controller (rev 
03)
0000:01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R250 Lf 
[Radeon Mobility 9000 M9] (rev 02)
kernel config at
http://zodiac.dnsalias.org/misc/config-2.6.10-mm2

regards
Alex

-- 
Encrypted Mails welcome.
PGP-Key at http://zodiac.dnsalias.org/misc/pgpkey.asc | Key-ID: 0x6D7DD291
