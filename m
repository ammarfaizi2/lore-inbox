Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129936AbQKLDbg>; Sat, 11 Nov 2000 22:31:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129947AbQKLDbZ>; Sat, 11 Nov 2000 22:31:25 -0500
Received: from slash.ab.videon.ca ([206.75.216.210]:22160 "EHLO
	slash.ab.videon.ca") by vger.kernel.org with ESMTP
	id <S129936AbQKLDbQ>; Sat, 11 Nov 2000 22:31:16 -0500
Message-ID: <3A0E0EE6.8833FE72@imben.com>
Date: Sat, 11 Nov 2000 20:30:46 -0700
From: Ben Chu <ben@imben.com>
X-Mailer: Mozilla 4.76 [en] (Win98; U)
X-Accept-Language: en,fr,es-MX
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: ben@imben.com
Subject: Re: 2.4.0-test10 oops
In-Reply-To: <fa.f0mv7ev.d5s60h@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Dvorak said:
> 
> Hi,
> 
> attached oops came from writing to vfat fs.

This problem was brought up a couple of times before as referenced
here
http://www.uwsg.indiana.edu/hypermail/linux/kernel/0010.3/0652.html
http://www.uwsg.indiana.edu/hypermail/linux/kernel/0006.1/1754.html
http://www.uwsg.indiana.edu/hypermail/linux/kernel/0003.3/0594.html
but I've never seen a solution as of yet.

In my own experiences, the bug didn't occur as frequently and
reproducably as it did when I moved to the 2.4.0-test series yet it
appears to be a long-standing issue.  

I use Netscape Messenger to read my mail with the actual mail files
stored on a vfat partition.  The problem seems to occur when
messages are copied to the vfat partition after being downloaded
from the mail server.

As noted in one of the above articles, it appears to be a
problem with the truncate function and Netscape uses this function
to use it to increase the size of its .summary files.  My kernel is
OOPSing almost daily because of this problem.

I'm no kernel hacker so I'm hoping someone out there who is will
take notice of this problem.  I've got the output of my own ksymoops
run from 2.4.0-test10 as well if anyone takes interest.

-- 
Ben Chu
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
