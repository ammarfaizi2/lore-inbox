Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263347AbTJESsd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 14:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263368AbTJESsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 14:48:33 -0400
Received: from lewis.CNS.CWRU.Edu ([129.22.104.62]:54450 "EHLO
	lewis.CNS.CWRU.Edu") by vger.kernel.org with ESMTP id S263347AbTJESsc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 14:48:32 -0400
Date: Sun, 05 Oct 2003 14:48:31 -0400
From: Justin Hibbits <jrh29@po.cwru.edu>
Subject: BUG in 2.4.xx
To: linux-kernel@vger.kernel.org
Message-id: <83C51710-F764-11D7-BAB4-000A95841F44@po.cwru.edu>
MIME-version: 1.0
X-Mailer: Apple Mail (2.552)
Content-type: text/plain; format=flowed; charset=US-ASCII
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(panic from 2.4.22, but panics also in 2.4.21)

This is what I get when I have high memory support and preempt enabled 
in any 2.4 kernel.  High mem set to 4GB.  If I disable preempt, all 
works just fine.  If you need more help, I'll keep this kernel around.

-Justin


Partition check:
  /dev/ide/host0/bus0/target0/lun0:kernel BUG at sched.c:1263!
invalid operand 0000
CPU: 0
EIP: 0010:[<c01aac85>] Not tainted
EFLAGS: 00010213
eax: ffffffff ebx: c0148000 ecx: c01614e0 edx: c01614e0
esi: 00000001 edi: 00000000 ebp: c0149f24 esp: c0149f0c
ds: 0018 es: 0018
Process swapper (pid: 0, stackpage=c01490000)

Stack: c0149000 00000001 0000000 c0148000 00000001 00000000 c0149f30 
c01ab122
c0148000 c0145d40 c01b3428 c0145d00 c01b3326 00000001 00000001
c0145d40 fffffffe c01b310a c0145d40 c0148000 00000000 c0144f40 c0449f88
Call Trace: [<c01ab122>] [<c01b3428>] [<c01b3326>] [<c01b310a>] 
[<c019e81a>]
	[<c019b4f0>] [<c01a0d33>] [<c019b4f0>] [<c019b513>] [<c019b569>]
	[<c019b25d>]

Code: 0f 0b ef 04 58 9c 38 c0 b8 00 e0 ff ff 21 e0 ff 40 04 89 45
  <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

