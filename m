Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263345AbSKDEwC>; Sun, 3 Nov 2002 23:52:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263366AbSKDEwC>; Sun, 3 Nov 2002 23:52:02 -0500
Received: from pD9E39E8D.dip.t-dialin.net ([217.227.158.141]:51615 "EHLO
	localhost") by vger.kernel.org with ESMTP id <S263345AbSKDEwB>;
	Sun, 3 Nov 2002 23:52:01 -0500
Date: Mon, 4 Nov 2002 05:57:52 +0100
From: Stefan Traby <stefan@hello-penguin.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Patrick Finnegan <pat@purdueriots.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       zippel@linux-m68k.org
Subject: Re: Kconfig (qt) -> Gconfig (gtk)
Message-ID: <20021104045752.GB15844@stefan.atko>
Reply-To: Stefan Traby <stefan@hello-penguin.com>
References: <Pine.LNX.4.44.0211021652470.16432-100000@ibm-ps850.purdueriots.com> <1036277779.16971.76.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1036277779.16971.76.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.5.0-current-20020204i
Organization: Stefan Traby Services && Consulting
X-Operating-System: Linux 2.4.19-stefan (i686)
X-APM: 98% -1 min
X-PGP: Key fingerprint = C090 8941 DAD8 4B09 77B1  E284 7873 9310 3BDB EA79
X-MIL: A-6172171143
X-Lotto: Suggested Lotto numbers (Austrian 6 out of 45): 6 13 18 23 32 38
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 02, 2002 at 10:56:19PM +0000, Alan Cox wrote:
> On Sat, 2002-11-02 at 21:57, Patrick Finnegan wrote:
> > On 2 Nov 2002, Alan Cox wrote:
> > 
> > > On Sat, 2002-11-02 at 20:36, Dr. David Alan Gilbert wrote:
> > > > Oh please....
> > > > Wouldn't it be more helpful to iron the (few) small glitches out of the
> > > > qt based one than write a new one just because you don't happen to like
> > > > the library?
> > >
> > > Lota of installations have gtk but don't have qt.
> > 
> > And a lot of installations have QT but not GTK... This feels like a vi vs
> > emacs discussion.
> 
> It sort of is. The difference being its "do I send you a vi macro or an
> emacs macro", and the obvious answer in this case being that if someone
> wants go write both then we all win.

It's definitely not. The current solution is simply a denial of service
attack, at moment Qt is _required_ for a build, not an optional frontend:

[0]--(16:26:00)-(root@stefan)-(/.localvol000/src/kernel/x/linux-2.5.45)-> make oldconfig
*
* Unable to find the QT installation. Please make sure that the
* QT development package is correctly installed and the QTDIR
* environment variable is set to the correct location.
*
make[1]: *** [scripts/kconfig/.tmp_qtcheck] Fehler 1
make: *** [scripts/kconfig/conf] Fehler 2
[2]--(16:26:05)-(root@stefan)-(/.localvol000/src/kernel/x/linux-2.5.45)-> 

This should not happen. Anyway, Roman did a good job.

-- 

  ciao - 
    Stefan
