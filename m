Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264649AbSJOS61>; Tue, 15 Oct 2002 14:58:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263319AbSJOS61>; Tue, 15 Oct 2002 14:58:27 -0400
Received: from [206.47.199.165] ([206.47.199.165]:54519 "EHLO
	simmts7-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S264677AbSJOS4Z>; Tue, 15 Oct 2002 14:56:25 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: 2.5.x opps stopping serial
Date: Fri, 11 Oct 2002 08:45:24 -0400
User-Agent: KMail/1.4.3
References: <3DA683F4.944DFC11@digeo.com>
In-Reply-To: <3DA683F4.944DFC11@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210110845.24687.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have been seeing this during shutdown ever since I started using 2.5.  Figured
I really should report it...   There are three serial ports.  One for a serial console,
the second for a backUPS ups, the third for a (real) modem.  Dist is debian sid.

Saving state of known serial devices... Unable to handle kernel NULL pointer dereference at virtual addres
s 00000114
 printing eip:
c0191f73
*pde = 00000000
Oops: 0000
af_packet snd-seq-midi snd-seq-oss snd-seq-midi-event snd-seq snd-pcm-oss snd-mixer-oss snd-cs46xx snd-pcm
 snd-timer snd-rawmidi snd-seq-device snd-ac97-codec snd soundcore gameport softdog matroxfb_base matroxfb
_g450 matroxfb_DAC1064 g450_pll matroxfb_accel fbcon-cfb24 fbcon-cfb8 fbcon-cfb32 fbcon-cfb16 matroxfb_mis
c mga agpgart pppoe pppox ipchains msdos fat sd_mod floppy dummy bsd_comp ppp_generic slhc parport_pc lp p
arport ipip smbfs nls_cp850 nls_cp437 nfs lockd sunrpc binfmt_aout autofs4 cdrom via-rhine mii tulip crc32
 usb-storage scsi_mod pl2303 usbserial hid
CPU:    0
EIP:    0060:[<c0191f73>]    Not tainted
EFLAGS: 00010246
EIP is at uart_block_til_ready+0x15b/0x1a4
eax: 00000000   ebx: d9cd4000   ecx: dffe381c   edx: c17a5114
esi: d9cd5e84   edi: 00000202   ebp: c17a50c0   esp: d9cd5e58
ds: 0068   es: 0068   ss: 0068
Process bkupsd (pid: 1096, threadinfo=d9cd4000 task=dc75a160)
Stack: c0284800 d9b75000 c17a50c0 00000000 c0356804 dffe381c 00000000 dc75a160
       c0110868 00000000 00000000 00000000 dc75a160 c0110868 c17a5114 c17a5114
       c0192269 d9e64d20 c17a50c0 00000000 00000100 00000000 dec0b3b4 d9cd4000
Call Trace:
 [<c0110868>] default_wake_function+0x0/0x2c
 [<c0110868>] default_wake_function+0x0/0x2c
 [<c0192269>] uart_open+0x1d9/0x220
 [<c0199d72>] tty_open+0x1e6/0x39c
 [<c0199da3>] tty_open+0x217/0x39c
 [<c0139759>] get_chrfops+0xa1/0x164
 [<c0139a03>] chrdev_open+0x5b/0x94
 [<c01382f9>] dentry_open+0xb9/0x16c
 [<c0138237>] filp_open+0x43/0x4c
 [<c01385d8>] sys_open+0x34/0x70
 [<c0106ef7>] syscall_call+0x7/0xb

Code: f6 80 14 01 00 00 02 75 34 8b 44 24 44 50 e8 6a 6b 00 00 83
 backing up serial.conf done.

Ideas?
Ed Tomlinson

