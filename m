Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285654AbRLTAER>; Wed, 19 Dec 2001 19:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285655AbRLTAD6>; Wed, 19 Dec 2001 19:03:58 -0500
Received: from s187-232.WebAccess.net ([216.241.187.232]:22658 "HELO
	xerxes.data-raptors.com") by vger.kernel.org with SMTP
	id <S285654AbRLTADv>; Wed, 19 Dec 2001 19:03:51 -0500
Content-Type: text/plain; charset=US-ASCII
From: Elyse Grasso <emgrasso@data-raptors.com>
Reply-To: emgrasso@data-raptors.com
To: linux-kernel@vger.kernel.org
Subject: apm gpf on Inspiron2500 with 2.4.9
Date: Wed, 19 Dec 2001 17:02:00 -0700
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011220000357Z285654-18284+4575@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please copy me on any comments, I am not subscribed to the list.

Attempts to interract with apm on Inspiron 2500 laptops produce results like 
the following (KRUD/RedHat 7.2, but also occurs with 7.1).

kernel: apm: BIOS version 1.2 Flags 0x03 (Driver version 1.14)

general protection fault: e998
CPU:  0
EIP:  0050:[<00002ffb>]       Not tainted
EFLAGS:       00010046
eax: 00000292 ebx: 00000001   ecx: 00000000 edx: 00000000
esi: c023149a edi: 00000014   ebp: c9f6de80   esp: c9f6de78
ds: 0058      es: 0000        ss: 0018
Process apmd (pid 781, stackpage c9f6d000)
Stack:        5319519e 0000de80 00000058 149a0292 de940050 00000001 530a0000 
00000016
      00485369 00000000 c9f6def8 c01109b3 00000010 c9f6def8 00000292 ffff0018
      00000018 cbe50000 c0120000 c9f6df32 c023149a ffffffff c9f5c000 c0110bbf
Call Trace: [<c01109b3>] apm_bios_call [kernel] 0x43
[<c0120000>] force_sig [kernel] 0x0
[<c023149a>] .rodaata.str1.1 [kernel] 0x5c35
[<c0110bbf>] apm_get_power_status [kernel] 0x3f
[<c0126c24>] do_munmap [kernel] 0x64
[<c0111886>] apm_get_info [kernel] 0x46
[<c0153704>] proc_file_read [kernel] 0x94
[<c0106f3b>] sys_read [kernel] 0x96
[<c0106f3b>] system_call [kernel] 0x33

Please let me know if there is other information that would be helpful... 
it's been about 15 years since I did device driver work on 8086 based 
machines, but I can probably figure out how to get you the information you 
ask for.

Thanks

Elyse Grasso
