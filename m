Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262327AbVA0ACX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262327AbVA0ACX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 19:02:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262323AbVA0AA6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 19:00:58 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:41410 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262327AbVAZUSV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 15:18:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=uHE8YeOoET0KWcvMQz8SolNNgC499f8c+Otg5fnTHl8ksxvlZMMar6eoRrFxCmPEp6ZKsa2kSbPYyFuvcZqFEVp5+B7Z0oV9jz0ySrylmD1T7aN59A6yRr0OQZKVHkIzisNeGUmbIxdm6F6uGzLIEY1Mrt+nxHloU8dw3HYr46A=
Message-ID: <74d0deb3050126121856215175@mail.gmail.com>
Date: Wed, 26 Jan 2005 21:18:18 +0100
From: pHilipp Zabel <philipp.zabel@gmail.com>
Reply-To: pHilipp Zabel <philipp.zabel@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: inotify-0.18-rml-4: Oops
In-Reply-To: <1106262771.10477.10.camel@juerg-t40p.bitron.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1106262771.10477.10.camel@juerg-t40p.bitron.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Here 2.6.11-rc2 did this, too. (inotify.patch from 2.6.11-rc2-mm1):

On Fri, 21 Jan 2005 00:12:51 +0100, Juerg Billeter <j@bitron.ch> wrote:
> I reproducibly get the following Oops as soon as I start using inotify
> with gamin and/or beagle. This happens with linux 2.6.10-as1 + inotify
> 0.18-rml-4 on multiple x86 machines.

Unable to handle kernel NULL pointer dereference at virtual address 00000008
printing eip:
c020342f
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
Modules linked in: af_packet radeon drm ipv6 rfcomm hidp l2cap pcmcia
binfmt_misc thermal processor button battery ac ohci1394 ieee1394
yenta_socket rsrc_nonstatic pcmcia_core 3c59x mii snd_intel8x0
snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd
soundcore snd_page_alloc hci_usb bluetooth uhci_hcd usbcore intel_agp
agpgart evdev ide_cd cdrom unix
CPU:    0
EIP:    0060:[<c020342f>]    Not tainted VLI
EFLAGS: 00010287   (2.6.11-rc2)
EIP is at inotify_dev_queue_event+0x6f/0x180
eax: 00000000   ebx: 00000800   ecx: 00000000   edx: e97364a8
esi: e960f308   edi: 00000800   ebp: e960f300   esp: df1d5ec0
ds: 007b   es: 007b   ss: 0068
Process evolution-2.0 (pid: 4276, threadinfo=df1d4000 task=e380c020)
Stack: df1d4000 ffffffff ce4f1e88 00000000 e97364a8 df1d4000 e97364a8 00000000
      00000800 c0203aba 00000000 ce4f1e88 e5a24670 00000000 e5a24670 000081a4
      ce4f1e24 c015b244 ce4f1e88 df1d5f64 ce4f1e24 e5a24670 00000242 c015b9e0
Call Trace:
[<c0203aba>] inotify_inode_queue_event+0x4a/0x80
[<c015b244>] vfs_create+0x94/0xe0
[<c015b9e0>] open_namei+0x570/0x5c0
[<c014c3ed>] filp_open+0x2d/0x60
[<c014c6a0>] get_unused_fd+0x50/0xc0
[<c0159817>] getname+0x67/0xb0
[<c014c7cd>] sys_open+0x3d/0xb0
[<c0102fb7>] syscall_call+0x7/0xb
Code: 0f 87 b6 00 00 00 0f 84 c4 00 00 00 81 fb 00 20 00 00 74 38 81
fb 00 80 00 00 74 30 8b 54 24 10 89 df 8b 42 08 8b 80 0c 01 00 00 <8b>
70 08 21 f7 85 ff 0f 84 84 00 00 00 81 fb 00 80 00 00 74 0c
<6>note: evolution-2.0[4276] exited with preempt_count 1
Unable to handle kernel NULL pointer dereference at virtual address 00000008
c020342f
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c020342f>]    Not tainted VLI
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010287   (2.6.11-rc2)
eax: 00000000   ebx: 00000800   ecx: 00000000   edx: e97364a8
esi: e960f308   edi: 00000800   ebp: e960f300   esp: df1d5ec0
ds: 007b   es: 007b   ss: 0068
Stack: df1d4000 ffffffff ce4f1e88 00000000 e97364a8 df1d4000 e97364a8 00000000
      00000800 c0203aba 00000000 ce4f1e88 e5a24670 00000000 e5a24670 000081a4
      ce4f1e24 c015b244 ce4f1e88 df1d5f64 ce4f1e24 e5a24670 00000242 c015b9e0
