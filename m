Return-Path: <linux-kernel-owner+w=401wt.eu-S965160AbXAGUsy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965160AbXAGUsy (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 15:48:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965162AbXAGUsy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 15:48:54 -0500
Received: from 1wt.eu ([62.212.114.60]:1842 "EHLO 1wt.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965160AbXAGUsy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 15:48:54 -0500
Date: Sun, 7 Jan 2007 21:48:34 +0100
From: Willy Tarreau <w@1wt.eu>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       David Woodhouse <dwmw2@infradead.org>, Tilman Schmidt <tilman@imap.cc>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: OT: character encodings (was: Linux 2.6.20-rc4)
Message-ID: <20070107204834.GU24090@1wt.eu>
References: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org> <Pine.LNX.4.61.0701071152570.4365@yvahk01.tjqt.qr> <20070107114439.GC21613@flint.arm.linux.org.uk> <45A0F060.9090207@imap.cc> <1168182838.14763.24.camel@shinybook.infradead.org> <20070107153833.GA21133@flint.arm.linux.org.uk> <1168187346.14763.70.camel@shinybook.infradead.org> <20070107170656.GC21133@flint.arm.linux.org.uk> <Pine.LNX.4.61.0701072009430.4365@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0701072009430.4365@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 07, 2007 at 08:11:38PM +0100, Jan Engelhardt wrote:
> 
> On Jan 7 2007 17:06, Russell King wrote:
> >On Mon, Jan 08, 2007 at 12:29:05AM +0800, David Woodhouse wrote:
> >
> >$ git log | head -n 1000 | tail -n 200 > o
> >$ file -i o
> >o: text/plain; charset=us-ascii
> >$ git log | head -n 1000 | tail -n 300 > o
> >$ file -i o
> >o: text/plain; charset=us-ascii
> >$ git log | head -n 1000 | tail -n 400 > o
> >$ file -i o
> >o: text/plain; charset=utf-8
> 
> I am inclined to say that "file" does not count, because it tries to guess an
> ambiguous mapping from bytes to character set. Even more, file should be
> _unable at all_ to distinguish an iso-8859-1 from an iso-8859-2 (or worse: 15)
> file. This program is soo... forget it, it's not an argument. It works well for
> headerful files, but text files don't really contain one. The next best thing
> would be html, with a proper <meta http-equiv=Content> tag.

The stupidity from the start up with those character sets is that they
consider that a whole file is written with a given set. In fact, the
charset should apply to characters themselves. At least, the
quoted-printable, non-human friendly, encoding was the least stupid.

Now that UTF8 comes everywhere, everyone receives tons of mangled mails,
and even mailers which correctly support UTF8 and use it by default manage
to shoot themselves in the foot when they reply to, or forward a mail. The
system is completely broken because limited by design, and we have to learn
to live with this brokenness.

Willy

