Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129184AbRBUQsp>; Wed, 21 Feb 2001 11:48:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129691AbRBUQsh>; Wed, 21 Feb 2001 11:48:37 -0500
Received: from [200.43.18.234] ([200.43.18.234]:8452 "EHLO
	radius.telpin.com.ar") by vger.kernel.org with ESMTP
	id <S129184AbRBUQsU>; Wed, 21 Feb 2001 11:48:20 -0500
To: Brian Gerst <bgerst@didntduck.org>
Subject: Re: "Unable to handle kernel paging request" x 3
Message-ID: <982774041.3a93f1191add3@webmail.telpin.com.ar>
Date: Wed, 21 Feb 2001 13:47:21 -0300 (ARST)
From: Alberto Bertogli <albertogli@telpin.com.ar>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <982763791.3a93c90f0c35c@webmail.telpin.com.ar> <3A93E2E6.F6FD4602@didntduck.org>
In-Reply-To: <3A93E2E6.F6FD4602@didntduck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Brian Gerst <bgerst@didntduck.org>:

> 
> This one just looks really odd.  I can't figure out where the faulting
> address (0x00009fac) is coming from.  It's not from the ret
> instruction,
> which should be getting a valid return address off the stack.  Do you
> still have the raw oops message (before sending it through ksymoops)?
> 

Yes, this is the original oops, copied by hand.
The virtual address is very different from the other two.. I'll see tomorrow if 
there is a 4th oops.

Unable to handle kernel paging request at virtual address 00009fac
*pde = 00000000
CPU:    1
EIP:    0010:[<c01071ec>]
EFLAGS: 00010246
eax: 00000000  ebx: c01071c0  ecx: c1228000  edx: c1228000
esi: c1228000  edi: c01071c0  ebp: 00000000  esp: c1229bf0
ds: 0018  es: 0018 ss: 0018
Process swapper (pid: 0, stackpage=c1229000)
Stack: c010724e 00000000 00000000 00000000 c037d886 0000002b 00000000 c024126d
       00000000 00000006 00000007 00000000 00000000 c03e8a40 0000c000 c01e771e
       c1223000 00000001 00000000 00000000
Call trace: [<c010724e>] [<c024126d>] [<c01e771e>]

Code: c3 8d 76 00 fb c3 89 f6 fb ba 00 e0 ff ff 21 e2 b8 ff ff ff
Kernel panic: Attemped to kill the idle task!
In idle task - not syncing

This last line doesn't appear on the ksymoops report, i really dont know why it 
insists on cutting it.

Thanks a lot,
        Alberto


