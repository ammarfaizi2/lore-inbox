Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265298AbRFUXlP>; Thu, 21 Jun 2001 19:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265299AbRFUXlF>; Thu, 21 Jun 2001 19:41:05 -0400
Received: from chaos.analogic.com ([204.178.40.224]:28288 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S265298AbRFUXky>; Thu, 21 Jun 2001 19:40:54 -0400
Date: Thu, 21 Jun 2001 19:40:45 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Pete Zaitcev <zaitcev@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Is it useful to support user level drivers
In-Reply-To: <200106212206.f5LM6dK12282@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.3.95.1010621193107.6383A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jun 2001, Pete Zaitcev wrote:

> > There is no such thing as a "user mode" interrupt service routine.
> > There never was one, and there will never be one on any machine
> > that fetches instructions from memory for execution. [...]
> 
> If memory does not deceive me, SunLab Spring processed interrupts
> in user space. I do not remember for sure, but I think QNX did, too.
> User mode interrupt handlers are perfectly doable, provided that the
> hardware allows to mask interrupts selectively.
>

QNX does not have any difference between user-space and kernel space.
It's not paged-virtual. It's just one big sheet of address space
with no memory protection (everything is shared). All procedures
to be executed are known at compile time.

Therefore, any piece of code can do anything it wants including
handling hardware directly. In fact, that's what QNX was designed
for.
 
> Large part of the post that I quoted was spent on spitting
> in the general direction of clueless programmers; indeed,
> I observe that perhaps 90% of requests for user mode interrupt
> processing come from the same people who would like to write
> Linux kernel mode code in C++ (total retards, in other words).
> 

I think I said (or implied) that too.

> It does not mean, however, that there are not justified cases
> for user-mode interrupt handlers, especially outside of Linux.

Not if that memory can get swapped or paged out .


> Some OSes are even written in C++ and Java, and run just fine
> on a machine that fetches instructions from memory.
> 

Then you are stretching the meaning of "OS" just a bit. It's
true that I can make an Operating System  entirely in interpreted
BASIC. However, it is really only a "Command Processor" even
though it can have multiple "connections" requesting commands
to be processed.


> -- Pete
> -

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


