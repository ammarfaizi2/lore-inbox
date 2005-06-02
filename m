Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261448AbVFBXVj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261448AbVFBXVj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 19:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261446AbVFBXVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 19:21:25 -0400
Received: from rrcs-24-199-11-214.west.biz.rr.com ([24.199.11.214]:17374 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261332AbVFBXUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 19:20:53 -0400
Message-ID: <429F3160.5060704@cyte.com>
Date: Thu, 02 Jun 2005 09:18:40 -0700
From: Jeff Wiegley <jeffw@cyte.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050402)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: amd64 booting panic (really, really early)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been trying to get the 2.6.12 release candidates booting
on my new amd64 machine without luck.

The motherboard/machine is a new shuttle ST20G5 and the real
frustrating part is that it does not have a built in serial
port. So I can't directly capture the panic. (I tried putting
in a PCI serial card and couldn't get to work. I think it
didn't work because the panic is so incredibly early that the
serial driver hasn't a chance to probe.)

But I have manually copied as much of the panic as remained
on the 24 lines of my screen. (Sorry for any transcription
errors):

The panic happens almost instaneously. (As in, I don't visibly
see any other output other than the panic. So, to at least
my slow eyes it looks like it happens immediately after the
"Booting kernel" line.)

I have no idea who would be responsible for this and the
oops-tracing.txt said to send here in such a case. I hope
somebody can tell me what's wrong or what obvious thing I
screwed up...

I can get 2.6.8 and 2.6.9 working but 2.6.10 and later
produce this error. I do have a version of 2.6.12-rc2
booting and working (typing on it now) but when I use the
same config file for 2.6.12-rc4 it goes back to the panic.

I'm willing to try more config options but I need some
input as to what I should be doing since I've run out of
ideas.

Please help if you can.

RSP: 0018: ffffffff8039a658  EFLAGS: 00010046
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00000000ffffffff R08: 0000000000000000 R09: 0000000000010001
R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff803dbee8
R13: 0000000000000000 R14: 0000000000000000 R15: ffffffff803dbfb0
FS:  0000000000000000(0000) GS:ffffffff803d3c00(0000) knlGS: 
0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000000000 CR3: 0000000000000000 CR4: 00000000000006a0
Process swapper (pid: 0, threadinfo ffffffff803da000, task ffffffff802f1200)
Stack: 0000000000000000 ffffffff802f1d20 0000000000000000 ffffffff803dbee8
        0000000000000000 ffffffff80152f3c 0000000000000000 0000000000000000
        ffffffff803d3d00 ffffffff802f1d20
Call Trace: <IRQ><fffffff80152f3c>{handle_IRQ_event+44} 
<ffffffff8015305d>{__do_IRQ+237}
       <ffffffff801113c2>{do_IRQ+66} ,ffffffff8010ed7d>{ret_from_intr+0}
       <EOI> <fffffff80131b67>{call_console_drivers+231}
       <ffffffff803dc7a7>{start_kernel+247} 
<fffffff803dc23f>{x86_64_start_kernel+319}

Code: 48 f7 f6 48 01 05 14 04 29 00 e9 cb 00 00 00 48 89 ca 48 8b
RIP <fffffff80112672>{timer_intrrupt+242} RSP <ffffffff8033a658>
  <0> Kernel panic - not syncing: Aiee, killing interrupt handler!

Thanks,

-- 
Jeff Wiegley, PhD
Cyte.Com, LLC
(ignore:cea2d3a38843531c7def1deff59114de)
