Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315440AbSGYQri>; Thu, 25 Jul 2002 12:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315442AbSGYQri>; Thu, 25 Jul 2002 12:47:38 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:27366 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S315440AbSGYQrg>;
	Thu, 25 Jul 2002 12:47:36 -0400
Date: Thu, 25 Jul 2002 12:50:50 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Anton Altaparmakov <aia21@cantab.net>
cc: Linus Torvalds <torvalds@transmeta.com>, Matt_Domsch@Dell.com,
       Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: RE: 2.5.28 and partitions
In-Reply-To: <5.1.0.14.2.20020725133331.00aa69b0@pop.cus.cam.ac.uk>
Message-ID: <Pine.GSO.4.21.0207251245530.17621-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 25 Jul 2002, Anton Altaparmakov wrote:

> At 12:44 25/07/02, Alexander Viro wrote:
> >Al, still thinking that anybody who does mkfs.<whatever> on a multi-Tb
> >device should seek professional help of the kind they don't give on l-k...
> 
> Why? What is wrong with large devices/file systems? Why do we have to break 
> up everything into multiple devices? Just because the kernel is "too lazy" 
> to implement support for large devices? Nobody cares if 64bit code is 

Large filesystem => troubles with backups, even more troubles with restoring
after disk failure, yadda, yadda.

> database server and we can live with that. At least our applications deal 
> with GiBs of data for each experiment, which is shifted over Gigabit 
> ethernet to/from a SQL database backend stored on a huge RAID array, so we 
> are completely i/o bound.
> 
> It's one database, and it's huge. And it's going to get bigger as people do 
> more experiments. We need mkfs.<whatever> on a huge device... We are just 
> lucky that our current RAID array is under 2TiB se we haven't hit the 
> "magic" barrier quite yet. But at 1.4TiB we are not far off...

... and backups of your database are done on...?

"RAID" doesn't mean that data is safe.  It means that some class of
failures will not be immediately catastrophic, but that's it - both
hardware and software arrays _do_ go tits up.  Just ask hpa for story
of the troubles on kernel.org.

