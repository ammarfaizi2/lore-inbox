Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750974AbWGVRY1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974AbWGVRY1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 13:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750980AbWGVRY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 13:24:27 -0400
Received: from ptb-relay03.plus.net ([212.159.14.214]:23230 "EHLO
	ptb-relay03.plus.net") by vger.kernel.org with ESMTP
	id S1750974AbWGVRY0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 13:24:26 -0400
Message-ID: <44C25F49.3010803@mauve.plus.com>
Date: Sat, 22 Jul 2006 18:24:25 +0100
From: Ian Stirling <tandra@mauve.plus.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: USB snd-usb-audio oops
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This has hit me yesterday too - maybe, but I diddn't get it logged - as 
it just locked.
With enforce bandwidth on and off (today and yesterday)
Otherwise the config is identical to the one I posted several messages ago.

I was simply trying to start mplayer - to play some tunes after a lot of 
unplugging to test things.


BUG: unable to handle kernel paging request at virtual address 1b154000
  printing eip:
c0283629
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
Modules linked in: zd1211 toshiba_acpi aes_i586 rd snd_usb_audio 
snd_usb_lib snd_hwdep usbhid uhci_hcd ehci_hcd
ohci_hcd pcmcia firmware_class yenta_socket rsrc_nonstatic pcmcia_core 
eepro100 twofish tea sha512 sha256 sha1 s
erpent michael_mic md5 md4 khazad des deflate zlib_deflate zlib_inflate 
crypto_null cast6 cast5 blowfish arc4 cr
yptoloop loop sd_mod usb_storage libusual usbcore snd_es1968 
snd_ac97_codec snd_ac97_bus snd_mpu401_uart snd_raw
midi
CPU:    0
EIP:    0060:[<c0283629>]    Not tainted VLI
EFLAGS: 00210246   (2.6.17laptop-3110-firstcut #7)
EIP is at snd_ctl_release+0xb2/0x161
eax: c2d42b60   ebx: 00200246   ecx: 00000000   edx: 1b154000
esi: c2d42a00   edi: c7ec28a0   ebp: c4f20960   esp: c5fbff4c
ds: 007b   es: 007b   ss: 0068
Process mplayer (pid: 16279, threadinfo=c5fbe000 task=c7855a70)
Stack: 00000010 c4f20960 c2919338 c51e96d4 c015110d c2919338 c4f20960 
c7fcb220
        c4f20960 c7f438e0 00000000 c4f20960 c014fadf c4f20960 c7f438e0 
c4f20960
        c7f438e0 00000004 c7f438e0 c5fbe000 c014fb64 c4f20960 c7f438e0 
00000004
Call Trace:
  <c015110d> __fput+0x190/0x1a3  <c014fadf> filp_close+0x36/0x57
  <c014fb64> sys_close+0x64/0x99  <c0102d4f> syscall_call+0x7/0xb
Code: 8d 74 26 00 8d 86 60 01 00 00 39 c2 74 2d 31 c9 3b 4a 48 73 14 89 
d0 39 78 64 0f 84 a4 00 00 00 41 83 c0 0
c 3b 4a 48 72 ee 8b 12 <8b> 02 8d 74 26 00 8d 86 60 01 00 00 39 c2 75 d3 
8d 86 4c 01 00
EIP: [<c0283629>] snd_ctl_release+0xb2/0x161 SS:ESP 0068:c5fbff4c
