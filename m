Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265295AbUBAUVW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 15:21:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265415AbUBAUVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 15:21:21 -0500
Received: from host245-95.pool217223.interbusiness.it ([217.223.95.245]:62848
	"EHLO rc-vaio.rcdiostrouska.com") by vger.kernel.org with ESMTP
	id S265295AbUBAUVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 15:21:16 -0500
Subject: 2.4.24 oops with Slack 9.1
From: Sasa Ostrouska <sasa.ostrouska@volja.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1075666787.1504.15.camel@rc-vaio.rcdiostrouska.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 01 Feb 2004 21:19:48 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi to all of you !!

	I have been looking the logs and I found that oops but do not know much
about what it is. Maybe can be usefull to somebody.

Jan 13 12:55:58 rc-vaio kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000000
Jan 13 12:55:58 rc-vaio kernel:  printing eip:
Jan 13 12:55:58 rc-vaio kernel: f8cae98c
Jan 13 12:55:58 rc-vaio kernel: *pde = 00000000
Jan 13 12:55:58 rc-vaio kernel: Oops: 0000
Jan 13 12:55:58 rc-vaio kernel: CPU:    0
Jan 13 12:55:58 rc-vaio kernel: EIP:    0010:[<f8cae98c>]    Tainted: P
Jan 13 12:55:58 rc-vaio kernel: EFLAGS: 00010246
Jan 13 12:55:58 rc-vaio kernel: eax: 00000001   ebx: cbb11cd4   ecx:
00000000   edx: 00000000
Jan 13 12:55:58 rc-vaio kernel: esi: cbb11cd4   edi: 00000000   ebp:
00000067   esp: cbb11cb4
Jan 13 12:55:58 rc-vaio kernel: ds: 0018   es: 0018   ss: 0018
Jan 13 12:55:58 rc-vaio kernel: Process gnomemeeting (pid: 5161,
stackpage=cbb11000)
Jan 13 12:55:58 rc-vaio kernel: Stack: cbb11cd4 000000f4 00000000
f8cb4b19 00000000 cbb11cd4 00000020 04000001
Jan 13 12:55:58 rc-vaio kernel:        00000001 00000024 00000000
00000000 00000000 000000f4 00000000 00000000
Jan 13 12:55:58 rc-vaio kernel:        00000000 f7010020 c010a238
00000047 f6960000 0000002f 00000000 f8cb2b6e
Jan 13 12:55:58 rc-vaio kernel: Call Trace:    [<f8cb4b19>] [<c010a238>]
[<f8cb2b6e>] [<f8cb18a1>] [<f8cafd57>]
Jan 13 12:55:58 rc-vaio kernel:   [<f8cafcf4>] [<f8cff3bb>] [<f8cff2eb>]
[<f8cea600>] [<f8d10051>] [<f8dc035b>]
Jan 13 12:55:58 rc-vaio kernel:   [<f8dc030c>] [<f8cea608>] [<f8dc0b02>]
[<c0115b9c>] [<c0121b01>] [<c0115928>]
Jan 13 12:55:58 rc-vaio kernel:   [<c01158b0>] [<c0147178>] [<c0122598>]
[<c012ff2a>] [<c0147543>] [<f8cab3c8>]
Jan 13 12:55:58 rc-vaio kernel:   [<c014631e>] [<c0108f13>]
Jan 13 12:55:58 rc-vaio kernel:
Jan 13 12:55:58 rc-vaio kernel: Code: 8b 02 c1 e0 08 83 7a 14 01 8d 7e
04 74 46 83 ec 0c 6a 64 6a
Jan 13 12:56:02 rc-vaio kernel:  <6>hub.c: new USB device 00:03.0-1,
assigned address 3
Jan 13 12:56:02 rc-vaio kernel: USB Quickcam Class ff SubClass ff
idVendor 46d idProduct 850
Jan 13 12:56:02 rc-vaio kernel: USB Quickcam camera found using: $Id:
quickcam.c,v 1.111 2003/01/27 09:41:03 tuukkat Exp $
Jan 13 12:56:02 rc-vaio kernel: quickcam: probe of HDCS1000 sensor = 00
32 id: 08
Jan 13 12:56:02 rc-vaio kernel: quickcam: probe of BP100 sensor = 00 00
id: 64
Jan 13 12:56:02 rc-vaio kernel: quickcam: probe of VV6410 sensor = 19 00
id: 19

I have a Slackware 9.1 standard kernel on my Sony Vaio PCG-GRT816S
notebook. I passed that thru ksymoops-2.4.9 and this is the output.