Call Trace:
[<c0203aba>] inotify_inode_queue_event+0x4a/0x80
[<c015b244>] vfs_create+0x94/0xe0
[<c015b9e0>] open_namei+0x570/0x5c0
[<c014c3ed>] filp_open+0x2d/0x60
[<c014c6a0>] get_unused_fd+0x50/0xc0
[<c0159817>] getname+0x67/0xb0
[<c014c7cd>] sys_open+0x3d/0xb0
[<c0102fb7>] syscall_call+0x7/0xb
Code: 0f 87 b6 00 00 00 0f 84 c4 00 00 00 81 fb 00 20 00 00 74 38 81
fb 00 80 00 00 74 30 8b 54 24 10 89 df 8b 42 08 8b 80 0c 01 00 00 <8b>
70 08 21 f7 85 ff 0f 84 84 00 00 00 81 fb 00 80 00 00 74 0c

>>EIP; c020342f <inotify_dev_queue_event+6f/180>   <=====

>>edx; e97364a8 <pg0+293a54a8/3fc6d400>
>>esi; e960f308 <pg0+2927e308/3fc6d400>
>>ebp; e960f300 <pg0+2927e300/3fc6d400>
>>esp; df1d5ec0 <pg0+1ee44ec0/3fc6d400>

Trace; c0203aba <inotify_inode_queue_event+4a/80>
Trace; c015b244 <vfs_create+94/e0>
Trace; c015b9e0 <open_namei+570/5c0>
Trace; c014c3ed <filp_open+2d/60>
Trace; c014c6a0 <get_unused_fd+50/c0>
Trace; c0159817 <getname+67/b0>
Trace; c014c7cd <sys_open+3d/b0>
Trace; c0102fb7 <syscall_call+7/b>

This architecture has variable length instructions, decoding before eip
is unreliable, take these instructions with a pinch of salt.

Code;  c0203404 <inotify_dev_queue_event+44/180>
00000000 <_EIP>:
Code;  c0203404 <inotify_dev_queue_event+44/180>
  0:   0f 87 b6 00 00 00         ja     bc <_EIP+0xbc>
Code;  c020340a <inotify_dev_queue_event+4a/180>
  6:   0f 84 c4 00 00 00         je     d0 <_EIP+0xd0>
Code;  c0203410 <inotify_dev_queue_event+50/180>
  c:   81 fb 00 20 00 00         cmp    $0x2000,%ebx
Code;  c0203416 <inotify_dev_queue_event+56/180>
 12:   74 38                     je     4c <_EIP+0x4c>
Code;  c0203418 <inotify_dev_queue_event+58/180>
 14:   81 fb 00 80 00 00         cmp    $0x8000,%ebx
Code;  c020341e <inotify_dev_queue_event+5e/180>
 1a:   74 30                     je     4c <_EIP+0x4c>
Code;  c0203420 <inotify_dev_queue_event+60/180>
 1c:   8b 54 24 10               mov    0x10(%esp),%edx
Code;  c0203424 <inotify_dev_queue_event+64/180>
 20:   89 df                     mov    %ebx,%edi
Code;  c0203426 <inotify_dev_queue_event+66/180>
 22:   8b 42 08                  mov    0x8(%edx),%eax
Code;  c0203429 <inotify_dev_queue_event+69/180>
 25:   8b 80 0c 01 00 00         mov    0x10c(%eax),%eax

This decode from eip onwards should be reliable

Code;  c020342f <inotify_dev_queue_event+6f/180>
00000000 <_EIP>:
Code;  c020342f <inotify_dev_queue_event+6f/180>   <=====
  0:   8b 70 08                  mov    0x8(%eax),%esi   <=====
Code;  c0203432 <inotify_dev_queue_event+72/180>
  3:   21 f7                     and    %esi,%edi
Code;  c0203434 <inotify_dev_queue_event+74/180>
  5:   85 ff                     test   %edi,%edi
Code;  c0203436 <inotify_dev_queue_event+76/180>
  7:   0f 84 84 00 00 00         je     91 <_EIP+0x91>
Code;  c020343c <inotify_dev_queue_event+7c/180>
  d:   81 fb 00 80 00 00         cmp    $0x8000,%ebx
Code;  c0203442 <inotify_dev_queue_event+82/180>
 13:   74 0c                     je     21 <_EIP+0x21>

greetings
pHilipp
