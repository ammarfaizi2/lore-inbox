Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283097AbRL0XmK>; Thu, 27 Dec 2001 18:42:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283054AbRL0Xl6>; Thu, 27 Dec 2001 18:41:58 -0500
Received: from ns.suse.de ([213.95.15.193]:52489 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S283056AbRL0Xks>;
	Thu, 27 Dec 2001 18:40:48 -0500
Date: Fri, 28 Dec 2001 00:40:47 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: James A Sutherland <james@sutherland.net>
Cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
        Steven Walter <srwalter@yahoo.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] unchecked request_region's in drivers/net
In-Reply-To: <T581707b200ac1785e72b2@pcow029o.blueyonder.co.uk>
Message-ID: <Pine.LNX.4.33.0112280027541.15706-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Dec 2001, James A Sutherland wrote:

> I'd add one level of abstraction: have each filename map to a "module" name.
> In this case, each filename relating to devfs would map to module "devfs";
> there would then be an entry mapping devfs <-> Richard.
> (Perhaps a hierarchy - fs.devfs - with people like Al listed for "fs"?)

Could work, but there are some bits that have no maintainer as such,
eg, the pci irq routing. There have been several interested parties
hacking on it however. A means of having people add themselves to the
list would be a 'must have' feature.

> It should be a little easier having a mapping to a module - in most cases,
> there's a clear "module" to which each file belongs. Then just track who's
> "subscribed to" that module...

Having a mapping from kernel source filename -> email address would
still be preferred personally.

$ cclist devfs

is really not much of an improvement over

$ grep -C3 -i devfs MAINTAINERS

Other than the addition of extra 'interested, cc me too' people.

The only problem with my original idea is that its a pita to keep
up to date. kernel files get added and removed on a weekly (sometimes
daily) basis. Whoever is dumb^Wwonderful enough to volunteer to
maintain such a database is likely to have their work cut out for
them, so maybe your module idea is preferable.

Hmmm..

Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

