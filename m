Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319220AbSHNGJX>; Wed, 14 Aug 2002 02:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319221AbSHNGJX>; Wed, 14 Aug 2002 02:09:23 -0400
Received: from rj.SGI.COM ([192.82.208.96]:43710 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S319220AbSHNGJW>;
	Wed, 14 Aug 2002 02:09:22 -0400
Message-ID: <3D59F536.3FA8454@alphalink.com.au>
Date: Wed, 14 Aug 2002 16:14:14 +1000
From: Greg Banks <gnb@alphalink.com.au>
Organization: Corpus Canem Pty Ltd.
X-Mailer: Mozilla 4.73 [en] (X11; I; Linux 2.2.15-4mdkfb i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
CC: Peter Samuelson <peter@cadcamlab.org>, linux-kernel@vger.kernel.org,
       kbuild-devel@lists.sourceforge.net
Subject: Re: [patch] kernel config 3/N - move sound into drivers/media
References: <Pine.LNX.4.44.0208132342560.32010-100000@chaos.physics.uiowa.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kai Germaschewski wrote:
> 
> On Tue, 13 Aug 2002, Peter Samuelson wrote:
> 
> I think that's exactly where this effort should start. For example, the
> SCSI patch didn't do this, though AFAICS it would be nicely possible to
> unconditionally source drivers/scsi/Config.in and then have the if in
> there.

I like that idea.

> this should also be a nice opportunity to introduce drivers/Config.in and
> remove even more duplication from arch/$ARCH/config.in. It comes of the
> cost of testing for the architecture, since e.g. s390 does not want to
> include most of drivers/*, but that means we'd actually collect this
> knowledge at a centralized place.

<gentle-irony>Oh no the dreaded unified arch tree!</gentle-irony>

Seriously, I think this is perhaps a bit brave in the short term.

> o The trivial patches moving statements like the above into the
>   subsys/Config.in means that all of that file should be indented, which
>   makes the patches look really large, even though they change very
>   little.

I wouldn't be too worried about indentation, it's quite loosely followed
already.  In fact better to do one patch that does the move and a second
larger but provably-trivial patch that fixes up the indentation.

> I have no strong opinion either way, but I'd certainly like
> a drivers/Config.in.

I think it's a great idea whose time has not yet come.

Greg.
-- 
the price of civilisation today is a courageous willingness to prevail,
with force, if necessary, against whatever vicious and uncomprehending
enemies try to strike it down.     - Roger Sandall, The Age, 28Sep2001.
