Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262548AbREVW0k>; Tue, 22 May 2001 18:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262872AbREVW0b>; Tue, 22 May 2001 18:26:31 -0400
Received: from alumnus.caltech.edu ([131.215.50.236]:30700 "EHLO
	alumnus.caltech.edu") by vger.kernel.org with ESMTP
	id <S262871AbREVW0Y>; Tue, 22 May 2001 18:26:24 -0400
Date: Tue, 22 May 2001 15:26:20 -0700 (PDT)
From: "Daniel R. Kegel" <dank@alumni.caltech.edu>
Message-Id: <200105222226.PAA11500@alumnus.caltech.edu>
To: ashok.raj@intel.com
Cc: linux-kernel@vger.kernel.org
Subject: re: scheduling callbacks in user space triggered via kernel....
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ashok wrote:
> Is there a method to schedule user mode code from
> kernel agent? ...
> windows 2000 offers 2 such facilities. (APC or async
> procedure calls) where a thread can block and when
> ready will be woken via the kernel agent and can run a
> user supplied function.
>
> or a method to bind a function to a file handle, when
> there is Completed IO, the kernel would call the
> registered function with a parameter of the buffer
> submitted for IO.

The traditional Unix way might be for user process to
call one of the blocking functions (read(), poll(), sigwait(), etc),
and have the kernel unblock the process in the usual way.

There is support for real async I/O on the horizon; see the SGI patch
at http://oss.sgi.com/projects/kaio/ if you need async I/O today.
Not sure this is what you're after, though.

Can you provide an example of how you want to use this?

For those who haven't read about this NT stuff, see
http://www.microsoft.com/msj/0499/pooling/pooling.htm
Even AS/400 is getting into this stuff; see
http://www.as400.ibm.com/developer/v4r5/api.html

- Dan