Jan 13 12:55:58 rc-vaio kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000000
Jan 13 12:55:58 rc-vaio kernel: f8cae98c
Jan 13 12:55:58 rc-vaio kernel: *pde = 00000000
Jan 13 12:55:58 rc-vaio kernel: Oops: 0000
Jan 13 12:55:58 rc-vaio kernel: CPU:    0
Jan 13 12:55:58 rc-vaio kernel: EIP:    0010:[<f8cae98c>]    Tainted: P
Using defaults from ksymoops -t elf32-i386 -a i386
Jan 13 12:55:58 rc-vaio kernel: EFLAGS: 00010246
Jan 13 12:55:58 rc-vaio kernel: eax: 00000001   ebx: cbb11cd4   ecx:
00000000   edx: 00000000
Jan 13 12:55:58 rc-vaio kernel: esi: cbb11cd4   edi: 00000000   ebp:
00000067   esp: cbb11cb4
Jan 13 12:55:58 rc-vaio kernel: ds: 0018   es: 0018   ss: 0018
Jan 13 12:55:58 rc-vaio kernel: Process gnomemeeting (pid: 5161,
stackpage=cbb11000)
Jan 13 12:55:58 rc-vaio kernel: Stack: cbb11cd4 000000f4 00000000
f8cb4b19 00000000 cbb11cd4 00000020 04000001
Jan 13 12:55:58 rc-vaio kernel:        00000001 00000024 00000000
00000000 00000000 000000f4 00000000 00000000
Jan 13 12:55:58 rc-vaio kernel:        00000000 f7010020 c010a238
00000047 f6960000 0000002f 00000000 f8cb2b6e
Jan 13 12:55:58 rc-vaio kernel: Call Trace:    [<f8cb4b19>] [<c010a238>]
[<f8cb2b6e>] [<f8cb18a1>] [<f8cafd57>]
Jan 13 12:55:58 rc-vaio kernel:   [<f8cafcf4>] [<f8cff3bb>] [<f8cff2eb>]
[<f8cea600>] [<f8d10051>] [<f8dc035b>]
Jan 13 12:55:58 rc-vaio kernel:   [<f8dc030c>] [<f8cea608>] [<f8dc0b02>]
[<c0115b9c>] [<c0121b01>] [<c0115928>]
Jan 13 12:55:58 rc-vaio kernel:   [<c01158b0>] [<c0147178>] [<c0122598>]
[<c012ff2a>] [<c0147543>] [<f8cab3c8>]
Jan 13 12:55:58 rc-vaio kernel:   [<c014631e>] [<c0108f13>]
Jan 13 12:55:58 rc-vaio kernel: Code: 8b 02 c1 e0 08 83 7a 14 01 8d 7e
04 74 46 83 ec 0c 6a 64 6a


>>EIP; f8cae98c <[snd-usb-audio].rodata.start+16c/847>   <=====

>>ebx; cbb11cd4 <_end+b724d50/387f00dc>
>>esi; cbb11cd4 <_end+b724d50/387f00dc>
>>esp; cbb11cb4 <_end+b724d30/387f00dc>

Trace; f8cb4b19 <[usbmouse].data.end+1342/1889>
Trace; c010a238 <enable_irq+f8/140>
Trace; f8cb2b6e <[snd-usb-audio].data.end+16a3/1b95>
Trace; f8cb18a1 <[snd-usb-audio].data.end+3d6/1b95>
Trace; f8cafd57 <[snd-usb-audio].rodata.end+cf0/1439>
Trace; f8cafcf4 <[snd-usb-audio].rodata.end+c8d/1439>
Trace; f8cff3bb <[nvidia]nvos_malloc_pages+88/14c>
Trace; f8cff2eb <[nvidia]nvos_probe_devices+1cb/213>
Trace; f8cea600 <[lp].data.end+2e0d/386d>
Trace; f8d10051 <[nvidia]_nv000487rm+ed/17c>
Trace; f8dc035b <[nvidia]_nv002384rm+223/308>
Trace; f8dc030c <[nvidia]_nv002384rm+1d4/308>
Trace; f8cea608 <[lp].data.end+2e15/386d>
Trace; f8dc0b02 <[nvidia]_nv002435rm+1a2/3e0>
Trace; c0115b9c <schedule+1fc/340>
Trace; c0121b01 <dequeue_signal+4d1/4e0>
Trace; c0115928 <schedule_timeout+58/d0>
Trace; c01158b0 <change_page_attr+1e0/200>
Trace; c0147178 <__pollwait+2c8/1100>
Trace; c0122598 <notify_parent+468/ad0>
Trace; c012ff2a <kfree+2a/30>
Trace; c0147543 <__pollwait+693/1100>
Trace; f8cab3c8 <[snd-usb-audio].text.start+4368/77bb>
Trace; c014631e <kill_fasync+23e/440>
Trace; c0108f13 <__up_wakeup+125b/1698>

Code;  f8cae98c <[snd-usb-audio].rodata.start+16c/847>
00000000 <_EIP>:
Code;  f8cae98c <[snd-usb-audio].rodata.start+16c/847>   <=====
   0:   8b 02                     mov    (%edx),%eax   <=====
Code;  f8cae98e <[snd-usb-audio].rodata.start+16e/847>
   2:   c1 e0 08                  shl    $0x8,%eax
Code;  f8cae991 <[snd-usb-audio].rodata.start+171/847>
   5:   83 7a 14 01               cmpl   $0x1,0x14(%edx)
Code;  f8cae995 <[snd-usb-audio].rodata.start+175/847>
   9:   8d 7e 04                  lea    0x4(%esi),%edi
Code;  f8cae998 <[snd-usb-audio].rodata.start+178/847>
   c:   74 46                     je     54 <_EIP+0x54>
Code;  f8cae99a <[snd-usb-audio].rodata.start+17a/847>
   e:   83 ec 0c                  sub    $0xc,%esp
Code;  f8cae99d <[snd-usb-audio].rodata.start+17d/847>
  11:   6a 64                     push   $0x64
Code;  f8cae99f <[snd-usb-audio].rodata.start+17f/847>
  13:   6a 00                     push   $0x0


683 warnings and 38 errors issued.  Results may not be reliable.


If you need any other information you can freely contact me.

Thx 
Saxa

