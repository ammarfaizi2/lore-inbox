Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266034AbSKFTlg>; Wed, 6 Nov 2002 14:41:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266027AbSKFTlg>; Wed, 6 Nov 2002 14:41:36 -0500
Received: from chaos.analogic.com ([204.178.40.224]:24192 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S266034AbSKFTld>; Wed, 6 Nov 2002 14:41:33 -0500
Date: Wed, 6 Nov 2002 14:48:58 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "Calin A. Culianu" <calin@ajvar.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: /prod/PID-related proc fs question
In-Reply-To: <Pine.LNX.4.33L2.0211061403360.5858-100000@rtlab.med.cornell.edu>
Message-ID: <Pine.LNX.3.95.1021106144738.5400A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Nov 2002, Calin A. Culianu wrote:

> 
> I just noticed something today that I found odd and I know there must be a
> good reason for it, but I can't think of what it might be..
> 
> Basically if I am listing the contents of a /proc/PID directory, it seems
> that the cwd, exe, and root (symlink) entries are invalid unless the
> process corresponding to PID is a process owned by me, or I am root.  Why
> is this?
> 
> Is this feature security related?
> 
> If so I can't really think of any security issues that would arise from
> having that information as a non-priviledged user.
> 
> It would seem reasonable to me that users seeing each other's
> /prod/PID/root and /proc/PID/exe symlinks isn't really much of a security
> vulnerability.. Plus it would make possible a non-root user to grab
> statistics on the most popular running binaries, the number of chrooted
> processes.. etc..  probably trivial statistics but it still would be nice
> to see if any other instance of an application is running (unless there
> already is another mechanism for this that I am unaware of).
> 
> Anyway any answers appreciated...
> 
> -Calin



Well you know that you can send a "secret" message
from one task to another using Morse code?

As a trivial example, I could use a lot of CPU time
for a second:
     while(time(NULL) == saved)
            ;

I could call this a "dash".

Then I could use a tiny bit and call it a "dot":
    sleep(1);

I could then use a little bit and call it a space:
    while(time(NULL) == saved)
        usleep(1);

If another task knew this, and could have access to my
task's CPU time statistics, I could send messages through
an "undocumented" or "rogue" channel.

This may seem dumb, and the example is, however there
are commercial systems out there where you don't want any
undocumented communications paths between tasks. They
might be performing stock transactions for competing
clients, etc. A back-door communications path could
be used to steal. So, it might not be a good idea to give
away information that another task doesn't have a "need-to-know".



Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
   Bush : The Fourth Reich of America


