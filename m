Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313544AbSDJTKb>; Wed, 10 Apr 2002 15:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313553AbSDJTKa>; Wed, 10 Apr 2002 15:10:30 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:53422 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S313544AbSDJTK3>; Wed, 10 Apr 2002 15:10:29 -0400
Content-Type: text/plain; charset=US-ASCII
From: Hubertus Franke <frankeh@watson.ibm.com>
Reply-To: frankeh@watson.ibm.com
Organization: IBM Research
To: "Bill Abt" <babt@us.ibm.com>
Subject: Re: [PATCH] Futex Generalization Patch
Date: Wed, 10 Apr 2002 14:10:59 -0400
X-Mailer: KMail [version 1.3.1]
Cc: drepper@redhat.com, linux-kernel@vger.kernel.org, Martin.Wirth@dlr.de,
        pwaechtler@loewe-Komp.de, Rusty Russell <rusty@rustcorp.com.au>
In-Reply-To: <OF5BCED6AA.E62C3259-ON85256B97.00624A9B@raleigh.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020410191011.044393FE06@smtp.linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 April 2002 02:09 pm, Bill Abt wrote:
> On 04/10/2002 at 12:37:53 PM AST, Hubertus Franke <frankeh@watson.ibm.com>
>
> wrote:
> > Can somebody in the thread world weight in what there preferred mechanism
>
> is
>
> > regarding limits etc. Do you need to control the issue on how the signal
>
> is
>
> > delivered? Is a file descriptor good enough or you want a sys_call
>
> interface ?
>
>
> I went thru the POSIX specification and couldn't find any specified limits
> regarding this and in most cases these limits are enforced at the library
> level.  It probably should be left up to the kernel folks to determine the
> kernel limits they can live with.  The library can adapt to this value.  I
> don't believe a pthread library would need any "extra" control of how the
> signal is delivered.  A file descriptor is good enough, seems a waste to
> have to provide a sys_call interface.
>

So you are OK with having only poll  or  select.  That seems odd.
It seems you still need SIGIO on your fd to get the async notification.

> Regards,
>      Bill Abt
>      Senior Software Engineer
>      Next Generation POSIX Threading for Linux
>      IBM Cambridge, MA, USA 02142
>      Ext: +(00)1 617-693-1591
>      T/L: 693-1591 (M/W/F)
>      T/L: 253-9938 (T/Th/Eves.)
>      Cell: +(00)1 617-803-7514
>      babt@us.ibm.com or abt@us.ibm.com
>      http://oss.software.ibm.com/developerworks/opensource/pthreads


-- Hubertus

-- 
-- Hubertus Franke  (frankeh@watson.ibm.com)
