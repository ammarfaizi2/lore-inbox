Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265757AbRF2ISa>; Fri, 29 Jun 2001 04:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265764AbRF2ISU>; Fri, 29 Jun 2001 04:18:20 -0400
Received: from adsl-63-198-73-118.dsl.lsan03.pacbell.net ([63.198.73.118]:16902
	"HELO turing.xman.org") by vger.kernel.org with SMTP
	id <S265757AbRF2ISJ>; Fri, 29 Jun 2001 04:18:09 -0400
Message-Id: <5.1.0.14.0.20010629011647.02a00a98@imap.xman.org>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 29 Jun 2001 01:18:10 -0700
To: "Daniel R. Kegel" <dank@alumni.caltech.edu>, balbir.singh@wipro.com
From: Christopher Smith <x@xman.org>
Subject: Re: A signal fairy tale
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <200106280249.TAA06507@alumnus.caltech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 07:49 PM 6/27/2001 -0700, Daniel R. Kegel wrote:
>Balbir Singh <balbir.singh@wipro.com> wrote:
> >sigopen() should be selective about the signals it allows
> >as argument. Try and make sigopen() thread specific, so that if one
> >thread does a sigopen(), it does not imply it will do all the signal
> >handling for all the threads.
>
>IMHO sigopen()/read() should behave just like sigwait() with respect
>to threads.  That means that in Posix, it would not be thread specific,
>but in Linux, it would be thread specific, because that's how signals
>and threads work there at the moment.

Actually, I believe with IBM's new Posix threads implementation, Linux 
finally does signal delivery "the right way". In general, I think it'd be 
nice if this API *always* sucked up signals from all threads. This makes 
sense particularly since the FD is accessible by all threads.

--Chris

