Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285461AbRLGLKO>; Fri, 7 Dec 2001 06:10:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285455AbRLGLJz>; Fri, 7 Dec 2001 06:09:55 -0500
Received: from grobbebol.xs4all.nl ([194.109.248.218]:5965 "EHLO
	grobbebol.xs4all.nl") by vger.kernel.org with ESMTP
	id <S285460AbRLGLJm>; Fri, 7 Dec 2001 06:09:42 -0500
Date: Fri, 7 Dec 2001 11:08:46 +0000
From: "Roeland Th. Jansen" <roel@grobbebol.xs4all.nl>
To: linux-kernel@vger.kernel.org
Cc: mdharm-usb@one-eyed-alien.net
Subject: 2.4.14 USB oops
Message-ID: <20011207110846.B1681@grobbebol.xs4all.nl>
In-Reply-To: <20011205133551.A4770@grobbebol.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011205133551.A4770@grobbebol.xs4all.nl>
User-Agent: Mutt/1.3.22.1i
X-OS: Linux grobbebol 2.4.14 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ksymoops 2.4.2 on i686 2.4.14.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.14/ (default)
     -m /boot/System.map-2.4.14 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Oops: 0000
CPU:    0
EIP:    0010:[<f0a79652>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: e4233000   ecx: 00000000   edx: 00000010
esi: dfd97fcc   edi: dfd97fec   ebp: f0a85497   esp: dfd97f7c
ds: 0018   es: 0018   ss: 0018
Process usb-storage-0 (pid: 2877, stackpage=dfd97000)
Stack: e4233000 f0a85711 dfd97ff0 e4233004 c02f7747 00000246 00000024
e4233000
       f0a79a24 e4233000 dfd97fcc 00000024 f0a85720 00000100 e006fdc8
e4233000
       e4233000 e4233194 e4233180 00000001 02028000 0000001f 696a7546
6d6c6966
Call Trace: [<f0a85711>] [<f0a79a24>] [<f0a85720>] [<c0105594>]
[<f0a8d3ac>]
Code: 0f b7 80 cc 00 00 00 66 c1 e8 0c 0c 30 88 46 20 8b 43 18 8a

>>EIP; f0a79652 <[usb-storage]fill_inquiry_response+e2/274>   <=====
Trace; f0a85710 <[usb-storage]__module_usb_device_size+660/828e>
Trace; f0a79a24 <[usb-storage]usb_stor_control_thread+240/3fc>
Trace; f0a85720 <[usb-storage]__module_usb_device_size+670/828e>
Trace; c0105594 <kernel_thread+28/38>
Trace; f0a8d3ac <[usb-storage]usb_stor_sense_notready+0/14>
Code;  f0a79652 <[usb-storage]fill_inquiry_response+e2/274>
00000000 <_EIP>:
Code;  f0a79652 <[usb-storage]fill_inquiry_response+e2/274>   <=====
   0:   0f b7 80 cc 00 00 00      movzwl 0xcc(%eax),%eax   <=====
Code;  f0a79658 <[usb-storage]fill_inquiry_response+e8/274>
   7:   66 c1 e8 0c               shr    $0xc,%ax
Code;  f0a7965c <[usb-storage]fill_inquiry_response+ec/274>
   b:   0c 30                     or     $0x30,%al
Code;  f0a7965e <[usb-storage]fill_inquiry_response+ee/274>
   d:   88 46 20                  mov    %al,0x20(%esi)
Code;  f0a79662 <[usb-storage]fill_inquiry_response+f2/274>
  10:   8b 43 18                  mov    0x18(%ebx),%eax
Code;  f0a79664 <[usb-storage]fill_inquiry_response+f4/274>
  13:   8a 00                     mov    (%eax),%al


1 warning issued.  Results may not be reliable.
-- 
Grobbebol's Home                        |  Don't give in to spammers.   -o)
http://www.xs4all.nl/~bengel            | Use your real e-mail address   /\
Linux 2.4.14 (noapic) SMP 466MHz/768 MB |        on Usenet.             _\_v  
