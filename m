Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261362AbVAGRgf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261362AbVAGRgf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 12:36:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261359AbVAGRgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 12:36:10 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:49101 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261365AbVAGRev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 12:34:51 -0500
Message-ID: <41DEC83D.30105@comcast.net>
Date: Fri, 07 Jan 2005 12:34:53 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7
References: <1105096053.5444.11.camel@ulysse.olympe.o2t> <20050107111508.GA6667@infradead.org> <20050107111751.GA6765@infradead.org>
In-Reply-To: <20050107111751.GA6765@infradead.org>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

My scheme involved a 6 month release cycle supporting kernels with
bugfixes for the prior 18 months (3 releases), though if you're really
committed to hardware driver backporting, I guess it can be done in the
actiwve "Stable" branch.

I really don't like the idea of driver backporting to maintain a
supported tree because A) sometimes drivers can't work without invasive
changes (reiser4); and B) somebody has to do the backporting, which
means somebody may be facing an assload of extra work.

The last 6 paragraphs of [1] sketch it out fine; though the whole
article was pretty much geared towards discussing the Linux Kernel
development model.

I just want a development model that makes everyone happy.  I don't want
to load up maintainers with a billion hours of backporting; but I don't
want to load distributors with excess work either.

Other interesting variations would be to allow driver backporting for
uninvasive drivers, via third party support.  The maintainer would have
to merge drivers into the stable kernel; but it would be up to other OSS
developers (i.e. distributions most likely) to supply those backports.
This would distribute the work.

Oh well, what do I know?   :)

[1] http://woct-blog.blogspot.com/2005/01/finally-new-pax.html

Christoph Hellwig wrote:
| [wrong cc list last time]
|
| On Fri, Jan 07, 2005 at 11:15:08AM +0000, Christoph Hellwig wrote:
|
|>On Fri, Jan 07, 2005 at 12:07:33PM +0100, Nicolas Mailhot wrote:
|>
|>>Hi all,
|>>
|>>Since 2.6 is turning into a continuous release, how about just taking
|>>the last 2.6 release every six months and backport security fixes to it
|>>for the next half year ?
|>
|>Half a year is far too long because hardware is changing to fast for that.
|>Three month sounds like a much better idea.
|>
|>The real problem is that this is a really time-consuming issue, so
|>there need to be people actually commited to doing this kind of thing.
|>
|>Andres Salomon from the Debian Kernel maintaince team has been thinking
|>about such a bugfix tree, but he's worried about having the time to
|>actually get the work done - and we know what we're talking about as
|>we're trying to keep a properly fixed 2.6.8 tree for Debian sarge.
|>
|>-
|>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
|>the body of a message to majordomo@vger.kernel.org
|>More majordomo info at  http://vger.kernel.org/majordomo-info.html
|>Please read the FAQ at  http://www.tux.org/lkml/
|
| ---end quoted text---
| -
| To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
| the body of a message to majordomo@vger.kernel.org
| More majordomo info at  http://vger.kernel.org/majordomo-info.html
| Please read the FAQ at  http://www.tux.org/lkml/
|

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB3sfMhDd4aOud5P8RAnKIAJ0YatkLwCSP9/69aavUBjI7Rxi9RgCfUfB0
X2vS+7BKGJyr2O4X3PWmpXM=
=kbdb
-----END PGP SIGNATURE-----
