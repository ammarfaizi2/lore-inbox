Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129387AbRAEIct>; Fri, 5 Jan 2001 03:32:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129183AbRAEIcj>; Fri, 5 Jan 2001 03:32:39 -0500
Received: from hnlmail1.hawaii.rr.com ([24.25.227.33]:3083 "EHLO hawaii.rr.com")
	by vger.kernel.org with ESMTP id <S129610AbRAEIcb>;
	Fri, 5 Jan 2001 03:32:31 -0500
From: "Ryan Sizemore" <ryan831@usa.net>
To: "Linux-Kernel" <linux-kernel@vger.kernel.org>
Subject: Memory Corruption
Date: Thu, 4 Jan 2001 22:33:43 -1000
Message-ID: <NEBBIFHONDNEGJDKODONGEBNCEAA.ryan831@usa.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message has a couple of questions to it, so maybe a few people might
want to contribute to answering them all. My apologies in advance for the
long length of this post.

The Problem:
I have an Alpha PC164 with 512 Meg of memory. As a friend and I were setting
it up, we tried to compile mozilla. At some point during the install, a
repeating error would scroll by the screen so fast that we could not read
it. From what we could pick out, we determined that the error was memory
related. We deduced that since compiling mozilla would fill the entire bank
of memory, once gcc (or whatever directly writes to memory) tried to address
the bad area of memory, gcc would produce the error. Also, after trying to
recompile mozilla a number of times, the error would be at a random point,
usually after about 15 or 20 minutes of compiling. From this information, we
hazard to guess that one of the eight 64 Meg SIMMS was bad, or contained a
bad area. Therefore, we removed the last 4 of the 8 modules, and the error
never occurred.

The suggested solution:
We plan to swap out the 4 of the 4 remaining modules with the 4 that we
removed earlier, one at a time, and try to compile mozilla, since it will
fill all of the memory. Then, hopefully, we can rotate the modules to find
the one that contains the bad area.

We are not quite sure what to do from there. Here are our ideas:
1. One suggestion I made was to create a ram drive over the last 64 Meg of
addressable memory, the simply not read or write to the drive. Is that even
possible? Can I tell the kernel to create a ram drive over a certain area of
memory?
2. Another idea I had was to tell the kernel to only use a certain size of
memory, with a modification to lilo.conf: append="mem=448m" since 512(the
total memory) - 64(the size of the module) = 448Meg. Will this work? Any
ideas?

Another question:
We are not sure if the memory is ECC or not, but we think that there is a
good chance of it. Are there any kernel optimizations that can be made so
that the kernel can map out the bad memory and mark it so that it cant be
used? The machine is booted from an SRM prompt, if that helps.

Please let me know if anyone had any ideas on these problems. Thanks in
advance to all those out there who took the time to read this.

--Ryan Sizemore

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
