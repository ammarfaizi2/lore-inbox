Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316869AbSFVTAp>; Sat, 22 Jun 2002 15:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316877AbSFVTAo>; Sat, 22 Jun 2002 15:00:44 -0400
Received: from wotug.org ([194.106.52.201]:1855 "EHLO gatemaster.ivimey.org")
	by vger.kernel.org with ESMTP id <S316869AbSFVTAn>;
	Sat, 22 Jun 2002 15:00:43 -0400
Date: Sat, 22 Jun 2002 20:00:32 +0100 (BST)
From: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>
X-X-Sender: ruthc@sharra.ivimey.org
To: Rob Landley <landley@trommello.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux, the microkernel (was Re: latest linus-2.5 BK broken)
In-Reply-To: <200206221823.g5MIMuO327686@pimout4-int.prodigy.net>
Message-ID: <Pine.LNX.4.44.0206221947140.11032-100000@sharra.ivimey.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Jun 2002, Rob Landley wrote:

>On Saturday 22 June 2002 11:31 am, Alan Cox wrote:
>> > A microkernel design was actually made to work once, with good
>> > performance. It was about fifteen years ago, in the amiga.  Know how they
>> > pulled it off? Commodore used a mutant ultra-cheap 68030 that had -NO-
>> > memory management unit.
>>
>> Vanilla 68000 actually. And it never worked well - the UI folks had
>> to use a library not threads. The fs performance sucked

Threads (in the sense of tasks[1]) in fact worked extremely well and very
efficiently on the Amiga, and "Intuition" was always coded as one thread and
was modified use them more widely as the programmers had time and resource to
do so.

>On a side note, it's fun looking through the tanenbaum-torvalds debate 
>archive and see all the people holding up the amiga as an example of a 
>successful microkernel with decent performance, and note the lack of MMU...

I was very happy indeed with the performance of the computer, given the 0.25
MIPS CPU. The "Exec" scheduler was an extremely good design of its type, as
has been recognised in various places since.

The filesystem of the Amiga was very slow because it was a very definitely 
second-best setup; the original Amiga Corp. folks ran out of cash and in the 
end the filesystem from another OS, Tripos, was grafted in. Not only was it 
not what was originally designed in, but it was written in an 
almost-incompatible language (BCPL).

However, I won't argue about MMU vs non-MMU; it was obvious from the start
that any kind of memory protection between tasks would render a great deal of
the system design useless, because the whole system shared memory and 
resources. How else did people get away with application footprints 1/5 to 
1/10 that of equivalents on Windows?


Regards,

Ruth


[1] Exec only understood "tasks" as the basic scheduling unit; a task could be
extended to become a process if access to the filesystem was required, but
doing so did not change the scheduling cost at all.


-- 
Ruth Ivimey-Cook
Software engineer and technical writer.

