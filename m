Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264420AbRFIAhy>; Fri, 8 Jun 2001 20:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264419AbRFIAho>; Fri, 8 Jun 2001 20:37:44 -0400
Received: from post.aecom.yu.edu ([129.98.1.4]:58555 "EHLO post.aecom.yu.edu")
	by vger.kernel.org with ESMTP id <S264418AbRFIAhc>;
	Fri, 8 Jun 2001 20:37:32 -0400
Mime-Version: 1.0
Message-Id: <a05100327b7471d549290@[129.98.91.150]>
In-Reply-To: <FEEBE78C8360D411ACFD00D0B7477971880AA9@xsj02.sjs.agilent.com>
In-Reply-To: <FEEBE78C8360D411ACFD00D0B7477971880AA9@xsj02.sjs.agilent.com>
Date: Fri, 8 Jun 2001 20:37:21 -0400
To: linux-kernel@vger.kernel.org
From: Maurice Volaski <mvolaski@aecom.yu.edu>
Subject: [PANIC] aic7xxx loaded from initrd under 2.4.5
Cc: gibbs@scsiguy.com
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A panic occurs at boot while the aic7xxx is doing its thing..the 
following has been hand copied from the screen...

>  printing eip:
>c01b6e36 *pde = 00000000
>Oops: 0000
>CPU: 1
>EIP: 0010:[<c01b6e36>]
>EFLAGS: 00010202
>eax: 0000003	ebx: 00001261	ecx: 00000000	edx: c144fd74 esi: 
>0000000	edi: cff1a3c0	ebp: cff18f60	esp: c144fd54
>ds: 0018	es: 0018	ss: 0018
>Process swapper (pid: 1, stackpage=c144f000)
>Stack:	c144e000 ffffffff cff1a3c0 c013abea c144fd74 00000000 00001261 00000000
>	cff17c00 cfb669e0 00000202 00000bb8 cff17c00 cfb8fa00 
>d080452e cfb8fa00	00000202 00000000 cfb8fa00 d081c640 c0300900 
>cfff4350 cfff0100 cfd01f20 Call Trace: [<c013abea>] [<d080452e>] 
>[<d081c640>] [<c0111196>] [<c01ae1ab>] [<c0132dfe>] [<c01348ea>]
>	[<c012906a>] [<c01b6d97>] [<c013719c>] [<c01348ea>] 
>[<c013555ee>] [<c0123425>] [<c0147580>] [<c0148da7>]
>	[<c013ae62>] [<c0138ccc>] [<c0105000>] [<c0116e46>] 
>[<c0105000>] [<c01051da>]
>[<c010522d>][<c0105000>]
>	[<c0105736>] [<c0105200>]
>Code: 8b 40 10 83 f8 02 7e 62 b8 f0 ff ff ff eb 74 85 c9 b8 ea ff
>Kernel panic: Attempted to kill init!

In this particular instance the driver was aic7xxx_old, tested 
because the current aic7xxx had been behaving identically.

The problem had not occurred when I tried aic7xxx as part of a 
monolithic 2.4.5 and no initrd/modules.

The box is an IBM Netfinity 4500R with dual pentiums, ServeRAID 3L 
adapter attaching three internal drives, internal SCSI adapter 
disabled and IBM's Ultra 160 SCSI controller (Adaptec 29160) tested 
with and without a drive attached.

Original system is RedHat 7.1 with fresh kernel 2.4.5 (for SMP) and 
latest patch for ext3 applied. Booting was initially set to launch a 
monolithic 2.4.5 kernel which boots with no problem. Then I tried it 
2.4.5 from scratch with a fresh initrd and modules of scsi and 
aic7xxx where it causes the panic described above.
-- 

Maurice Volaski, mvolaski@aecom.yu.edu
Computing Support, Rose F. Kennedy Center
Albert Einstein College of Medicine of Yeshiva University
