Return-Path: <linux-kernel-owner+w=401wt.eu-S965276AbXAHAm1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965276AbXAHAm1 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 19:42:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965277AbXAHAm1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 19:42:27 -0500
Received: from 1wt.eu ([62.212.114.60]:1849 "EHLO 1wt.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965276AbXAHAm0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 19:42:26 -0500
Date: Mon, 8 Jan 2007 01:38:57 +0100
From: Willy Tarreau <w@1wt.eu>
To: Adrian Bunk <bunk@stusta.de>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       David Woodhouse <dwmw2@infradead.org>, Tilman Schmidt <tilman@imap.cc>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: OT: character encodings (was: Linux 2.6.20-rc4)
Message-ID: <20070108003857.GE435@1wt.eu>
References: <Pine.LNX.4.61.0701071152570.4365@yvahk01.tjqt.qr> <20070107114439.GC21613@flint.arm.linux.org.uk> <45A0F060.9090207@imap.cc> <1168182838.14763.24.camel@shinybook.infradead.org> <20070107153833.GA21133@flint.arm.linux.org.uk> <1168187346.14763.70.camel@shinybook.infradead.org> <20070107170656.GC21133@flint.arm.linux.org.uk> <Pine.LNX.4.61.0701072009430.4365@yvahk01.tjqt.qr> <20070107204834.GU24090@1wt.eu> <20070107233750.GL20714@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070107233750.GL20714@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2007 at 12:37:50AM +0100, Adrian Bunk wrote:
> On Sun, Jan 07, 2007 at 09:48:34PM +0100, Willy Tarreau wrote:
> > On Sun, Jan 07, 2007 at 08:11:38PM +0100, Jan Engelhardt wrote:
> > > 
> > > On Jan 7 2007 17:06, Russell King wrote:
> > > >On Mon, Jan 08, 2007 at 12:29:05AM +0800, David Woodhouse wrote:
> > > >
> > > >$ git log | head -n 1000 | tail -n 200 > o
> > > >$ file -i o
> > > >o: text/plain; charset=us-ascii
> > > >$ git log | head -n 1000 | tail -n 300 > o
> > > >$ file -i o
> > > >o: text/plain; charset=us-ascii
> > > >$ git log | head -n 1000 | tail -n 400 > o
> > > >$ file -i o
> > > >o: text/plain; charset=utf-8
> > > 
> > > I am inclined to say that "file" does not count, because it tries to guess an
> > > ambiguous mapping from bytes to character set. Even more, file should be
> > > _unable at all_ to distinguish an iso-8859-1 from an iso-8859-2 (or worse: 15)
> > > file. This program is soo... forget it, it's not an argument. It works well for
> > > headerful files, but text files don't really contain one. The next best thing
> > > would be html, with a proper <meta http-equiv=Content> tag.
> > 
> > The stupidity from the start up with those character sets is that they
> > consider that a whole file is written with a given set. In fact, the
> > charset should apply to characters themselves. At least, the
> > quoted-printable, non-human friendly, encoding was the least stupid.
> 
> I doubt doing this would really be worth the effort.
> 
> In the 21st century, people should simply use UTF-8.
> 
> > Now that UTF8 comes everywhere, everyone receives tons of mangled mails,
> > and even mailers which correctly support UTF8 and use it by default manage
> > to shoot themselves in the foot when they reply to, or forward a mail. The
> > system is completely broken because limited by design, and we have to learn
> > to live with this brokenness.
> 
> Only if MUAs have broken charset support or don't set a correct 
> "charset" header in the mails they are sending.
> 
> If some software still can't handle UTF-8 correctly more than 10 years 
> after it was introduced, that's not a brokenness you can blame on UTF-8.

I'm not blaming UTF-8 per se, but people who still believe in encoding
*whole documents*. Copy-paste, text insertion, git output, etc... everything
has a good reason not to be in the same encoding as what your MUA believes.
If major MUAs still have problems with UTF-8 10 years after it was introduced,
it's clearly the proof of a flaw in the initial design. And I'm not even
discussing the stupidity which requires that you read a whole text to get
its number of characters !

Willy

