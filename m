Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129604AbRAOMlv>; Mon, 15 Jan 2001 07:41:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129401AbRAOMll>; Mon, 15 Jan 2001 07:41:41 -0500
Received: from shaker.worfie.net ([203.8.161.33]:39434 "HELO mail.worfie.net")
	by vger.kernel.org with SMTP id <S129627AbRAOMlZ>;
	Mon, 15 Jan 2001 07:41:25 -0500
Date: Mon, 15 Jan 2001 20:41:21 +0800 (WST)
From: "J.Brown (Ender/Amigo)" <ender@enderboi.com>
To: <linux-kernel@vger.kernel.org>
cc: <deity@lists.debian.org>
Subject: UPDATE: Re: 2.4.0 kernel oops from apt-get (dcache.h)
In-Reply-To: <Pine.LNX.4.30.0101151836360.12306-100000@shaker.worfie.net>
Message-ID: <Pine.LNX.4.30.0101152036580.13530-100000@shaker.worfie.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Updated info - I completely forgot this fact until playing around with
trying to fix this problem...

After running out of space on my root partition, I symlinked my apt-cache
directory to a directory on a HFS partition (I had done this some time
ago, and never had any problems until now).

It seems the new kernel doesn't like the fact that the HFS partition only
supports 30-something charecter filenames... and of course package
filenames from debian and almost always longer, containing name, version
and arch.

2.2 seemed to cope with this no-worries, and just used the truncated
name in file accesses... 2.4 oops. Whether this is an issue with the HFS driver in 2.4, another kernel issue in 2.4, or
something in Apt... we do not know :)



Regards,
	 Ender
 _________________________ ______________________________
|   James 'Ender' Brown   | "Where are we going, and why |
| http://www.enderboi.com |  am I in this handbasket?!?" |
+-------------------------+------------------------------+

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
