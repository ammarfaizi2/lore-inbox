Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263595AbTCULny>; Fri, 21 Mar 2003 06:43:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263596AbTCULny>; Fri, 21 Mar 2003 06:43:54 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:55170 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S263595AbTCULnx>; Fri, 21 Mar 2003 06:43:53 -0500
Date: Fri, 21 Mar 2003 11:54:47 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Oleg Drokin <green@namesys.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: reiserfs oops [2.5.65]
Message-ID: <20030321115243.GA6664@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Oleg Drokin <green@namesys.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20030319141048.GA19361@suse.de> <20030320112559.A12732@namesys.com> <20030320132409.GA19042@suse.de> <20030321121454.A17440@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030321121454.A17440@namesys.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 21, 2003 at 12:14:55PM +0300, Oleg Drokin wrote:

 > >  > Hm, very interesting. Thank you.
 > >  > I've seen this once too, but on kernel patched with lots of unrelated and
 > >  > possibly memory corrupting stuff.
 > >  > I will look at it more closely.
 > >  > BTW, it oopsed not in find. Is your box SMP?
 > > Same box committed seppuku overnight, this time in a different way.
 > 
 > Hm, am I missing something?
 > So it died in the morning yesterday, but before that it died again? Or were those
 > two different nights? ;)

two different nights. (with a reboot between them), and again last
night. Seems to die each 6am when the cron jobs run.
if you want, I'll force them to run more often to chase this down / try
out debugging patches etc..
 
 > > There's lots of "slab error in cache_alloc_debugcheck_after()"
 > > warnings. cache reiser_inode_cache memory after object was overwritten
 > This second oops and first BUG you quoted indicate that internal slab structures
 > (I think second oops happened in the middle of list_del) were corrupted, not
 > the guarded data itself.
 > At least I think so.
 > Can I take a look at your .config?

http://www.codemonkey.org.uk/cruft/dotconfig

I'll rebuild that kernel with reiserfs extended checking on later.

		Dave

