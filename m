Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276248AbRJKQUU>; Thu, 11 Oct 2001 12:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276278AbRJKQUK>; Thu, 11 Oct 2001 12:20:10 -0400
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:2829 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S276248AbRJKQTy>; Thu, 11 Oct 2001 12:19:54 -0400
Message-ID: <3BC5C6A2.2D8FAE06@delusion.de>
Date: Thu, 11 Oct 2001 18:19:46 +0200
From: "Udo A. Steinberg" <reality@delusion.de>
Organization: Disorganized
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.10-ac11 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>,
        Gerd Knorr <kraxel@bytesex.org>
Subject: [OOPS] Tvmixer again
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

Below is a new decoded oops from the tvmixer code. I've formerly
reported oopses with tvmixer but the bug was never found.

Kernel is 2.4.10-ac11 which comes with bttv 0.7.72.
CONFIG_SOUND_TVMIXER=y

And I can't reproduce it reliably. 

Regards,
Udo.

ksymoops 2.4.1 on i686 2.4.10-ac11.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.10-ac11/ (default)
     -m /boot/System.map-2.4.10-ac11 (specified)

Unable to handle kernel paging request at virtual address 782283e8
782283e8
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<782283e8>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: 782283e8   ebx: cdba9d80   ecx: 00000010   edx: 00000000
esi: c0347ba0   edi: 00000000   ebp: 00000010   esp: c6ed7eec
ds: 0018   es: 0018   ss: 0018
Process kdeinit (pid: 840, stackpage=c6ed7000)
Stack: c01d6766 d599de6c c02d8160 00000000 c01ed318 c2007e40 c9d990c0 00000000
       c9d990c0 c2007e40 cffe92c0 c02d7720 c9d990c0 c2007e40 cffe92c0 c2007e40
       ffffffeb 00000002 c0139c4a c2007e40 c01317ae c2007e40 c9d990c0 c9d990c0
Call Trace: [<c01d6766>] [<d599de6c>] [<c01ed318>] [<c0139c4a>] [<c01317ae>]
   [<c0130829>] [<c0130762>] [<c0130a66>] [<c0106c4b>]
Code:  Bad EIP value.

>>EIP; 782283e8 Before first symbol   <=====
Trace; c01d6766 <tvmixer_open+66/70>
Trace; d599de6c <[bttv]bttv_init_card+3ec/450>
Trace; c01ed318 <soundcore_open+108/190>
Trace; c0139c4a <permission+2a/30>
Trace; c01317ae <chrdev_open+3e/50>
Trace; c0130829 <dentry_open+b9/150>
Trace; c0130762 <filp_open+52/60>
Trace; c0130a66 <sys_open+36/a0>
Trace; c0106c4b <system_call+33/38>
