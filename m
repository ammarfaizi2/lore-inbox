Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312727AbSCVPnQ>; Fri, 22 Mar 2002 10:43:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312728AbSCVPnH>; Fri, 22 Mar 2002 10:43:07 -0500
Received: from mail.MtRoyal.AB.CA ([142.109.10.24]:51216 "EHLO
	mail.mtroyal.ab.ca") by vger.kernel.org with ESMTP
	id <S312727AbSCVPm6>; Fri, 22 Mar 2002 10:42:58 -0500
Date: Fri, 22 Mar 2002 08:42:47 -0700 (MST)
From: James Bourne <jbourne@MtRoyal.AB.CA>
Subject: Re: max number of threads on a system
In-Reply-To: <Pine.LNX.3.96.1020322103236.22096C-100000@gatekeeper.tmr.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Davide Libenzi <davidel@xmailserver.org>,
        David Schwartz <davids@webmaster.com>, joeja@mindspring.com,
        "linux-kernel@vger.redhat.com" <linux-kernel@vger.kernel.org>
Message-id: <Pine.LNX.4.44.0203220840280.14699-100000@skuld.mtroyal.ab.ca>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Mar 2002, Bill Davidsen wrote:

> On Thu, 21 Mar 2002, Davide Libenzi wrote:
> 
> > On Thu, 21 Mar 2002, David Schwartz wrote:
> > 
> > >
> > >
> > > On Thu, 21 Mar 2002 20:05:39 -0500, joeja@mindspring.com wrote:
> > > >What limits the number of threads one can have on a Linux system?
> > >
> > > 	Common sense, one would hope.
> > >
> > > >I have a simple program that creates an array of threads and it locks up at
> > > >the creation of somewhere between 250 and 275 threads.
> > 
> > $ ulimit -u
> 
> /proc/sys/kernel/threads-max is the system limit. And "locks up" is odd
> unless the application is really poorly written to handle errors. Should
> time out and whine ;-)

One thing to note here, using pthreads there is a limit of 1024
threads per process.  There are patches to glibc to increase this
to a larger number (4096 or 8192).

Regards
James Bourne

-- 
James Bourne, Supervisor Data Centre Operations
Mount Royal College, Calgary, AB, CA
www.mtroyal.ab.ca

******************************************************************************
This communication is intended for the use of the recipient to which it is
addressed, and may contain confidential, personal, and or privileged
information. Please contact the sender immediately if you are not the
intended recipient of this communication, and do not copy, distribute, or
take action relying on it. Any communication received in error, or
subsequent reply, should be deleted or destroyed.
******************************************************************************

