Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262837AbUDLKn2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 06:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262849AbUDLKn2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 06:43:28 -0400
Received: from zeus.kernel.org ([204.152.189.113]:17819 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262837AbUDLKnS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 06:43:18 -0400
Date: Mon, 12 Apr 2004 18:43:08 +0800
From: "osmaker@hu" <osmaker@mailbox.hu>
X-Mailer: The Bat! (v2.04.7)
Reply-To: "osmaker@hu" <osmaker@mailbox.hu>
X-Priority: 3 (Normal)
Message-ID: <855788306.20040412184308@mailbox.hu>
To: linux-kernel@vger.kernel.org
Subject: kernel panic
In-Reply-To: <461730575.20040412183950@mailbox.hu>
References: <461730575.20040412183950@mailbox.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,
I have got a kernel panic when running a heavy load socket processing.
This server is written by my self and when the clients reached 10k,
the panic occured. In the server code run 100 threads and every thread
using poll on fds.
      I am a newbie on kernel ,can you tell me how to solve the
      problem?and how to analyze the panic when I come across it?

      the panic information:
ybdev mousedev hid input usb-uhci usbcore ext3jbd
CPU:0
EIP:0060:[<d08ab88e>]   not tainted
EFLAGS:00010202
EIP is at rx_poll [sundance] 0x17e(2.4.20-8)
eax:00008000 ebx:00000000 ecx:ce611160 edx:00000014
esi:00008052 edi:00000000 ebp:00000052 esp:cffb7f80
ds:0068  es:0068  ss:0068
Process ksoftirqd_cpu0(pid:4, stackpage=cffb7000)
Stack:c06c8080 ce611000 c01f5eed 00000001 d08a6e00 0000000b 00000014 ce611160
      0000000b c0370c18 fffffff7 00000246 c01217d6 ce611000 00000001 c0121685
      c0370c18 cffb6000 cffb6000 cffb6000 00000000 c0121ab5 cffb62fe c025d9b1
Call Trace:[<c01f5eed>]process_blacklog[kernel]0x6d(0xcffb7f88))
           [<c01217d6>]tasklet_action[kernel]0x46(0xcffb7fb0))
           [<c0121685>]do_softirq[kernel]0x95(0xcffb7fbc))
           [<c0121ab5>]ksoftirqd[kernel]0xa5(0xcffb7fd4))
           [<c0121a10>]ksoftirqd[kernel]0x0(0xcffb7fe4))
           [<c010742d>]kernel_thread_helper[kerlnel]0x5(0xcffb7ff0)
Code:8b 7b 60 8b 83 84 00 00 00 85 ff 0f 85 fe 01 00 01 6b 5c
<0> Kernel panic:Aiee, killing interrupt handler!
In interrupt handler - not syncing      

        Thank you very much!

-- 
Best regards,
 osmaker                          mailto:osmaker@mailbox.hu


