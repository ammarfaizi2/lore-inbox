Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S156803AbPLQPVR>; Fri, 17 Dec 1999 10:21:17 -0500
Received: by vger.rutgers.edu id <S156703AbPLQPOp>; Fri, 17 Dec 1999 10:14:45 -0500
Received: from lsmls02.we.mediaone.net ([24.130.1.15]:49816 "EHLO lsmls02.we.mediaone.net") by vger.rutgers.edu with ESMTP id <S156786AbPLQPCw>; Fri, 17 Dec 1999 10:02:52 -0500
Message-ID: <385A5068.B4490833@alumni.caltech.edu>
Date: Fri, 17 Dec 1999 07:02:00 -0800
From: Dan Kegel <dank@alumni.caltech.edu>
Organization: Precious Little
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.5-15 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.rutgers.edu" <linux-kernel@vger.rutgers.edu>
Cc: raster@rasterman.com
Subject: re: RasterMan on linux and threads
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-kernel@vger.rutgers.edu

re http://kernelnotes.org/lnxlists/linux-kernel/lk_9912_03/msg00480.html

Rasterman is wrong in saying that all threads run on the same
processor, but everything else he says about threads is spot on:
unless you have a real good reason to create a thread, don't.
Ousterhout certainly agrees.  See his slides on "Why threads are bad (usually)"
at http://www.scriptics.com/people/john.ousterhout/

Earlier in his news page, Raster says:
> The [imlib2] API changed a lot recently - it's now context based (you set
> the current context) and it uses that current context for almost all
> calls. It means many fewer parameters to many calls - but it also means
> Imlib2 is NOT thread-safe as the context is global. If anyone wants to
> work on making it thread safe - there's source code and send patches -
> but I don't see much value in it. Do all your graphics work in 1 thread.    

Wow, deja vu.  Right on the heels of Jim Gettys' post on the same subject,
http://kernelnotes.org/lnxlists/linux-kernel/lk_9912_03/msg00096.html

Raster, you might want to read Jim's post.  X calls use lots of context 
parameters (like old imlib), OpenGL calls use none (like new imlib2), and 
now they both wish they'd used a single one (i.e. an object oriented approach).

And you might want to modify your statement that threads always run on the same
CPU...
- Dan

-- 
(The above is just my personal opinion; I don't speak for my employer,
 except on the occasional talk show.)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
