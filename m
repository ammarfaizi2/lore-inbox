Return-Path: <linux-kernel-owner+w=401wt.eu-S1750794AbWLLApT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbWLLApT (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 19:45:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbWLLApT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 19:45:19 -0500
Received: from web58312.mail.re3.yahoo.com ([68.142.236.165]:37769 "HELO
	web58312.mail.re3.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750794AbWLLApS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 19:45:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=hqr1EupQqPIs3FWO4qpZ15Sog4vYxVzBgTKWRs6wk53CXiYE+SZymyKc78K4eqo/EoMut6z/JCEBj4MJhLIdAOPhOfkgicOWHgtzHk4CNSc1OkBH7PwvomjZThWjW2FLg+kIB6y1OjkN0+LX1cNzvEXADA0Y78pphL3rvAfk1UA=;
X-YMail-OSG: 8EExvFUVM1kLiumcAq1donLcdayBdigC8qy8redf0XlsOwvKrIlftXkhU74RjkVgaqtzVYbrn.qCuLAT.s3CYIge9e3.wVAgpnRiNCZX0u09USPeRwjaPYkYpV9vY0z1gDlxfGU8YWA.QYy1x7In8awjOHgJb_.1whU-
Date: Mon, 11 Dec 2006 16:45:17 -0800 (PST)
From: xu feng <xu_feng_xu@yahoo.com>
Subject: doubts about disk scheduling
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <430903.22870.qm@web58312.mail.re3.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 
Please cc your reply to my email. many thanks

I would appreciate any help on the following
questions.

 I have looked on disk scheduling algorithms 
<http://www.cs.princeton.edu/courses/archive/fall06/cos318/lectures/disks.pdf>
and the main thing that striked me is that most of the
algorithms that i have read in the textbooks (some are
explained in the previous ) don't take into
consideration the "priority of the process". Being the
short seek time first, scan, or c-scan algorithm, all
are explained through a string of block numbers, but
no mention is given about the owner of these
blocks.does it mean all the processes are treated
equally??  In my opinion a sort of Multi level queue
like with CPU scheduling algorithm can be used to
schedule the processes according to their importance.
any comment?


My second question is about the implementation, i.e.
how the different requests are actually aligned in the
disk queue?

if a process submit a disk I/O request, its PCB should
be linked to the disk queue. My question is, in making
the system call, and after checking the permission
rights and identifying the sought data (block) address
in the disk and the target address in the memory does
the kernel store this information in the pcb, then
link this pcb in the disk queue?

By doing so and once the disk controller is free , the
device driver checks the queue pcbs and read the
requested blocks and depending on the current location
of the disk head and the queue pcb block request, the
driver orders the controller to process a certain
block request of a certain process. The driver removes
this request from the pcb content 

is that how it is implemented?

Many thanks


 
____________________________________________________________________________________
Yahoo! Music Unlimited
Access over 1 million songs.
http://music.yahoo.com/unlimited
