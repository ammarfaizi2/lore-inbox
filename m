Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130372AbRAVFhQ>; Mon, 22 Jan 2001 00:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131167AbRAVFhH>; Mon, 22 Jan 2001 00:37:07 -0500
Received: from exit1.i-55.com ([204.27.97.1]:13027 "EHLO exit1.i-55.com")
	by vger.kernel.org with ESMTP id <S130372AbRAVFg4>;
	Mon, 22 Jan 2001 00:36:56 -0500
Message-ID: <3A6BC565.2EE6E268@mailhost.cs.rose-hulman.edu>
Date: Sun, 21 Jan 2001 23:30:13 -0600
From: Leslie Donaldson <donaldlf@hermes.cs.rose-hulman.edu>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0 alpha)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Hartmann <jhartmann@valinux.com>
CC: Leslie Donaldson <donaldlf@hermes.cs.rose-hulman.edu>,
        "Justin T. Gibbs" <gibbs@scsiguy.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        John Mifsud <john.mifsud@au.interpath.net>,
        Gregory McLean <gregm@comstar.net>, Armin Obersteiner <armin@xos.net>
Subject: Re: Patch for aic7xxx 2.4.0 test12 hang
In-Reply-To: <200101191756.f0JHuns30179@aslan.scsiguy.com> <3A6881F9.17F7B9F6@mailhost.cs.rose-hulman.edu> <3A68AAEC.7@valinux.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Hartmann wrote:
> 
> >> There is also a known issue with U160 modes and the currently
> >> embedded aic7xxx driver.
> >
> >
> > That's true the problem is the TCQ command seems to be sequencing wrong.
> >
> >
> >> You might want to try the Adaptec
> >> supported driver from here:
> >>
> >> http://people.FreeBSD.org/~gibbs/linux/
> >>
> >> 6.09 BETA should be released later today.

> -Jeff

Hello all,
  I included everyone (boy + dog) so everyone knows the result.

 After much testing here is the results. I used the following patch

 linux-aic7xxx-6.0.9BETA-2.4.0.diffs

  against the ne 2.4.0 kernel sans my patch and happy to report it
cleaned
up the TCQ problem. I beat on my scsi system fairly hard.
3 makes of X with -j 10 going. and a a few ls -lR / running
in the background with the periodic sync command.

Know the question left is when will this be part of the kernel. If it is
going
to be a few versions I would like to suggest my patch goes into the
current 2.4.0
and 2.5.0 trees. If this version is fixing to be sent in then forget
about it.
My primary concern is right now the 160M controllers are unstable and
with the new
distributions fixing to roll this is going to cause people to be very
ummm mad.

I leave it up to the powers that be.

Leslie Donaldson

-- 
/----------------------------\ Current Contractor: None
|    Leslie F. Donaldson     | Current Customer  : None
|    Computer Contractor     | Skills:
Unix/OS9/VMS/Linux/SUN-OS/C/C++/assembly
| Have Computer will travel. | WWW  :
http://www.cs.rose-hulman.edu/~donaldlf
\----------------------------/ Email: mail://donaldlf@cs.rose-hulman.edu
Goth Code V1.1: GoCS$$ TYg(T6,T9) B11Bk!^1 C6b-- P0(1,7) M+ a24 n---
b++:+
                H6'11" g m---- w+ r+++ D--~!% h+ s10 k+++ R-- Ssw
LusCA++
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
