Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290943AbSASMCW>; Sat, 19 Jan 2002 07:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290937AbSASMCM>; Sat, 19 Jan 2002 07:02:12 -0500
Received: from uucp.cistron.nl ([195.64.68.38]:12552 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id <S290897AbSASMBx>;
	Sat, 19 Jan 2002 07:01:53 -0500
From: Miquel van Smoorenburg <miquels@cistron.nl>
Subject: Re: rm-ing files with open file descriptors
Date: Sat, 19 Jan 2002 12:01:52 +0000 (UTC)
Organization: Cistron Internet Services B.V.
Message-ID: <a2bn7g$5hm$1@ncc1701.cistron.net>
In-Reply-To: <a2bk6e$t2u$1@ncc1701.cistron.net> <Pine.GSO.4.21.0201190627310.3523-100000@weyl.math.psu.edu>
X-Trace: ncc1701.cistron.net 1011441712 5686 195.64.65.67 (19 Jan 2002 12:01:52 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.GSO.4.21.0201190627310.3523-100000@weyl.math.psu.edu>,
Alexander Viro  <viro@math.psu.edu> wrote:
>On Sat, 19 Jan 2002, Miquel van Smoorenburg wrote:
> 
>> This could be hacked around ofcourse in fs/namei.c, so I tried
>> it for fun. And indeed, with a minor correction it works:
>> 
>> % perl flink.pl 
>> Success.
>> 
>> I now have a flink-test2.txt file. That is pretty cool ;)
>
>It's also a security hole.

How is linking back a file into the normal namespace anymore
a security hole as having it under /proc or keeping an fd to it open?

I've searched google on the subject but couldn't find anything relevant.
Yes this has been proposed a few times for both BSD and Linux, often
in combination with "unattached open" (O_NULL or somesuch) that opens
a file with a nlink count of 0. It's supposed to be a perfect way to
create a new file and link it atomically into place without creating
(named) tempfiles.

Mike.

