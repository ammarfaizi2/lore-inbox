Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267281AbUBSOSc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 09:18:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267284AbUBSOSc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 09:18:32 -0500
Received: from smartmail.hjemme.no ([213.188.18.138]:1453 "EHLO
	smartmail.hjemme.no") by vger.kernel.org with ESMTP id S267281AbUBSOST
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 09:18:19 -0500
Date: Thu, 19 Feb 2004 16:22:34 +0100
From: Andreas Mikkelborg <andreas.mikkelborg@hjemme.no>
To: linux-kernel@vger.kernel.org
Subject: Bluez oops in 2.6.3-rc4
Message-Id: <20040219162234.6fee88fc.andreas.mikkelborg@hjemme.no>
Organization: na
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The oops occured when I started obexserver and tried to transfer a file from my mobile phone.
The first files went ok, but then it oopsed, now it seems I can't recreate it.


Oops :
kernel BUG at include/linux/module.h:302!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c81df9f3>]    Not tainted
EFLAGS: 00010246
EIP is at rfcomm_session_add+0xb3/0xc0 [rfcomm]
eax: 00000000   ebx: c5b0c660   ecx: 00000000   edx: c77e9c00
esi: 00000002   edi: c5b0c68c   ebp: 00000000   esp: c6419f74
ds: 007b   es: 007b   ss: 0068
Process krfcommd (pid: 3511, threadinfo=c6418000 task=c646cd60)
Stack: c81e7840 000000d0 c77df800 c81d1360 c672c1e0 c589be40 c65fb420 c81e1ae5 
       c589be40 00000002 00000800 00000006 c65fb4c4 c6418000 c65fb4c4 c63e4420 
       c6418000 c81e7550 0003001f c6418000 00000000 00000000 00000000 c81e1d69 
Call Trace:
 [<c81e1ae5>] rfcomm_worker+0x4f5/0x560 [rfcomm]
 [<c81e1d69>] rfcomm_run+0x69/0x80 [rfcomm]
 [<c81e1d00>] rfcomm_run+0x0/0x80 [rfcomm]
 [<c01070d9>] kernel_thread_helper+0x5/0xc

Code: 0f 0b 2e 01 fb 4e 1e c8 eb ca 8d 76 00 83 ec 10 89 5c 24 08 

lsmod :
Module                  Size  Used by
rfcomm                 35160  0 
l2cap                  21600  7 rfcomm
hci_usb                 9504  2 
bluetooth              43972  7 rfcomm,l2cap,hci_usb
ohci_hcd               17024  0 
ipv6                  229312  10 
3c589_cs               11268  1 
ds                     11552  3 3c589_cs
yenta_socket           14560  1 
pcmcia_core            62016  3 3c589_cs,ds,yenta_socket
snd_ali5451            21124  0 
snd_ac97_codec         60868  1 snd_ali5451
snd_pcm                88096  1 snd_ali5451
snd_page_alloc          9412  1 snd_pcm
snd_timer              22080  1 snd_pcm
snd                    42916  4 snd_ali5451,snd_ac97_codec,snd_pcm,snd_timer
rtc                    10632  0 
usbcore                92596  4 hci_usb,ohci_hcd
8250                   18720  0 
serial_core            19840  1 8250
ide_cd                 38592  0 
cdrom                  36896  1 ide_cd

-- 
Sandalwood, tagara, lotus, jasmine: above all these kinds of fragrance, the perfume of virtue is by far the best.
