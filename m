Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131631AbRDWUZt>; Mon, 23 Apr 2001 16:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131376AbRDWUZh>; Mon, 23 Apr 2001 16:25:37 -0400
Received: from colorfullife.com ([216.156.138.34]:6667 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S131588AbRDWUZX>;
	Mon, 23 Apr 2001 16:25:23 -0400
Message-ID: <001d01c0cc33$7e62daa0$5517fea9@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: <jmerkey@vger.timpanogas.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: filp_open() in 2.2.19 causes memory corruption
Date: Mon, 23 Apr 2001 22:24:55 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Are you sure the trace is decoded correctly?

> CPU:    0 
> EIP:    0010:[sys_mremap+31/884] 
> EFLAGS: 00010206

> Code: ac ae 75 08 84 c0 75 f8 31 c0 eb 04 19 c0 0c 01 85 c0 75 d9
ac ae is
lodsb
scasb

Could you run
#objdump --disassemble-all --reloc linux/mm/mremap.o | less

and check that the code is really at offset 31 of sys_mremap?

And is it correct that only 64 MB memory is installed/enabled?

--
    Manfred


