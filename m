Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130217AbQKJSa2>; Fri, 10 Nov 2000 13:30:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130819AbQKJSaS>; Fri, 10 Nov 2000 13:30:18 -0500
Received: from smtp.alacritech.com ([209.10.208.82]:51977 "EHLO
	smtp.alacritech.com") by vger.kernel.org with ESMTP
	id <S130217AbQKJSaO>; Fri, 10 Nov 2000 13:30:14 -0500
Message-ID: <3A0C402F.8F0BA261@alacritech.com>
Date: Fri, 10 Nov 2000 10:36:31 -0800
From: "Matt D. Robinson" <yakker@alacritech.com>
Organization: Alacritech, Inc.
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Rohland <cr@sap.com>
CC: "Theodore Y. Ts'o" <tytso@MIT.EDU>, richardj_moore@uk.ibm.com,
        Paul Jakma <paulj@itg.ie>,
        Michael Rothwell <rothwell@holly-springs.nc.us>,
        linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Generalised Kernel Hooks Interface (GKHI)
In-Reply-To: <200011101624.LAA22004@tsx-prime.MIT.EDU> <qww7l6bpyuv.fsf@sap.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Rohland wrote:
> 
> Hi Theodore,
> 
> On Fri, 10 Nov 2000, Theodore Y. Ts'o wrote:
> > P.S.  There are some such RAS features which I wouldn't be surprised
> > there being interest in having integrated into the kernel directly
> > post-2.4, with no need to put in "kernel hooks" for that particular
> > feature.  A good example of that would be kernel crash dumps.  For
> > all Linux houses which are doing support of customers remotely,
> > being able to get a crash dump so that developers can investigate a
> > problem remotely instead of having to fly a developer out to the
> > customer site is invaluable.  In fact, it might be considerd more
> > valuable than the kernel debugger....
> 
> *Yes* :-)

As soon as I finish writing raw write disk routines (not using kiobufs),
we can _maybe_ get LKCD accepted one of these days, especially now that we
don't have to build 'lcrash' against a kernel revision.  I'm in the
middle of putting together raw IDE functions now -- see LKCD mailing
list for details if you're curious.

IMHO, GKHI is a good thing -- it would be great to see this used for
ASSERT() cases (something you can turn on by 'insmod assert.o', which
would then trigger assert conditionals throughout the kernel ...) I
realize it would mean some bloat, and I doubt Linus would accept it,
but it's a nifty concept for enterprise Linux servers (especially
those that want quick answers to system crashes).

--Matt

> Greetings
>                 Christoph
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
