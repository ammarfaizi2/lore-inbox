Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276083AbRI1OoS>; Fri, 28 Sep 2001 10:44:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276085AbRI1OoI>; Fri, 28 Sep 2001 10:44:08 -0400
Received: from nick.dcs.qmul.ac.uk ([138.37.88.61]:1949 "EHLO
	nick.dcs.qmul.ac.uk") by vger.kernel.org with ESMTP
	id <S276083AbRI1Onx>; Fri, 28 Sep 2001 10:43:53 -0400
Date: Fri, 28 Sep 2001 15:44:19 +0100 (BST)
From: Matt Bernstein <matt@theBachChoir.org.uk>
To: <linux-kernel@vger.kernel.org>
Subject: weirdness in reiserfs
Message-ID: <Pine.LNX.4.33.0109281509080.10065-100000@nick.dcs.qmul.ac.uk>
X-URL: http://www.theBachChoir.org.uk/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a 240GB reiserfs ataraid partition on one of my servers (2.4.9-ac10
+ ext3 0.9.9 + ext3 speedup + ext3 "experimental VM patch" + jfs 1.0.4),
which I had populated with lots of little files, probably huge amounts of
tail-packing going on.

I deleted a tarball of one of my directories; I forget how big the file
was, but I reckon it was of the order of 25GB. It took long enough (over
an hour) that I went to the pub with fingers crossed instead of nursing
it. While it was deleting vmstat 1 was showing bi= ~ 2000 and bo= ~ 20000,
so it was hammering away. Fine, I thought, it's a big file; I don't do
this sort of thing often, maybe the stuff needed to delete such a big file
is bigger than the journal size or something. But.. the partition was
otherwise inaccessible with processes just blocking. Oddly df worked
though, so I could watch my use of the filesystem going down!

So.. I came back in this morning and things had recovered. Weird. Could
the "experimental VM patch" mentioned on the ext3 for 2.4 page be a little
too experimental? Sorry to be so vague...

Matt

