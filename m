Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261433AbULAUOP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261433AbULAUOP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 15:14:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261434AbULAUOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 15:14:14 -0500
Received: from [64.76.47.59] ([64.76.47.59]:43152 "HELO
	multivac.xnetcuyo.com.ar") by vger.kernel.org with SMTP
	id S261433AbULAUOE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 15:14:04 -0500
Message-ID: <41AE2608.8050004@xnetcuyo.com.ar>
Date: Wed, 01 Dec 2004 17:14:00 -0300
From: Cristian Gimenez <cgimenez@xnetcuyo.com.ar>
Organization: XNET CUYO S.A.
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: REISERFS BUG 2.8.1
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

debian kernel image 2.8.1  (686) doing cp -a

REISERFS: panic (device hdb1): green-9011: Unexpected key type [4950 
4975 0xc0001 UNKNOWN]

------------[ cut here ]------------
kernel BUG at fs/reiserfs/prints.c:362!
invalid operand: 0000 [#1]
PREEMPT
Modules linked in: ide_cd cdrom snd_pcm_oss snd_mixer_oss i830 lp nfsd 
exportfs lockd sunrpc ipv6 e100 eepro100 8139cp snd_intel8x0 
snd_ac97_codec snd_pcm snd_timer snd_page_alloc gameport snd_mpu401_uart 
snd_rawmidi snd_seq_device snd soundcore pciehp shpchp pci_hotplug 
ehci_hcd uhci_hcd usbcore intel_agp agpgart parport_pc parport ext3 jbd 
mbcache dm_mod evdev mousedev capability commoncap tsdev i810 3c59x 
8139too mii crc32 psmouse rtc reiserfs ide_generic ide_disk piix 
ide_core unix font vesafb cfbcopyarea cfbimgblt cfbfillrect
CPU:    0
EIP:    0060:[<e011b212>]    Not tainted
EFLAGS: 00010286   (2.6.8-1-686)
EIP is at reiserfs_panic+0x52/0x80 [reiserfs]
eax: 0000005f   ebx: e0134a73   ecx: c02bc3b8   edx: c02bc3b8
esi: df028200   edi: df02832c   ebp: d043b0f0   esp: c0645cb0
ds: 007b   es: 007b   ss: 0068
Process cp (pid: 29305, threadinfo=c0644000 task=df080c50)
Stack: e0131300 df02832c e013de20 00000fd0 e012ffc0 00000000 e0111498 
df028200
        e012ffc0 c0645e20 00000020 0000000f 00000003 c0645e20 df028200 
e0122003
        d043b2d0 df028200 c0645dd0 0000000c 00000001 ce6f5000 000003f4 
00000019
Call Trace:
  [<e0111498>] reiserfs_allocate_blocks_for_region+0xe68/0x1620 [reiserfs]
  [<e0122003>] search_for_position_by_key+0x1d3/0x400 [reiserfs]
  [<e0120883>] pathrelse+0x23/0x40 [reiserfs]
  [<e01128e6>] reiserfs_prepare_file_region_for_write+0x396/0x9e0 [reiserfs]
  [<e0113492>] reiserfs_file_write+0x562/0x7c0 [reiserfs]
  [<c0136a52>] __generic_file_aio_read+0x202/0x240
  [<c01544ad>] vfs_write+0xed/0x160
  [<c01545f1>] sys_write+0x51/0x80
  [<c010603b>] syscall_call+0x7/0xb
Code: 0f 0b 6a 01 83 4a 13 e0 c7 04 24 40 13 13 e0 85 f6 be 20 de


-- 


   Cristian Gimenez

   Tecnologia  y  Desarrollo
   XNET CUYO S.A.
   Soluciones Transaccionales
   Rioja 979 - 5500 - Mendoza
   Tel/Fax: +54  261-425-2788
   http://xnet.logicalis.com/

