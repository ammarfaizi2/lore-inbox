Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312080AbSCQROL>; Sun, 17 Mar 2002 12:14:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312078AbSCQROC>; Sun, 17 Mar 2002 12:14:02 -0500
Received: from red.csi.cam.ac.uk ([131.111.8.70]:10121 "EHLO red.csi.cam.ac.uk")
	by vger.kernel.org with ESMTP id <S312077AbSCQRNr>;
	Sun, 17 Mar 2002 12:13:47 -0500
Message-Id: <5.1.0.14.2.20020317170621.00abd980@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sun, 17 Mar 2002 17:14:20 +0000
To: "Ken Hirsch" <kenhirsch@myself.com>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: fadvise syscall?
Cc: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
In-Reply-To: <005301c1cdc6$5a26de80$0100a8c0@DELLXP1>
In-Reply-To: <3C945635.4050101@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 15:13 17/03/02, Ken Hirsch wrote:
>There is a posix_fadvise() syscall in the POSIX Advanced Realtime
>specification
>http://www.opengroup.org/onlinepubs/007904975/functions/posix_fadvise.html

Posix or not I still don't see why one would want that. You know what you 
are going to be using a file for at open time and you are not going to be 
changing your mind later. If you can show me a single _real_world_ example 
where one would genuinely want to change from one access pattern to another 
without closing/reopening a particular file I would agree that fadvise is a 
good idea but otherwise I think open(2) is the superior approach.

In addition, open(2) allows you to do cool things like O_TEMP which could 
create a file that would never get written to disk at all and on close 
would just disappear again (just an idea, I can see good uses for such 
things, although in a way we already have simillar semantics when one 
creates such files on a tmpfs mount).

Best regards,
Anton

>I don't know if this has been mentioned on linux-kernel before, but in
>January, the Open Group, in cooperation with IEEE, added the POSIX
>functionality to their specification and made it available online for free.
>It's at
>http://www.opengroup.org/onlinepubs/007904975/toc.htm
>
>There are some useful tables at
>http://www.unix-systems.org/version3/online.html and they ask that you
>register there so that they know how many people are using the
>specification.
>
>They don't have a downloadable version of this specification, but they do
>for the previous versions:
>http://www.opengroup.org/onlinepubs/007908799/download/
>
>Ken Hirsch
>
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

