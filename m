Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288963AbSATXLP>; Sun, 20 Jan 2002 18:11:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288959AbSATXLG>; Sun, 20 Jan 2002 18:11:06 -0500
Received: from ncc1701.cistron.net ([195.64.68.38]:60938 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S288940AbSATXK6>; Sun, 20 Jan 2002 18:10:58 -0500
From: Miquel van Smoorenburg <miquels@cistron.nl>
Subject: Re: rm-ing files with open file descriptors
Date: Sun, 20 Jan 2002 23:10:57 +0000 (UTC)
Organization: Cistron Internet Services B.V.
Message-ID: <a2fiq1$ddk$3@ncc1701.cistron.net>
In-Reply-To: <a2bk6e$t2u$1@ncc1701.cistron.net> <Pine.GSO.4.21.0201190627310.3523-100000@weyl.math.psu.edu> <8HBE1o7mw-B@khms.westfalen.de> <843d119h0g.fsf@rjk.greenend.org.uk>
X-Trace: ncc1701.cistron.net 1011568257 13748 195.64.65.67 (20 Jan 2002 23:10:57 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <843d119h0g.fsf@rjk.greenend.org.uk>,
Richard Kettlewell  <rjk@terraraq.org.uk> wrote:
>If the file descriptor you have was opened O_RDONLY, but you have
>write permission on the file itself, then creating a new name for it
>would allow you to open it O_RDWR.

/proc allows for this anyway.

open("knuth.txt", O_RDONLY)             = 3
unlink("knuth.txt")                     = 0
open("/proc/self/fd/3", O_RDWR)         = 4

Mike.

