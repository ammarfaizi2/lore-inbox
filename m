Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263491AbSKDAAu>; Sun, 3 Nov 2002 19:00:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263517AbSKDAAu>; Sun, 3 Nov 2002 19:00:50 -0500
Received: from almesberger.net ([63.105.73.239]:9 "EHLO host.almesberger.net")
	by vger.kernel.org with ESMTP id <S263491AbSKDAAt>;
	Sun, 3 Nov 2002 19:00:49 -0500
Date: Sun, 3 Nov 2002 21:06:45 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Dave Jones <davej@codemonkey.org.uk>, Jeff Garzik <jgarzik@pobox.com>,
       Jos Hulzink <josh@stack.nl>, linux-kernel@vger.kernel.org,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: Petition against kernel configuration options madness...
Message-ID: <20021103210645.K2599@almesberger.net>
References: <200211031809.45079.josh@stack.nl> <3DC56270.8040305@pobox.com> <20021103215920.GB733@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021103215920.GB733@suse.de>; from davej@codemonkey.org.uk on Sun, Nov 03, 2002 at 09:59:20PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> Having it documented obviously isn't enough too.

Maybe we need some heuristics for "upgrading" old .config files in
the event of a "make oldconfig". They could be of the form of rules
like this:

CONFIG_obsolete1 && CONFIG_obsolete2 -> CONFIG_new1=y, CONFIG_new2=y

(In a separate file, and entries would be aged. Maybe config tools
could even walk users through this interactively, or flag settings
obtained this way specially, e.g. with a similing wizard icon ;-)
Maybe even add some descriptive text after the rule.)

This still doesn't help for hard to find or obscurely named options,
but at least people upgrading wouldn't be bitten every time something
is renamed or restructured.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
