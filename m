Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269405AbRHGUJJ>; Tue, 7 Aug 2001 16:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269406AbRHGUI7>; Tue, 7 Aug 2001 16:08:59 -0400
Received: from adonis.lbl.gov ([128.3.5.144]:41737 "EHLO adonis.lbl.gov")
	by vger.kernel.org with ESMTP id <S269405AbRHGUIs>;
	Tue, 7 Aug 2001 16:08:48 -0400
To: linux-kernel@vger.kernel.org
Subject: oops with 2.4.8-pre5
From: Alex Romosan <romosan@adonis.lbl.gov>
Date: 07 Aug 2001 13:08:52 -0700
Message-ID: <87bslrfx9n.fsf@adonis.lbl.gov>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i got the following oops with kernel 2.4.8-pre5. i was just logged in
remotely, reading email with gnus and maybe i had just run dselect
(debian package installer):

ksymoops 2.4.1 on i686 2.4.8-pre5.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.8-pre5/ (default)
     -m /boot/System.map-2.4.8-pre5 (specified)

Aug  7 12:47:26 caliban kernel: Unable to handle kernel NULL pointer dereference at virtual address 0000001c
Aug  7 12:47:26 caliban kernel: c01311c9
Aug  7 12:47:26 caliban kernel: *pde = 00000000
Aug  7 12:47:26 caliban kernel: Oops: 0000
Aug  7 12:47:26 caliban kernel: CPU:    0
Aug  7 12:47:26 caliban kernel: EIP:    0010:[sync_old_buffers+41/76]
Aug  7 12:47:26 caliban kernel: EFLAGS: 00010286
Aug  7 12:47:26 caliban kernel: eax: 0009c42b   ebx: cff20000   ecx: 00000200   edx: 00000000
Aug  7 12:47:26 caliban kernel: esi: c0259357   edi: cff2023b   ebp: 0008e000   esp: cff21fe0
Aug  7 12:47:26 caliban kernel: ds: 0018   es: 0018   ss: 0018
Aug  7 12:47:26 caliban kernel: Process kupdated (pid: 7, stackpage=cff21000)
Aug  7 12:47:26 caliban kernel: Stack: c0131425 00010f00 cff39fb0 c02e34a8 c0105454 c02e34a8 00000078 c02d1fc0 
Aug  7 12:47:26 caliban kernel: Call Trace: [kupdate+205/208] [kernel_thread+40/56] 
Aug  7 12:47:26 caliban kernel: Code: 2b 42 1c 79 e2 89 f6 81 3d 80 4f 2c c0 80 4f 2c c0 74 0d 68 
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   2b 42 1c                  sub    0x1c(%edx),%eax
Code;  00000003 Before first symbol
   3:   79 e2                     jns    ffffffe7 <_EIP+0xffffffe7> ffffffe7 <END_OF_CODE+2f4e6e48/????>
Code;  00000005 Before first symbol
   5:   89 f6                     mov    %esi,%esi
Code;  00000007 Before first symbol
   7:   81 3d 80 4f 2c c0 80      cmpl   $0xc02c4f80,0xc02c4f80
Code;  0000000e Before first symbol
   e:   4f 2c c0 
Code;  00000011 Before first symbol
  11:   74 0d                     je     20 <_EIP+0x20> 00000020 Before first symbol
Code;  00000013 Before first symbol
  13:   68 00 00 00 00            push   $0x0

--alex--

-- 
| I believe the moment is at hand when, by a paranoiac and active |
|  advance of the mind, it will be possible (simultaneously with  |
|  automatism and other passive states) to systematize confusion  |
|  and thus to help to discredit completely the world of reality. |
