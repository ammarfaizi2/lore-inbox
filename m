Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261893AbSJIQfH>; Wed, 9 Oct 2002 12:35:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261896AbSJIQfH>; Wed, 9 Oct 2002 12:35:07 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:50448 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261893AbSJIQfG>; Wed, 9 Oct 2002 12:35:06 -0400
Date: Wed, 9 Oct 2002 17:40:38 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Brendan J Simon <brendan.simon@bigpond.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       kbuild-devel <kbuild-devel@lists.sourceforge.net>
Subject: Re: [kbuild-devel] Re: linux kernel conf 0.8
Message-ID: <20021009174038.A960@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Roman Zippel <zippel@linux-m68k.org>,
	"Randy.Dunlap" <rddunlap@osdl.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	Brendan J Simon <brendan.simon@bigpond.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	kbuild-devel <kbuild-devel@lists.sourceforge.net>
References: <Pine.LNX.4.33L2.0210090816560.1001-100000@dragon.pdx.osdl.net> <Pine.LNX.4.44.0210091818160.338-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0210091818160.338-100000@serv>; from zippel@linux-m68k.org on Wed, Oct 09, 2002 at 06:29:03PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2002 at 06:29:03PM +0200, Roman Zippel wrote:
> Hi,
> 
> On Wed, 9 Oct 2002, Randy.Dunlap wrote:
> 
> > So I think that you and Roman are close to agreement, when Roman
> > has the library backend ready.  Of course someone needs to do a
> > "reference implementation" with it also, but it doesn't need to
> > ship with the kernel.
> 
> We ship BK documentation, so shipping a small QT app can't be that
> problematic. :)
> Creating the library isn't that difficult (kbuild is currently my
> problem here) and I'll still have to write some API documentation for it
> and some glue code to load the library.

Why don't you just separate the library from the kernel at all, making
it a similar package.  We depend on a few external, kernel-specific
packages anyway, and depending on libkconfig wouldn't make the situation
worse.  Instead people could keep their tools build one time around in
/usr/{local/,}bin (especially important with qt-monsters :)) and if
there is a change in the language Documentation/Changes would get
updated to the new required version and people had to update it,
similar to the gcc situation for a new development kernel.

