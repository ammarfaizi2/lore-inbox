Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262539AbUKQVAT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262539AbUKQVAT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 16:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262536AbUKQUz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 15:55:59 -0500
Received: from v6.netlin.pl ([62.121.136.6]:27653 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S262537AbUKQUzC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 15:55:02 -0500
Message-ID: <419BBA34.1080304@kde.org.uk>
Date: Wed, 17 Nov 2004 21:53:08 +0100
From: Grzegorz Piotr Jaskiewicz <gj@kde.org.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc2-mm1
References: <20041116014213.2128aca9.akpm@osdl.org>
In-Reply-To: <20041116014213.2128aca9.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

it OOpses here:

  <1>Unable to handle kernel NULL pointer dereference at virtual address 
0000003c
  printing eip:
c021bab5
*pde = 00000000
Oops: 0000 [#9]
Modules linked in: af_packet ipv6 binfmt_misc apm pcmcia ohci_hcd 
ehci_hcd i2c_pi
ix4 usblp uhci_hcd usbcore snd_cs46xx snd_rawmidi snd_seq_device 
snd_ac97_codec 3c59x mii yenta_socket pcmcia_core in
tel_agp agpgart parport_pc parport 8250_pnp 8250 serial_core irtty_sir 
sir_dev irda evdev snd_pcm_oss snd_pcm snd_tim
er snd_page_alloc snd_mixer_oss snd nvram rtc
CPU:    0
EIP:    0060:[get_nonexclusive_access+21/64]    Not tainted VLI
EFLAGS: 00210286   (2.6.10-rc2-mm1)
EIP is at get_nonexclusive_access+0x15/0x40
eax: 00000000   ebx: da77a710   ecx: da085ea0   edx: da77a6b8
esi: da77a6e0   edi: da77a6b8   ebp: da085e50   esp: da085e50
ds: 007b   es: 007b   ss: 0068
Process kreadconfig (pid: 3964, threadinfo=da084000 task=db094aa0)
Stack: da085e74 c021a79a da77a6b8 0000000f 00000000 dec1c000 c021a760 
d9d857bc
        00000000 da085eb0 c014613c da55bddc b75ef000 da085ea0 da085eb0 
da085e9c
        c01d7fbe da085eb0 00000004 da77a7b0 00000001 da08db74 df799280 
b75ef000
Call Trace:
  [show_stack+127/160] show_stack+0x7f/0xa0
  [show_registers+342/464] show_registers+0x156/0x1d0
  [die+200/336] die+0xc8/0x150
  [do_page_fault+1186/1754] do_page_fault+0x4a2/0x6da
  [error_code+43/48] error_code+0x2b/0x30
  [unix_file_filemap_nopage+58/128] unix_file_filemap_nopage+0x3a/0x80
  [do_no_page+156/656] do_no_page+0x9c/0x290
  [handle_mm_fault+278/384] handle_mm_fault+0x116/0x180
  [do_page_fault+576/1754] do_page_fault+0x240/0x6da
  [error_code+43/48] error_code+0x2b/0x30
Code: 00 0f c1 10 0f 85 f4 10 00 00 5d c3 8d 76 00 8d bc 27 00 00 00 00 
55 b8 00
e0 ff ff 89 e5 21 e0 8b 00 8b 55 08 8b 80 b8 04 00 00 <8b> 40 3c 8b 48 
08 85 c9 75 0c 89 d0 ff 00 0f 88 d3 10 00 00 5d

and more, when KDE starts. My account is on reiser4 fs, if that matters.

--
GJ

-rwxr-xr-x  1 root  5.89824e37 Oct 22  1990 /usr/bin/emacs
