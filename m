Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262634AbRFGRvK>; Thu, 7 Jun 2001 13:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262684AbRFGRvA>; Thu, 7 Jun 2001 13:51:00 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:34823 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S262634AbRFGRuy>; Thu, 7 Jun 2001 13:50:54 -0400
Date: Thu, 7 Jun 2001 21:48:08 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, Tom Vier <tmv5@home.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        rth@twiddle.net
Subject: Re: [patch] Re: Linux 2.4.5-ac6
Message-ID: <20010607214808.A18298@jurassic.park.msu.ru>
In-Reply-To: <3B1E42EA.B0AE7F6E@mandrakesoft.com> <Pine.GSO.3.96.1010606185833.2113C-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1010606185833.2113C-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Wed, Jun 06, 2001 at 07:26:59PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2001 at 07:26:59PM +0200, Maciej W. Rozycki wrote:
> On Wed, 6 Jun 2001, Jeff Garzik wrote:
> > I had mentioned this to Richard Henderson a while back, when I was
> > wondering how easy it is to implement -taso under Linux, and IIRC he
> > seemed to think that linker tricks were much easier.

Yes, it was discussed on the axp-list a while back. After that I've
hacked the ld for -taso, and it went into official binutils about a year
ago.
$ ld -v
GNU ld version 2.10.91 (with BFD 2.10.91.0.2)
$ ld -help
...
ld: emulation specific options:
elf64alpha: 
  -Bgroup               Selects group name lookup rules for DSO
...
  -taso                 Load executable in the lower 31-bit addressable
                          virtual address range
...

>  Note that personally I'm strongly against the -taso approach -- it's a
> hack to be meant as an excuse for fixing broken programs.

Exactly. However, there are situations when you have only two options:
rewrite from scratch or use -taso. Netscape vs. mozilla is a good example. :-)

Ivan.
