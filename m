Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281843AbRLQSZ2>; Mon, 17 Dec 2001 13:25:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281735AbRLQSZS>; Mon, 17 Dec 2001 13:25:18 -0500
Received: from grunt.ksu.ksu.edu ([129.130.12.17]:58842 "EHLO
	mailhub.cns.ksu.edu") by vger.kernel.org with ESMTP
	id <S281843AbRLQSZF>; Mon, 17 Dec 2001 13:25:05 -0500
Date: Mon, 17 Dec 2001 12:25:03 -0600
From: Joseph Pingenot <jap3003@ksu.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: USB [Toshiba PCX1100U CableModem] panic
Message-ID: <20011217122502.G16465@ksu.edu>
Reply-To: jap3003+response@ksu.edu
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20011217114322.D16465@ksu.edu> <20011217095547.E31818@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: RE: [Re: USB [Toshiba PCX1100U CableModem] panic]
X-School: Kansas State University
X-vi-or-emacs: vi
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Greg KH on Monday, 17 December, 2001:
>Can you run that oops through ksymoops?

My apologies.  I should have done this originally [is my first bugposting,
  if that is any consolation]

ksymoops 2.4.3 on i586 2.4.16.  Options used
     -v /usr/local/src/kernel/linux-2.4.16/vmlinux (specified)
     -k /var/adm/ksymoops/20011217031414.ksyms (specified)
     -l /var/adm/ksymoops/20011217031414.modules (specified)
     -o /lib/modules/2.4.16/ (default)
     -m /boot/System.map-2.4.16-b (specified)

Reading Oops report from the terminal
kernel BUG at sched.c 551!
invalid operand: 0000
CPU: 0
EIP: 0010:[<c01125b0>]  Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 0000001b ebx: c9199de4 ecx: c029ad60 edx: 00001ce1
esi: 0000ccab edi: 00000000 ebp: c9199dd0 esp: c9199da4
ds: 0018   es: 0018   ss: 0018
Process pump (pid: 374, stackpage=c9199000)
Stack: c0248916 00000227 c9199de4 0000ccab 00000000 c01f404f c02b2000 c9199e1c
       00000000 c9198000 00000202 c9199df8 c011251a c9199de4 c9198000 c930c600
       c02f687c c02f687c 0000ccab c9198000 c011245c c9198000 c01ec667 c930c600
Call Trace: [<c01f404f>] [<c011251a>] [<c011245c>] [<c01ec667>] [<c01ec782>]
   [<c01ec80f>] [<ca868787>] [<c02003ae>] [<c02003c4>] [<c01fe9fd>] [<c01ff833>]
   [<c02256a1>] [<c0227417>] [<c01f8e26>] [<c013a0c6>] [<c0106b33>]
Code: 0f 0b 83 c4 08 0b 4d f4 c1 e1 05 81 c1 40 b5 2e c0 89 4d fc

>>EIP; c01125b0 <schedule+6c/31c>   <=====
Trace; c01f404e <sohci_submit_urb+4f6/510>
Trace; c011251a <schedule_timeout+72/90>
Trace; c011245c <process_timeout+0/4c>
Trace; c01ec666 <usb_start_wait_urb+ee/1ac>
Trace; c01ec782 <usb_internal_control_msg+5e/74>
Trace; c01ec80e <usb_control_msg+76/98>
Trace; ca868786 <[CDCEther]CDCEther_set_multicast+12e/184>
Trace; c02003ae <__dev_mc_upload+1e/24>
Trace; c02003c4 <dev_mc_upload+10/30>
Trace; c01fe9fc <dev_open+84/a0>
Trace; c01ff832 <dev_change_flags+4e/fc>
Trace; c02256a0 <devinet_ioctl+314/664>
Trace; c0227416 <inet_ioctl+132/17c>
Trace; c01f8e26 <sock_ioctl+1e/24>
Trace; c013a0c6 <sys_ioctl+16a/184>
Trace; c0106b32 <system_call+32/40>
Code;  c01125b0 <schedule+6c/31c>
00000000 <_EIP>:
Code;  c01125b0 <schedule+6c/31c>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01125b2 <schedule+6e/31c>
   2:   83 c4 08                  add    $0x8,%esp
Code;  c01125b4 <schedule+70/31c>
   5:   0b 4d f4                  or     0xfffffff4(%ebp),%ecx
Code;  c01125b8 <schedule+74/31c>
   8:   c1 e1 05                  shl    $0x5,%ecx
Code;  c01125ba <schedule+76/31c>
   b:   81 c1 40 b5 2e c0         add    $0xc02eb540,%ecx
Code;  c01125c0 <schedule+7c/31c>
  11:   89 4d fc                  mov    %ecx,0xfffffffc(%ebp)

 <0>Kernel panic: Aiee, killing interrupt handler!

-- 
Joseph=========<Free Software User and Developer>===========jap3003@ksu.edu
"If you really want to toggle [Internet Explorer] into secure mode, you
  just need to click the little 'X" in the top right corner of the window."
     --User dsb3 on www.slashdot.org.       [Use Mozilla! www.mozilla.org.]
