Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269587AbRHABKE>; Tue, 31 Jul 2001 21:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269586AbRHABJy>; Tue, 31 Jul 2001 21:09:54 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:5616 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S269588AbRHABJl>; Tue, 31 Jul 2001 21:09:41 -0400
Message-ID: <3B675682.3CE51A3D@mvista.com>
Date: Tue, 31 Jul 2001 18:08:18 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jamie Lokier <lk@tantalophile.demon.co.uk>,
        high-res-timers-discourse@lists.sourceforge.net,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        David Schleef <ds@schleef.org>, Mark Salisbury <mbs@mc.com>,
        Jeff Dike <jdike@karaya.com>, schwidefsky@de.ibm.com,
        linux-kernel@vger.kernel.org, Andrew Morton <andrewm@uow.edu.au>
Subject: Re: No 100 HZ timer !
In-Reply-To: <20010410193521.A21133@pcep-jamie.cern.ch> <E14n2hi-0004ma-00@the-village.bc.nu> <20010410202416.A21512@pcep-jamie.cern.ch> <3AD35EFB.40ED7810@mvista.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

I have just posted a patch on sourceforge:
 http://sourceforge.net/projects/high-res-timers

to the 2.4.7 kernel with both ticked and tick less options, switch able
at any time via a /proc interface.  The system is instrumented with
Andrew Mortons time pegs with a couple of enhancements so you can easily
see your clock/ timer overhead (thanks Andrew).

Please take a look at this system and let me know if a tick less system
is worth further effort.  

The testing I have done seems to indicate a lower overhead on a lightly
loaded system, about the same overhead with some load, and much more
overhead with a heavy load.  To me this seems like the wrong thing to
do.  We would like as nearly a flat overhead to load curve as we can get
and the ticked system seems to be much better in this regard.  Still
there may be applications where this works.

comments?  RESULTS?

George
