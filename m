Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313445AbSDJSJP>; Wed, 10 Apr 2002 14:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313457AbSDJSJO>; Wed, 10 Apr 2002 14:09:14 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:11762 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S313445AbSDJSJO>; Wed, 10 Apr 2002 14:09:14 -0400
Subject: Re: [PATCH] Futex Generalization Patch
To: frankeh@watson.ibm.com
Cc: drepper@redhat.com, linux-kernel@vger.kernel.org, Martin.Wirth@dlr.de,
        pwaechler@loewe-Komp.de, Rusty Russell <rusty@rustcorp.com.au>
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF5BCED6AA.E62C3259-ON85256B97.00624A9B@raleigh.ibm.com>
From: "Bill Abt" <babt@us.ibm.com>
Date: Wed, 10 Apr 2002 14:09:28 -0400
X-MIMETrack: Serialize by Router on D04NM202/04/M/IBM(Release 5.0.9a |January 7, 2002) at
 04/10/2002 02:09:07 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2002 at 12:37:53 PM AST, Hubertus Franke <frankeh@watson.ibm.com>
wrote:
>
> Can somebody in the thread world weight in what there preferred mechanism
is
> regarding limits etc. Do you need to control the issue on how the signal
is
> delivered? Is a file descriptor good enough or you want a sys_call
interface ?
>

I went thru the POSIX specification and couldn't find any specified limits
regarding this and in most cases these limits are enforced at the library
level.  It probably should be left up to the kernel folks to determine the
kernel limits they can live with.  The library can adapt to this value.  I
don't believe a pthread library would need any "extra" control of how the
signal is delivered.  A file descriptor is good enough, seems a waste to
have to provide a sys_call interface.

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

