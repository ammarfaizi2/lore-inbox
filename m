Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272286AbRHXSWH>; Fri, 24 Aug 2001 14:22:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272289AbRHXSV5>; Fri, 24 Aug 2001 14:21:57 -0400
Received: from bigglesworth.mail.be.easynet.net ([212.100.160.67]:14099 "EHLO
	bigglesworth.mail.be.easynet.net") by vger.kernel.org with ESMTP
	id <S272286AbRHXSVt>; Fri, 24 Aug 2001 14:21:49 -0400
Message-ID: <3B869A36.3E035F6D@newmail.net>
Date: Fri, 24 Aug 2001 20:17:26 +0200
From: Chris Pockele <chrisp@newmail.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.2.12 i386)
X-Accept-Language: en
MIME-Version: 1.0
To: Samium Gromoff <_deepfire@mail.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: sound crashes in 2.4
In-Reply-To: <E15aFMJ-0007GS-00@f8.mail.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Samium Gromoff wrote:
> 
> > Both 2.4.8 and 2.4.9 have this problem (these are the ones I tried).
> > Btw on 2.2.x i get DMA (output) timeout errors (and broken sound).
> 
>   just to clarify: does 2.4.7 hangs?
>   (for me it doesnt, but everything >= 2.4.8 does)
> 
After i read in this list that some people do not experience
this problem in 2.4.7, I decided to give it a try.

2.4.7 crashes too, but behaves differently:

invalid operand: 0000
CPU:	0
EIP:	0010:[<c01f5ea0>]
EFLAGS:	00010046
eax: 00000000	ebx: c0248000	ecx: c086a260	edx: c086a260
esi: c0105170	edi: ffffe000	ebp: 0008e000	esp: c0249fd0
ds: 0018   es: 0018    ss: 0018
Process swapper (pid: 0, stackpage=c0249000)
Stack: c0105193 00000010 00000246 c01051f8 00001000 0009b800 c0105000
c0105027
       c024a84e 00000000 c025c340 c0100197
Call Trace: [<c0105193>] [<c01051f8>] [<c0105000>] [c0105027>]

Code: ff e9 46 ff ff ff 90 90 90 90 90 90 90 90 90 90 68 0a ff ff
Kernel panic: Attempted to kill the idle task!
In idle task - not syncing

(This was the 2nd time i tried it out ; the 1st time
it Oopsed (0002) but i don't have that message anymore)
