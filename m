Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318458AbSHPOJt>; Fri, 16 Aug 2002 10:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318460AbSHPOJt>; Fri, 16 Aug 2002 10:09:49 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:11002 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S318458AbSHPOJs>; Fri, 16 Aug 2002 10:09:48 -0400
Subject: [BUG] softirq.c:229 - LTP nightly bk testing
From: Paul Larson <plars@austin.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>,
       ltp-results <ltp-results@lists.sourceforge.net>,
       lse-tech@lists.sourceforge.net
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 16 Aug 2002 09:06:31 -0500
Message-Id: <1029506793.2582.88.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the nightly testing that Linux Test Project does on bitkeeper trees,
I noticed that one of the two machines failed to reboot to run last
nights test.  The UP box came up and worked fine, but the 2-way PIII-550
had this panic on boot:

kernel BUG at softirq.c:229!
invalid operand: 0000
CPU:    1
EIP:    0060:[<c011cbad>]       Not tainted
EFLAGS: 00010246
eax: 00000000   ebx: c0454034   ecx: c265a000   edx: c03f20cc
esi: c0453f80   edi: c265a000   ebp: c0436560   esp: c265bfb0
ds: 0068   es: 0068   ss: 0068
Process ksoftirqd_CPU1 (pid: 5, threadinfo=c265a000 task=c2658000)
Stack: 00000001 c0432960 fffffffe 00000020 c011c8fa c0432960 c265a000
00000020
       c265a000 c0453b80 00000246 c011ce56
10 50 8b 43 0c ff d0 83 c4 04
 <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

Changesets between last test and this one were 1.519.3.1 through 1.558.

