Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318442AbSGSE3N>; Fri, 19 Jul 2002 00:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318448AbSGSE3N>; Fri, 19 Jul 2002 00:29:13 -0400
Received: from pimout5-ext.prodigy.net ([207.115.63.98]:23022 "EHLO
	pimout5-int.prodigy.net") by vger.kernel.org with ESMTP
	id <S318442AbSGSE3M>; Fri, 19 Jul 2002 00:29:12 -0400
Message-Id: <200207190432.g6J4WD2366706@pimout5-int.prodigy.net>
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: linux-kernel@vger.kernel.org
Subject: Alright, I give up.  What does the "i" in "inode" stand for?
Date: Thu, 18 Jul 2002 18:33:54 -0400
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been sitting on this question for years, hoping I'd come across the 
answer, and I STILL don't know what the "i" is short for.  Somebody here has 
got to know this. :)

I know what an inode IS (although it took me almost a year to figure this 
out, way back when), but I don't know what the name means.

I've been following this list for years now, and nobody's ever actually said 
what the i stands for, and neither do the (sparse) comments in fs/inode.c.  
I've read Peter Salus's book "a Quarter Century of Unix".  I've read the 
history of early unix development on Dennis Richie's home page, and although 
it complains that his original notes came back form the dictation service 
misspelling "inode" as "eyenode", it doesn't say what the I stands for.  I'm 
only about a third of the way into "Life with Unix", but it doesn't seem like 
a particularly technical history so far...

Another question I'm unclear about is "does every userspace-visible memory 
allocation have an inode"?  Loaded programs are basically mmaped files, and 
shared memory is now its own filesystem out of which you mmap stuff.  But I 
don't know about a process's stack and heap.

For a while I thought that swap could be thought of as a filesystem out of 
which the heaps were mapped as sparse files (this is the only explanation 
that made sense in early 2.5 when every page used HAD to have swap backing 
store, and taking away the mandatory backing store would just be an exercise 
in deferred allocation), but that apparently is not the case and I got 
disabused of this notion a while back.  Instead I learn what a "classzone" 
is.  Ok...

Then earlier today I wander across kerneltrap's interview with Larry McVoy, 
who espouses the viewpoint that Linux VM design should store statistics in 
inodes rather than worrying so much about individual pages, and I get 
confused again.

Has each process space's heap got an inode?  If so, in what filesystem?

Rob

(Yes, I am breaking the internet convention of posting errors rather than 
asking questions if you want people to respond.  I can come up with some 
errors if you'd like.  I'm good at that. :)
