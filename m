Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314078AbSDZQRb>; Fri, 26 Apr 2002 12:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314079AbSDZQR3>; Fri, 26 Apr 2002 12:17:29 -0400
Received: from newton.math.uni-mannheim.de ([134.155.89.79]:24519 "EHLO
	newton.math.uni-mannheim.de") by vger.kernel.org with ESMTP
	id <S314078AbSDZQR2>; Fri, 26 Apr 2002 12:17:28 -0400
Message-Id: <2364450.A2IVDLuGi8@newssend.sf-tec.de>
From: Rolf Eike Beer <eike@euklid.math.uni-mannheim.de>
Subject: Re: [BUG] 2.5.10 - kernel hangs after detecting CD/DVD ROM (was: Re: IDE problem:  2.5.10 compiles but hangs during boot)
To: linux-kernel@vger.kernel.org
Date: Fri, 26 Apr 2002 18:17:41 +0200
In-Reply-To: <200204251757.07947.stephan@maciej.muc.de>
User-Agent: KNode/0.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Von Stephan Maciej:

> On Wednesday 24 April 2002 21:53, Mark Orr wrote:
>> Linux 2.5.10 compiles but doesnt complete boot due to some IDE
>> errors.    Previous working kernel was 2.5.8-pre3.
> That's the last line I see from a 2.5.10 kernel booting up. 2.5.9 does
> go farther:
> 
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> ide: unexpected interrupt 1 15
> ide1 at 0x170-0x177,0x376 on irq 15
> ide: unexpected interrupt 0 14
> [... and so on...]
> 
> No OOPS, no BUG, even not a blinking cursor anymore (vesafb).

Do You mean something like this?

Mounting local file systems...
proc on /proc type proc (rw)
SCSI subsystem driver Revision: 1.00
ide: unexpected interrupt 1 15
Unable to handle kernel NULL pointer dereference at virtual address 
00000004
 printip eip:
c018c056
*pde = 00000000
Oops: 0002
CPU: 0
EIP: 0010: [<c018c056>] Not tainted
EFLAGS: 00010002
eax: 00000004 ebx: c799de20 ecx: 00000061 edx: 00000000
esi: c799dd9c edi: c02842cc ebp: 00000292 esp: c0229ecc
ds: 0018 es: 0018 ss: 0018
Process swapper (pid: 0, threadinfo = c0228000
                  task=c0217140
stack: c799dd9c 00000001 c02842cc 00000003 00000001 c0187c7b c02842cc 
00000001
       00000000 c885d4c2 c02842cc 00000001 00000018 c799de20 c799dd9c 
c885e1f3
       c02842cc 00000001 c0228000 00000000 c02842cc c11be2c0 00000000 
00000086
call trace: [<c018dv7b>] [<c88d4c2*>] [<c885e1f3>] [<c018dd75>]
            [<c885e12c>] [<c01083cc>] [<c0180594>] [<c0105000>]
            [<c0107152>] [<c01052e0>] [<c0105000>] [<c0105303>]
            [<c0105374>] [<c010504d>]
Code> c7 04 02 00 00 00 00 8b 53 0c 8b 87 34 02 00 00 0f b3 10 8b
<0> Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

It is written down by hand and has at least one error (*), there is one 
char missing.

Eike
-- 
Wir vom FBI haben keinen Humor von dem wir wüssten. - K
