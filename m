Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313690AbSDJT7T>; Wed, 10 Apr 2002 15:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313697AbSDJT7S>; Wed, 10 Apr 2002 15:59:18 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:14816 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S313690AbSDJT7R>; Wed, 10 Apr 2002 15:59:17 -0400
Subject: Re: [PATCH] Futex Generalization Patch
To: frankeh@watson.ibm.com
Cc: drepper@redhat.com, linux-kernel@vger.kernel.org, Martin.Wirth@dlr.de,
        pwaechtler@loewe-Komp.de, Rusty Russell <rusty@rustcorp.com.au>
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF6ED1E5D5.39630DC3-ON85256B97.006D2F99@raleigh.ibm.com>
From: "Bill Abt" <babt@us.ibm.com>
Date: Wed, 10 Apr 2002 15:59:39 -0400
X-MIMETrack: Serialize by Router on D04NM202/04/M/IBM(Release 5.0.9a |January 7, 2002) at
 04/10/2002 03:59:09 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2002 at 02:47:50 PM AST, Hubertus Franke <frankeh@watson.ibm.com>
wrote:

> The current interface is
>
> (A)
> async wait:
>    sys_futex (uaddr, FUTEX_AWAIT, value, (struct timespec*) sig);
> upon signal handling
>    sys_futex(uaddrs[], FUTEX_WAIT, size, NULL);
>    to retrieve the uaddrs that got woken up...

This is actually the preferred way.  I must've misinterpeted what you said
earlier.  I believe this is actually a more generic way of handling.  A
thread package can specify the signal to used much in the way the current
LinuxThreads pre-allocates and uses certain real-time signals...

> I am mainly concerned that SIGIO can be overloaded in a thread package ?
> How would you know whether a SIGIO came from the futex or from other file

> handle.

By keep with the original interface, we don't have to contend with this
problem.  The thread package can use the signal that most suits its'
implementation...

Make sense?

Regards,
      Bill Abt
      Senior Software Engineer
      Next Generation POSIX Threading for Linux
      IBM Cambridge, MA, USA 02142
      Ext: +(00)1 617-693-1591
      T/L: 693-1591 (M/W/F)
      T/L: 253-9938 (T/Th/Eves.)
      Cell: +(00)1 617-803-7514
      babt@us.ibm.com or abt@us.ibm.com
      http://oss.software.ibm.com/developerworks/opensource/pthreads

