Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: (majordomo@vger.rutgers.edu) by vger.rutgers.edu via listexpand id <S160020AbQHAB4E>; Mon, 31 Jul 2000 21:56:04 -0400
Received: by vger.rutgers.edu id <S160112AbQHABzT>; Mon, 31 Jul 2000 21:55:19 -0400
Received: from hog.ctrl-c.liu.se ([130.236.252.129]:4772 "HELO t1.ctrl-c.liu.se") by vger.rutgers.edu with SMTP id <S160036AbQHABya>; Mon, 31 Jul 2000 21:54:30 -0400
Date: 1 Aug 2000 02:06:15 -0000
Message-ID: <20000801020615.23065.qmail@t1.ctrl-c.liu.se>
From: wingel@t1.ctrl-c.liu.se
To: hpa@transmeta.com
Cc: linux-kernel@vger.rutgers.edu
Subject: Re: RLIM_INFINITY inconsistency between archs
Newsgroups: linux.kernel
In-Reply-To: <3986213D.FBACB4D1@transmeta.com>
References: <7iw6kYsXw-B@khms.westfalen.de> <8m4q9v$871$1@enterprise.cistron.net> <8m4tn3$cri$1@cesium.transmeta.com> <8m4uri$d9e$1@enterprise.cistron.net> <20000801004344.22321.qmail@t1.ctrl-c.liu.se>
Organization: 
Sender: owner-linux-kernel@vger.rutgers.edu

In article <3986213D.FBACB4D1@transmeta.com> you hpg@transmeta.com writes:
>wingel@t1.ctrl-c.liu.se wrote:
>> And IMHO to be able to do this, one should have to provide an explicit
>> -I/usr/src/my-kernel/linux/include, it should not be the default.
>
>I disagree.  It makes life far too painful for the end user, for really no gain.

The idea was to make a point, that #include <linux/xxx.h> really is
a kernel/kernel aware application thing only.  It ought to reduce the
number of people who try to include kernel only stuff without knowing
that it is a nono most of the time.

It isn't all that hard to add the following lines to the Makefiles 
for an application that needs the kernel includes:

KERNELDIR=/usr/src/linux
CFLAGS+=$(KERNELDIR)/include

And then standardise on /usr/src/linux as the directory where the kernel 
includes for the current kernel reside on a distribution.  Those who 
compile multiple kernels on the same system should be savvy enough to
do "KERNELDIR=/usr/src/my-kernel/linux make" or modify the Makefile.

   /Christer


-- 
"Just how much can I get away with and still go to heaven?"

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
