Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281504AbRLRMLA>; Tue, 18 Dec 2001 07:11:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281552AbRLRMKu>; Tue, 18 Dec 2001 07:10:50 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:7691 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S281504AbRLRMKh>; Tue, 18 Dec 2001 07:10:37 -0500
Message-ID: <3C1F323F.ED6AE4F4@idb.hist.no>
Date: Tue, 18 Dec 2001 13:10:39 +0100
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.1-pre10 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: root@chaos.analogic.com, linux-kernel@vger.kernel.org
Subject: Re: Mounting a in-ROM filesystem efficiently
In-Reply-To: <Pine.LNX.3.95.1011217081551.19476A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:

> 
> Security isn't a problem with embedded systems because everything
> that could possibly be done is handled with a "monitor". There is
> no shell. If there is no way to execute some foreign executable,
> you don't have a security issue unless some dumb alleged software
> engineer added some back-doors to the monitor.

A hacker don't need a /bin/sh or any other onboard software
to exploit some security flaw.  Assume someone discover that
your embedded box is vulnerable to a buffer overflow attack
of the type usually used to get a root shell.  Then they
discover that running /bin/sh don't work.  What to do?  They
simply put a simple little shell _in_ the buffer overflow
code itself.  A hacker don't need to call anything, all he need
can be downloaded as part of the exploit code.  

If the room for exploit code is thight - use a two-stage approach.
The exploit then consists of code that download the rest of the
code into some other RAM outside the tiny buffer.

No "dangerous" utilities on board doesn't mean the box is safe at
all.  The buffer overflow code could contain code for 
continuing the attack on other boxes, or anything else.

Helge Hafting
