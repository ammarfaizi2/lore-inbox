Return-Path: <linux-kernel-owner+w=401wt.eu-S932337AbXADJJO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbXADJJO (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 04:09:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932339AbXADJJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 04:09:14 -0500
Received: from mx33.mail.ru ([194.67.23.194]:2089 "EHLO mx33.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932337AbXADJJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 04:09:12 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] [PATCH] OHCI: disallow autostop when wakeup is not available
Date: Thu, 4 Jan 2007 12:09:08 +0300
User-Agent: KMail/1.9.5
Cc: linux-usb-devel@lists.sourceforge.net,
       Alan Stern <stern@rowland.harvard.edu>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44L0.0701021013470.4122-100000@iolanthe.rowland.org> <200701031350.08679.david-b@pacbell.net>
In-Reply-To: <200701031350.08679.david-b@pacbell.net>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701041209.09081.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Thursday 04 January 2007 00:50, David Brownell wrote:
> On Tuesday 02 January 2007 7:16 am, Alan Stern wrote:
> > On Mon, 1 Jan 2007, Andrey Borzenkov wrote:
> > > Is the original problem (OHCI constantly attempting and failing to
> > > suspend root hub) supposed to be fixed in 2.6.20?
> >
> > No.  It can't be fixed in the kernel because it is a hardware bug.
>
> I'm curious though:  did older kernels, say 2.6.18, have such issues?

Yes. It is hardware problem all right.

[...]
>
> Not just that ... it also fixed the problem where quirk entries
> saying "don't even try using remote wakeup" stopped working.
>

Exactly. I am sorry for being unclear - actually the question was, whether 
quirks are implemented in 2.6.20 (because I remember them being mentioned 
before).

> Once some pending PPC-related OHCI patches merge (support for
> PS3 and other CELL systems), there will be infrastructure that
> makes it easier to add quirk entries that say "this board can't
> do remote wakeup properly".  At that point, we can start to
> collect quirks for boards like this one.
>

OK so this answers the question - it is not yet being implemented.

thank you

- -andrey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFnMQ1R6LMutpd94wRAqayAKDQrqfpERc4F5LjqWMQgI6oxqqOmACdH++H
r6aDgoAQDw2SHRq+2yLaoyw=
=95Oh
-----END PGP SIGNATURE-----
