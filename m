Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267785AbTBLTSO>; Wed, 12 Feb 2003 14:18:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267810AbTBLTSO>; Wed, 12 Feb 2003 14:18:14 -0500
Received: from air-2.osdl.org ([65.172.181.6]:60821 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267785AbTBLTR5>;
	Wed, 12 Feb 2003 14:17:57 -0500
Date: Wed, 12 Feb 2003 11:25:01 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "Kline, Jonathan" <klinej@msoe.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.60 atkbd oops (Decoded)
Message-Id: <20030212112501.3eea2e60.rddunlap@osdl.org>
In-Reply-To: <1045063317.366.1.camel@tranquility>
References: <1045063317.366.1.camel@tranquility>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Feb 2003 09:21:57 -0600
"Kline, Jonathan" <klinej@msoe.edu> wrote:

| On Tue, 2003-02-11 at 21:50, Kline, Jonathan wrote:
| > Running a Compaq Armada E500 (PIII 850, 256MB Ram), and 2.5.Feb 11
| > 21:35:45 tranquility kernel: [ACPI Debug] String: _L09:  Exit
| > Feb 11 21:35:45 tranquility kernel:  printing eip:
| > Feb 11 21:35:45 tranquility kernel: c021b209
| > Feb 11 21:35:45 tranquility kernel: Oops: 0000
| > Feb 11 21:35:45 tranquility kernel: CPU:    0
| > Feb 11 21:35:45 tranquility kernel: EIP:    0060:[<c021b209>]    Not
| > tainted
| > Feb 11 21:35:45 tranquility kernel: EFLAGS: 00010246
| > Feb 11 21:35:45 tranquility kernel: eax: 00000000   ebx: 8172d550   ecx:
| > 00000000   edx: 00000006
| > Feb 11 21:35:45 tranquility kernel: esi: 8172d550   edi: c12bbda8   ebp:
| > c12bbd50   esp: c12bbd4c
| > Feb 11 21:35:45 tranquility kernel: ds: 007b   es: 007b   ss: 0068
| > Feb 11 21:35:45 tranquility kernel: Process events/0 (pid: 3,
| > threadinfo=c12ba000 task=c12bec40)
| > Feb 11 21:35:45 tranquility kernel: Stack: c12bbd7c c12bbd68 c0219d27
| > 8172d550 c12bbd7c c12bbda8 8172d550 c12bbd98 
| > Feb 11 21:35:45 tranquility kernel:        c022a3aa 8172d550 c0236bba
| > c12bbda8 00010000 c04064ad c04064a4 0000005e 
| > Feb 11 21:35:45 tranquility kernel:        c12bbdac c12bbdac 8172d550
| > c12bbdc8 c023061a 8172d550 c12bbda8 00000000 
| > Feb 11 21:35:45 tranquility kernel: Call Trace: [<c0219d27>] 
| > [<c022a3aa>]  [<c0236bba>]  [<c023061a>]  [<c02265fa>]  [<c02309ee>] 
| > [<c0230d
| > 48>]  [<c022a760>]  [<c0226500>]  [<c02340c5>]  [<c023443e>] 
| > [<c02352b3>]  [<c020c2da>]  [<c0204895>]  [<c01370b5>]  [<c020485b>] 
| > [<c0136c
| > e8>]  [<c0124b10>]  [<c0124b10>]  [<c0136ad0>]  [<c010825d>] 
| > Feb 11 21:35:45 tranquility kernel: Code: 80 3b aa 0f 44 c3 5b 5d c3 a1
| > b4 74 4c c0 eb f6 55 89 e5 8b 
| > Feb 11 21:36:00 tranquility kernel:  <4>atkbd.c: Unknown key (set 2,
| > scancode 0x154, on isa0060/serio0) released.
| > Feb 11 21:39:28 tranquility syslogd 1.4.1#11: restart.
| > Feb 11 21:39:28 tranquility kernel: klogd 1.4.1#11, log source =
| > /proc/kmsg started.
| > Feb 11 21:39:28 tranquility kernel: Cannot find map file.
| > Feb 11 21:39:28 tranquility kernel: No module symbols loaded - kernel
| > modules not enabled. 
| > Feb 11 21:39:28 tranquility kernel: Linux version 2.5.60
| > (klinej@tranquility) (gcc version 3.2.2) #0 Mon Feb 10 16:52:23 CST 2003
| > Feb 11 21:39:28 tranquility kernel: Video mode to be used for restore is
| > f00
| > Feb 11 21:39:28 tranquility kernel: BIOS-provided physical RAM map:
| > 60, this oops occurs at moderately random intervals, mainly in X, while
| > switching windows/screens. WM is blackbox, w/ bbkeys and bbpager.
| > Keyboard becomes unuseable. Complete kernel config available if needed,
| > as well as stack traces and possibly a rebote stack dump.
| > 
| > 
| > Cheers
|      -v /usr/local/src/linux-2.5.60/vmlinux (specified)
|      -k /proc/ksyms (default)
|      -l /proc/modules (default)
|      -o /lib/modules/2.5.60-jak1/ (default)
|      -m /boot/System.map-2.5.60-jak1 (default)
| 
| Error (regular_file): read_ksyms stat /proc/ksyms failed
| No modules in ksyms, skipping objects
| No ksyms, skipping lsmod
| Error (regular_file): read_system_map stat /boot/System.map-2.5.60-jak1
| failed
| Feb 11 22:25:05 tranquility kernel: c021b209
| Feb 11 22:25:05 tranquility kernel: Oops: 0000
| Feb 11 22:25:05 tranquility kernel: CPU:    0
| Feb 11 22:25:05 tranquility kernel: EIP:    0060:[<c021b209>]    Not
| tainted
| Using defaults from ksymoops -t elf32-i386 -a i386
| Feb 11 22:25:05 tranquility kernel: EFLAGS: 00010246
| Feb 11 22:25:05 tranquility kernel: eax: 00000000   ebx: 8172d550   ecx:
| 00000000   edx: 00000006
| Feb 11 22:25:05 tranquility kernel: esi: 8172d550   edi: c12bbda8   ebp:
| c12bbd50   esp: c12bbd4c
| Feb 11 22:25:05 tranquility kernel: ds: 007b   es: 007b   ss: 0068
| Feb 11 22:25:05 tranquility kernel: Stack: c12bbd7c c12bbd68 c0219d27
| 8172d550 c12bbd7c c12bbda8 8172d550 c12bbd98 
| Feb 11 22:25:05 tranquility kernel:        c022a3aa 8172d550 c0236bba
| c12bbda8 00010000 c04064ad c04064a4 0000005e 
| Feb 11 22:25:05 tranquility kernel:        c12bbdac c12bbdac 8172d550
| c12bbdc8 c023061a 8172d550 c12bbda8 00000000 
| Feb 11 22:25:05 tranquility kernel: Call Trace: [<c0219d27>] 
| [<c022a3aa>]  [<c0236bba>]  [<c023061a>]  [<c02265fa>]  [<c02309ee>] 
| [<c0230d48>
| [<c0124b10>]  [<c0124b10>]  [<c0136ad0>]  [<c010825d>] 
| Feb 11 22:25:05 tranquility kernel: Code: 80 3b aa 0f 44 c3 5b 5d c3 a1
| b4 74 4c c0 eb f6 55 89 e5 8b 
| 
| 
| >>EIP; c021b209 <sha1_transform+1639/16e0>   <=====
| 
| Trace; c0219d27 <sha1_transform+157/16e0>
| Trace; c022a3aa <twofish_encrypt+9da/ae0>
| Trace; c0236bba <zlib_inflate_flush+aa/188>
| Trace; c023061a <aes_decrypt+bca/1680>
| Trace; c02265fa <twofish_setkey+3b9a/6f70>
| Trace; c02309ee <aes_decrypt+f9e/1680>
| Trace; c0230d48 <aes_decrypt+12f8/1680>
| Trace; c0124b10 <io_apic_set_pci_routing+270/2e0>
| Trace; c0124b10 <io_apic_set_pci_routing+270/2e0>
| Trace; c0136ad0 <register_proc_table+40/130>
| Trace; c010825d <show_regs+14d/158>
| 
| Code;  c021b209 <sha1_transform+1639/16e0>
| 00000000 <_EIP>:
| Code;  c021b209 <sha1_transform+1639/16e0>   <=====
|    0:   80 3b aa                  cmpb   $0xaa,(%ebx)   <=====
| Code;  c021b20c <sha1_transform+163c/16e0>
|    3:   0f 44 c3                  cmove  %ebx,%eax
| Code;  c021b20f <sha1_transform+163f/16e0>
|    6:   5b                        pop    %ebx
| Code;  c021b210 <sha1_transform+1640/16e0>
|    7:   5d                        pop    %ebp
| Code;  c021b211 <sha1_transform+1641/16e0>
|    8:   c3                        ret    
| Code;  c021b212 <sha1_transform+1642/16e0>
|    9:   a1 b4 74 4c c0            mov    0xc04c74b4,%eax
| Code;  c021b217 <sha1_transform+1647/16e0>
|    e:   eb f6                     jmp    6 <_EIP+0x6>
| Code;  c021b219 <sha1_transform+1649/16e0>
|   10:   55                        push   %ebp
| Code;  c021b21a <sha1_transform+164a/16e0>
|   11:   89 e5                     mov    %esp,%ebp
| Code;  c021b21c <sha1_transform+164c/16e0>
|   13:   8b 00                     mov    (%eax),%eax
| 
| -- 
| Jonathan Kline <klinej@msoe.edu>
| Milwaukee School of engineering

Sorry, this oops report makes no sense to me at all.
It seems to have had trouble reading the System.map file, so
perhaps it's incorrect or not there.

Does this oops happen often/easily?
Does it happen if ACPI is not configured/enabled?
Do you actually have lots of crypto options enabled?

--
~Randy
