Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271569AbRHUMIX>; Tue, 21 Aug 2001 08:08:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271581AbRHUMIO>; Tue, 21 Aug 2001 08:08:14 -0400
Received: from jl1.quim.ucm.es ([147.96.5.12]:1540 "HELO jl1.quim.ucm.es")
	by vger.kernel.org with SMTP id <S271569AbRHUMH7>;
	Tue, 21 Aug 2001 08:07:59 -0400
Date: Tue, 21 Aug 2001 14:00:45 +0200
From: "Ram'on Garc'ia Fern'andez" <ramon@jl1.quim.ucm.es>
To: linux-kernel@vger.rutgers.edu
Subject: Kernel Crash 2.4.8
Message-ID: <20010821140045.A1710@jl1.quim.ucm.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

This crash was produced when mounting the Zip drive.

(This causes modprobe to load the ide-scsi module)

Kernel 2.4.8 SMP. 2 Pentium III processors 800 MHz

I had to write by hand all the kernel messages. Please
forgive mistakes.

Ramon

EIP: C0186B6A (account_io_start + 0x26)
*PDE = 0
Flags = 10046
EAX = 0
EBX = 393946
ECX = 2
EDX = 0
ESI = 2
EDI = 0
EBP = C7F33018
ESP = C78E3CC0
DS = ES = SS = 18
process modprobe
Stack: C75C2C60 C0186C02 00393946 C75C2C60 0 2 2 C40F0DA0
0  39346 0 C0187466 C75C2C60 0 2 C40F0DA0
Call trace:
C0186C02 req_new_io+0x36
C0187466 __make_request+0x606
C01877A1 generic_make_request+0xe1
C0187855 submit_bh+0x55
C0187A6B ll_rw_block+0x1fb
C0139287 bread+0x33
C015BA86 validate_partition_table+0x16
C015BBA1 ldm_partition+0x8d
C015A07C check_partition+0xe0
C0117CEE release_console_sem+0x8e
C015A4E3 grok_partitions+0x7b
C015A450 register_disk+0x28
C8929CE5 ?? (probably from ide-scsi module; unfortunately I have no record).
C892AB68 ??
C892AB20 ??
C88114B1 ??
Code: 01 4B 30 EB 0B 90 85 D2 74 03 FF 43 38 01 4B 40
(the symbol "buffer" is the start of this piece of code)
0:   01 4b 30                add    %ecx,0x30(%ebx)
3:   eb 0b                   jmp    10 <buffer+0x10>
5:   90                      nop
6:   85 d2                   test   %edx,%edx
8:   74 03                   je     d <buffer+0xd>
a:   ff 43 38                incl   0x38(%ebx)
d:   01 4b 40                add    %ecx,0x40(%ebx)

