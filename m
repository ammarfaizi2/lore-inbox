Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131880AbRAHVOg>; Mon, 8 Jan 2001 16:14:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131823AbRAHVO1>; Mon, 8 Jan 2001 16:14:27 -0500
Received: from mail.ima.pl ([195.117.13.5]:44807 "EHLO mail.ima.pl")
	by vger.kernel.org with ESMTP id <S130516AbRAHVOO>;
	Mon, 8 Jan 2001 16:14:14 -0500
Message-Id: <5.0.0.25.0.20010108214619.00aaea60@195.117.13.2>
X-Mailer: QUALCOMM Windows Eudora Version 5.0
Date: Mon, 08 Jan 2001 22:12:18 +0100
To: linux-kernel@vger.kernel.org
From: Blizbor <tb670725@ima.pl>
Subject: Re: Bug in 2.2 kernels (mysterious hangs after freeing unused
  memory)
In-Reply-To: <20010108210920.U3472@arthur.ubicom.tudelft.nl>
In-Reply-To: <5.0.0.25.0.20010107190604.00a44400@195.117.13.2>
 <5.0.0.25.0.20010107190604.00a44400@195.117.13.2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 01-01-08 21:09, you wrote:
>On Sun, Jan 07, 2001 at 07:21:08PM +0100, Blizbor wrote:
>> I have found something weird in kernel 2.2.17.
>> After installation on the Pentium PRO equipped machine,
>> I have moved hard disk to another one, but equipped
>> with AMD-K5 and after encountering problems I moved again
>> this disk to machine equipped with Intel Pentium MMX.
>> 
>> On all machines except Pentium PRO boot process was stopping
>> after freeing unused kernel memory.
>
>A kernel compiled and optimised for a PPro does not neccesarily run on
>an AMD K5 or a Pentium MMX.

Yes, I know that. 
Kernel was compiled for i386.
Problem was by simplified "init" process handling in kernel
- especially no error handling for them. Problem is not in that 
something doesnt run but in that so there aren't information 
about error. I didn't expect that kernel do something more 
complicated than saying about error. Hanging is not good idea ;)
I've lost few work days to find whats
going on. Problem is lack of one short line displayed on console:
"init process failed, reason: killed by signal 4".
I was really surprised that on installation CD marked as i386,
some stupid guy put binaries for i686.
Exactly six rpm's - three containing kernel (that's OK) and one 
containing glibc. Even if "smart guys" wanted to make preformance
boost, they should do that in the safe way. But this is problem of the 
RedHat 7 developers. Together with glibc srpms that doesnt have chance
to build on i386 platform due to bugs in specs file. But let we
leave alone RH and their problems with their experimental distribution.

Cheers,
Blizbor

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
