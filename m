Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276452AbRI2Haw>; Sat, 29 Sep 2001 03:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276450AbRI2Hae>; Sat, 29 Sep 2001 03:30:34 -0400
Received: from imo-r08.mx.aol.com ([152.163.225.104]:38862 "EHLO
	imo-r08.mx.aol.com") by vger.kernel.org with ESMTP
	id <S276449AbRI2Ha1>; Sat, 29 Sep 2001 03:30:27 -0400
From: Floydsmith@aol.com
Message-ID: <51.11defc6e.28e6d25d@aol.com>
Date: Sat, 29 Sep 2001 03:29:33 EDT
Subject: Re3: idetape broke in 2.4.x-2.4.9-ac5 (write OK but not read) ide-scsi works...
To: zaitcev@redhat.com, mikpe@csd.uu.se
CC: linux-kernel@vger.kernel.org, linux-tape@vger.kernel.org,
        Floydsmith@aol.com
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: AOL 4.0 for Windows 95 sub 14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Date: Wed, 5 Sep 2001 00:34:57 +0200 (MET DST)
>
>> >> - block size: The 2.4 ide-tape driver only works reliably if you
>> >>   write data with the correct block size. If you don't write full
>> >>   blocks the last block of data may not be readable.
>> >
>> >I fixed that some time ago, it's in current -ac
>> >if not in Linus's tree.
>> 
>> Sorry, but that's not correct. I just ran a test, and the bug is
>> still there in 2.4.9-ac7. Maybe you're thinking of some other bug?
>
>OK, perhaps you are right. I received a credible report from
>Ed Tomlinson that the "reading the last block" bug is in 2.4.10.
>
>It seems that either I fixed something else with the same symptoms
>or I fixed it improperly. Unfortunately, I cannot reproduce it.
>
>By the way, why does everyone insist on using ide-tape?
>It seems to be broken beyond any repair by injection of
>lethal poison marked "OnStream Support" (not that it was brilliant
>before, but that was the last nail in the coffin). Just use ide-scsi
>and be done with it. I really do not enjoy reading ide-tape.c.
>
>-- Pete

I was using scsi emulation (when I first switched to 2.4.x kernels because I 
was forced to when I ran to the above 2.4.x/bug/2.2.xworks ok ide problem . I 
have two problems with that. First, I use loadline exclusively for booting 
form DOS C: drive and from a ls-120 resue disk. To use scsi emu. I have to 
add hdc=ide-scsi to the boot params of the loadline command line for a 
machine with the tape drive on the secondary/master interface. I have three 
different machines and so the first issue is can't use the same same loadlin 
script for all machines (unless they all have the drive connected to the same 
interface [hdc, for example]). But the second [and more] drastic problem is 
scsi emu. simply stoped working all together in 2.4.5 (and higher 2.4.x 
kernels) for my HP 8 gig drive(s). Also, I might add I don't thing anyone 
shoud be forced to used scsi emu. for an ide drive - that should be an option.
Floyd,
