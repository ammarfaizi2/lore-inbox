Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262773AbREVUQ1>; Tue, 22 May 2001 16:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262777AbREVUQR>; Tue, 22 May 2001 16:16:17 -0400
Received: from fmfdns02.fm.intel.com ([132.233.247.11]:26351 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S262773AbREVUQG>; Tue, 22 May 2001 16:16:06 -0400
Message-ID: <9319DDF797C4D211AC4700A0C96B7C9404AC1F7D@orsmsx42.jf.intel.com>
From: "Raj, Ashok" <ashok.raj@intel.com>
To: "Linux-Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: scheduling callbacks in user space triggered via kernel....
Date: Tue, 22 May 2001 13:15:56 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Gurus...

Is there a method to schedule user mode code from kernel agent?

basically think that when some work is to be scheduled in user mode, the app
registers with the kernel mode agent with a function/parm to run, then when
the callback is appropriate the kerenl agent triggers this callback to
happen.

I can think of either using a shared buffer to communicate between
kernel/user space and use a dedicated thread to do this task.

But i would keep a page pinned for each process, and this may be limiting...

are there any examples of code in kernel that would do this?

if someone would not beat me up. for quoting this...

windows 2000 offers 2 such facilities. (APC or async procedure calls) where
a thread can block and when ready will be woken via
the kernel agent and can run a user supplied function.

or a method to bind a function to a file handle, when there is Completed IO,
the kernel would call the registered function with a parameter of the buffer
submitted for IO.

any ideas would be greatly appreciated.

ashokr

