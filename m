Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288923AbSAXTG0>; Thu, 24 Jan 2002 14:06:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288925AbSAXTGR>; Thu, 24 Jan 2002 14:06:17 -0500
Received: from relay2.uni-heidelberg.de ([129.206.210.211]:53380 "EHLO
	relay2.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id <S288923AbSAXTGJ>; Thu, 24 Jan 2002 14:06:09 -0500
Message-Id: <200201241906.g0OJ68915057@fubini.pci.uni-heidelberg.de>
From: Bernd Schubert <bernd.schubert@tc.pci.uni-heidelberg.de>
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: kernel BUG at slab.c:1200!
Date: Thu, 24 Jan 2002 20:06:05 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_5EIGO46RO5H5QK09WF4O"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_5EIGO46RO5H5QK09WF4O
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8bit

Hi all,

we have a machine here that runs quite instable, with 2.2.16 it was crashing quite often and now after a big system 
update it also crashes with 2.4.17.
But at least /var/log/messages shows the following errors:

Jan 24 17:16:19 noether kernel: kernel BUG at slab.c:1200!
Jan 24 17:16:19 noether kernel: invalid operand: 0000
Jan 24 17:16:19 noether kernel: CPU:    1
Jan 24 17:16:19 noether kernel: EIP:    0010:[<c0137421>]    Not tainted
Jan 24 17:16:19 noether kernel: EFLAGS: 00010082
Jan 24 17:16:19 noether kernel: eax: 0000001b   ebx: c3217760   ecx: c03235ac   edx: 000118e7
Jan 24 17:16:19 noether kernel: esi: 00000000   edi: f764976c   ebp: f7634013   esp: f7bfbf10
Jan 24 17:16:19 noether kernel: ds: 0018   es: 0018   ss: 0018
Jan 24 17:16:19 noether kernel: Process kswapd (pid: 5, stackpage=f7bfb000)
Jan 24 17:16:19 noether kernel: Stack: c02b9ff7 000004b0 f764976c f7634013 f7635013 c3217760 c0138780 c3217760
Jan 24 17:16:19 noether kernel:        f764976c f7634013 00000020 000001d0 00000020 00000006 f7ba2000 00001000
Jan 24 17:16:19 noether kernel:        f7634013 c3217784 c03a9bc8 c3217770 00000006 c32231a4 c322316c 00000000
Jan 24 17:16:19 noether kernel: Call Trace: [<c0138780>] [<c013a1d8>] [<c013a27c>] [<c013a313>] [<c013a36e>]
Jan 24 17:16:19 noether kernel:    [<c013a47d>] [<c01056e4>]
Jan 24 17:16:19 noether kernel:
Jan 24 17:16:19 noether kernel: Code: 0f 0b 83 c4 08 8b 5f 14 83 fb ff 74 23 89 f6 39 f3 75 14 68

Machine is dual processor PentiumIII-800 (kernel booting protocol is attached).

About half an hour before the crash we got the following message:

Jan 24 16:35:00 noether kernel: mtrr: Serverworks LE detected. Write-combining disabled.
Jan 24 16:35:00 noether kernel: mtrr: your processor doesn't support write-combining
Jan 24 16:35:00 noether kernel: mtrr: Serverworks LE detected. Write-combining disabled.
Jan 24 16:35:00 noether kernel: mtrr: your processor doesn't support write-combining

Currently I'm doing a memory check but I'm not sure if memtest86 is able to detect any errors, since ECC-RAM is installed.
The machine has 2GB RAM + 1GB SWAP, I hope that I have compiled it with 4GB support 
(but the line from boot.msg "1023MB HIGHMEM available" confuses me). 
The machine was crashing when a memory allocation test was running.

Perhaps one of you can help me to debug the problem (please tell me if you need further information).

Thanks in advance,

Bernd


-- 
Bernd Schubert
Physikalisch Chemisches Institut
Abt. Theoretische Chemie
INF 229, 69120 Heidelberg
Tel.: 06221/54-5210
e-mail: bernd.schubert@tc.pci.uni-heidelberg.de



--------------Boundary-00=_5EIGO46RO5H5QK09WF4O
Content-Type: application/x-gzip;
  name="boot.msg.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="boot.msg.gz"

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
mISvMgAA

--------------Boundary-00=_5EIGO46RO5H5QK09WF4O--
