Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285972AbSAGTx7>; Mon, 7 Jan 2002 14:53:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286150AbSAGTxt>; Mon, 7 Jan 2002 14:53:49 -0500
Received: from port-213-20-128-16.reverse.qdsl-home.de ([213.20.128.16]:35857
	"EHLO drocklinux.dyndns.org") by vger.kernel.org with ESMTP
	id <S285972AbSAGTxk> convert rfc822-to-8bit; Mon, 7 Jan 2002 14:53:40 -0500
Date: Mon, 07 Jan 2002 20:53:33 +0100 (CET)
Message-Id: <20020107.205333.730578153.rene.rebe@gmx.net>
To: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org
Subject: Re: [announce] [patch] ultra-scalable O(1) SMP and UP scheduler
From: Rene Rebe <rene.rebe@gmx.net>
In-Reply-To: <Pine.LNX.4.33.0201072124380.14212-100000@localhost.localdomain>
In-Reply-To: <20020107.191742.730580837.rene.rebe@gmx.net>
	<Pine.LNX.4.33.0201072124380.14212-100000@localhost.localdomain>
X-Mailer: Mew version 2.1 on XEmacs 21.4.6 (Common Lisp)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [announce] [patch] ultra-scalable O(1) SMP and UP scheduler
Date: Mon, 7 Jan 2002 21:26:06 +0100 (CET)

> 
> please try the -D1 patch i've just uploaded.
> 
> also, i'd suggest to start up your compilation job via something like:
> 
> 	nice -n 19 make bzImage
> 
> please compare both niced and normal compilation as well, and Cc: the
> results back to linux-kernel if you dont mind. Thanks!

Yes. normal load AND nice -n 19 load is handled very well: I have no
longer an interactive problem ;-)

(I wanted to run some latency tests - but since a D2 is out I will do
further tests with this ;-)

> 	Ingo
> 
> On Mon, 7 Jan 2002, Rene Rebe wrote:
> 
> > From: Ingo Molnar <mingo@elte.hu>
> > Subject: Re: [announce] [patch] ultra-scalable O(1) SMP and UP scheduler
> > Date: Mon, 7 Jan 2002 20:40:47 +0100 (CET)
> >
> > >
> > > On Mon, 7 Jan 2002, Rene Rebe wrote:
> > >
> > > > But during higher load (normal gcc compilations are enough) my system
> > > > gets really unresponsive and my mouse-cursor (USB-mouse, XFree-4.1,
> > > > Matrox G450) flickers with ~ 5fps over the screen ... :-((
> > > >
> > > > I'll retry with the D0 patch ;-)
> > >
> > > there was an interactiveness bug in -C1 that is fixed in -D0. Please let
> > > me know if there are still problems with -D0 too. Would you be willing to
> > > test some followup patches if the interactivity problem is still there?
> >
> > Using the D0 patch the interactiveness bug is still there (I verified
> > with patch -R that I really used the D0 patch ... ;-)!
> >
> > It might be related to either disk-io or forking, because:
> >
> > a) When I compile s.th. with many little files (linux-kernel, ALSA)
> > the interactiveness is bad.
> >
> > b) When I compile s.th. with many bigger/complex files (my own C++
> > project) the interactiveness is only bad when: the g++ crunshes small
> > files, between the big files or during linking ...
> >
> > Hm. On the other hand a: "cat /dev/zero > bla" a "cat
> > /mozilla-src.tar.bz2 > /dev/null"; or a "find / -name "*" > /dev/null"
> > doesn't show this behaviour. (btw. I'm running ReiserFS if this
> > matters).
> >
> > I hope this helps - and I'm willing to try other patches you send over
> > ;-)
> >
> > > 	Ingo
> >
> > k33p h4ck1n6
> >   René Rebe
> >
> >
> 
