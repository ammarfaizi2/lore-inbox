Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293386AbSCSAlF>; Mon, 18 Mar 2002 19:41:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293380AbSCSAkz>; Mon, 18 Mar 2002 19:40:55 -0500
Received: from TYO200.gate.nec.co.jp ([210.143.35.50]:34020 "EHLO
	TYO200.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S293379AbSCSAkn>; Mon, 18 Mar 2002 19:40:43 -0500
Message-ID: <3C9689FC.9459A014@necas.nec.co.jp>
Date: Tue, 19 Mar 2002 08:44:44 +0800
From: Zou Pengcheng <zoupch@necas.nec.co.jp>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en, zh-CN
MIME-Version: 1.0
To: "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: 2.2.14-5.0 oops (st.o related?)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

got the following oops from 2.2.14-5.0 (redhat 6.2 distribution), ntagent, a system monitoring process, may be the
trouble-maker, however, i think it's innocent, and the system stack somehow got messed up.  i know that the information
here may not be enough to locate the problem, but that's almost all i have got (i dont even know how to reproduce it).
wonder if someone could kindly give me some hint on how to decode such message (especially the stack tracing part), i
tried ksymoops and read oops-tracing.txt, still cannot understand it.

Feb 26 07:16:31 bsrvdns11 named-xfer[11950]: [10.30.1.20] not authoritative for spacepark.city.koriyama.fukushima.jp,
SOA query got rcode 0, aa 0, ancount 0, aucount 1
Feb 26 07:19:58 bsrvdns11 kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
Feb 26 07:19:58 bsrvdns11 kernel: current->tss.cr3 = 0d009000, %cr3 = 0d009000
Feb 26 07:19:58 bsrvdns11 kernel: *pde = 00000000
Feb 26 07:19:58 bsrvdns11 kernel: Oops: 0002
Feb 26 07:19:58 bsrvdns11 kernel: CPU:    0
Feb 26 07:19:58 bsrvdns11 kernel: EIP:0010:[st:__insmod_st_S.bss_L40+64807/102907613]
Feb 26 07:19:58 bsrvdns11 kernel: EFLAGS: 00010246
Feb 26 07:19:58 bsrvdns11 kernel: eax: 00000000   ebx: c0046b04   ecx: d00621c0 edx: 00000004
Feb 26 07:19:58 bsrvdns11 kernel: esi: bffff428   edi: 00000006   ebp: cd00bf5c esp: cd00bf40
Feb 26 07:19:58 bsrvdns11 kernel: ds: 0018   es: 0018   ss: 0018
Feb 26 07:19:58 bsrvdns11 kernel: Process ntagent (pid: 568, process nr: 28, stackpage=cd00b000)
Feb 26 07:19:58 bsrvdns11 kernel: Stack: 00000006 ffffffe9 00000003 bffff400 ffffffeb 121bd508 cd00bf6c cd00bf84
Feb 26 07:19:58 bsrvdns11 kernel:        d0062482 cdaa7870 cf221240 c0046b52 bffff428 cf221240 ffffffe7 bffff428
Feb 26 07:19:58 bsrvdns11 kernel:        00000000 c0046b52 c0132c7d cdaa7870 cf221240 c0046b52 bffff428 cd00a000
Feb 26 07:19:58 bsrvdns11 kernel: Call Trace: [st:__insmod_st_S.bss_L40+49834/102922586] [sys_ioctl+441/484] [sys_open+1

30/172] [system_call+52/56]
Feb 26 07:19:58 bsrvdns11 kernel: Code: 0f bb 04 00 00 00 83 c4 08 eb 0b 8d b6 00 00 00 00 bb da ff


TIA,
  -- Zou Pengcheng

