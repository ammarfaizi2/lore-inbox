Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315445AbSGSFBj>; Fri, 19 Jul 2002 01:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315455AbSGSFBj>; Fri, 19 Jul 2002 01:01:39 -0400
Received: from [202.54.24.132] ([202.54.24.132]:46493 "EHLO
	dns5.ggn.hcltech.com") by vger.kernel.org with ESMTP
	id <S315445AbSGSFBi>; Fri, 19 Jul 2002 01:01:38 -0400
Message-ID: <5F0021EEA434D511BE7300D0B7B6AB5304249CC7@mail2.ggn.hcltech.com>
From: "Mohamed Ghouse , Gurgaon" <MohamedG@ggn.hcltech.com>
To: linux-kernel@vger.kernel.org
Subject: RE: Alright, I give up.  What does the "i" in "inode" stand for?
Date: Fri, 19 Jul 2002 10:38:12 +0530
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think U should have referred 
The Design of the Unix Operating Systems
-Maurice J Bach.

He tells that I stands for Index. ;-)

-MG

-----Original Message-----
From: Rob Landley [mailto:landley@trommello.org]
Sent: Friday, July 19, 2002 4:04 AM
To: linux-kernel@vger.kernel.org
Subject: Alright, I give up. What does the "i" in "inode" stand for?


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

only about a third of the way into "Life with Unix", but it doesn't seem
like 
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
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
