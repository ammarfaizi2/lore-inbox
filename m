Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265778AbRF2IbU>; Fri, 29 Jun 2001 04:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265782AbRF2IbK>; Fri, 29 Jun 2001 04:31:10 -0400
Received: from adsl-63-198-73-118.dsl.lsan03.pacbell.net ([63.198.73.118]:20998
	"HELO turing.xman.org") by vger.kernel.org with SMTP
	id <S265778AbRF2IbF>; Fri, 29 Jun 2001 04:31:05 -0400
Message-Id: <5.1.0.14.0.20010629012752.029dd170@imap.xman.org>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 29 Jun 2001 01:31:06 -0700
To: "Daniel R. Kegel" <dank@alumni.caltech.edu>, lk@tantalophile.demon.co.uk
From: Christopher Smith <x@xman.org>
Subject: Re: A signal fairy tale
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200106282011.NAA21508@alumnus.caltech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 01:11 PM 6/28/2001 -0700, Daniel R. Kegel wrote:
>AFAIK, there's no 'read with a timeout' system call for file descriptors, so
>if you needed the equivalent of sigtimedwait(),
>you might end up doing a select on the sigopen fd, which is an extra
>system call.  (I wish Posix had invented sigopen() and readtimedwait() 
>instead of
>sigtimedwait...)

What, you don't want to use AIO or to collect your AIO signals? ;-)

In my apps, what I'd do is spawn a few worker threads which would do 
blocking reads. Particularly if the sigopen() API allows me to grab 
multiple signals from one fd, this should work well enough for one's high 
performance needs. Alternatively, one could use select/poll to check if 
there was data ready before doing the read. I agree though that it'd be 
nice to have a timed read.

--Chris

