Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265491AbRF1C6N>; Wed, 27 Jun 2001 22:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265494AbRF1C6D>; Wed, 27 Jun 2001 22:58:03 -0400
Received: from alumnus.caltech.edu ([131.215.50.236]:15843 "EHLO
	alumnus.caltech.edu") by vger.kernel.org with ESMTP
	id <S265491AbRF1C5t>; Wed, 27 Jun 2001 22:57:49 -0400
Date: Wed, 27 Jun 2001 19:57:47 -0700 (PDT)
From: "Daniel R. Kegel" <dank@alumni.caltech.edu>
Message-Id: <200106280257.TAA06889@alumnus.caltech.edu>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, x@xman.org
Subject: Re: A signal fairy tale
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christopher Smith <x@xman.org>
>> [ sigopen() proposal ]
>... From a programming standpoint, this 
>looks like a really nice approach. I must say I prefer this approach to the 
>various "event" strategies I've seen to date, as it fixes the primary 
>problem with signals, while still allowing us to hook in to all the 
>standard POSIX API's that already use signals. 

Thanks.  I'm sure people already thought of this long ago, it's basically just 
the usual "In Unix, everything's a file".  Until you ran into that
problem where the jvm was stealing your signals, though, I hadn't seen
a situation where having signals behave like files would be important.

>It'd be nice if I could pass 
>in a 0 for signum and have the kernel select from unused signals (problem 
>being that "unused" is not necessarily easy to define), althouh I guess an 
>inefficient version of this could be handled in userland.

There is a (non-threadsafe) convention that Jamie Lokier pointed out
for finding an unused thread.   If we allowed sigopen(-1) to allocate
a new signal for you, it'd probably just use the same scheme...

>I presume the fd could be shared between threads and otherwise behave like 
>a normal fd, which would be sooooper nice.

Yes.

>I guess the main thing I'm thinking is this could require some significant 
>changes to the way the kernel behaves. Still, it's worth taking a "try it 
>and see approach". If anyone else thinks this is a good idea I may hack 
>together a sample patch and give it a whirl.

What's the biggest change you see?  From my (two-martini-lunch-tainted)
viewpoint, it's just another kind of signal masking, sorta...

>Thanks again good fairy Dan/Eunice. ;-)

You're welcome (and I'll tell Eunice you liked her idea!).

- Dan

