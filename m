Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275354AbRIZRWC>; Wed, 26 Sep 2001 13:22:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275353AbRIZRVx>; Wed, 26 Sep 2001 13:21:53 -0400
Received: from mail.fu-berlin.de ([160.45.11.165]:27939 "EHLO
	mail.fu-berlin.de") by vger.kernel.org with ESMTP
	id <S275354AbRIZRVi>; Wed, 26 Sep 2001 13:21:38 -0400
Message-ID: <3BB20D5F.67A699AB@inf.fu-berlin.de>
Date: Wed, 26 Sep 2001 19:16:15 +0200
From: Enver Haase <ehaase@inf.fu-berlin.de>
Organization: Free University of Berlin
X-Mailer: Mozilla 4.75 [en] (Win98; U)
X-Accept-Language: en,de,fr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [OOPS] linux-2.4.10 tough problem
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I'm sure 2.4.10 is an "uncomfortably large changeset" (Linus).

I've been running a 2.4.9 machine using ext2, 192MB RAM, on a 
K6-III-400 (66*6).

I compiled 2.4.10 two times, so it's highly probable it was no
hardware flaw (high temperature or so). Compiler is gcc 2.95.2
(release).

The oopses are reproducible, albeit the message changes.

After the start of "init" I always experience an OOPS message with
2.4.10,
most times after some demons have been started.

It completely locked up the machine, and because it was an Oops
in an interrupt handler, the machine did not sync. I therefore
don't have a "correct" oops here.

I don't know If I will get my harddisk back in a few hours, but I have
__written__ some info from the screen onto a sheet of paper like:

-------------------
Oops: 0000
CPU: 0
EIP: 0010:[<c0221770>]
EFLAGS: 00010203
EAX: 00000000
EBX: cb522da8
ECX: c00153e0
EDX: 00000000
ESI: 00000000
EDI: cb522ca0
EBP: cbfb2440
ESP: c83efdf0
DS: 0018
ES: 0018
SS: 0018

Process: isdnctrl [IT HAS NOT ALWAYS BEEN THIS PROCESS!]
(pid: 160, stackpage=c83ef000)
Stack: cb522da8 cb522ca0 c13e2860 00000000 00000010 cbf4f120 00000000
       00000001 c02218f5 c13e2860 cb522ca0 00000000 cb522da8 c13e2860
       00000000 00000000 cb2ab3c0 00000000 00000000 c0221b56 c13e2860
       cb522ca8 cbff9b60 04000001

Call trace:
       c02218f5 c0221b56 c0107d0c c0107e6e c0109be8 c01d9abe c01dc81c
       c0107d0c c0107e6e c0109be8 c0129fb2 c011dc65 c010f546 c0112f93
       c0113102 c0106af3

Code: 8b 46 dc 8d 6e d8 a9 00 00 80 00 74 3b 25 ff ff 7f ff 89 46

<0> kernel panic: aiee, killing interrupt handler
in interrupt handler - not syncing

--------------------
I have some old a.out format binaries that are still used, I think
some of them even at this early point of OOPSing.

I try to get my harddisk back: please tell me what I can do to provide
you with more information.
[I hope I get my ".config" back, to post the relevent lines here]

Greetings,
Enver
