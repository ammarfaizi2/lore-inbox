Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272318AbTGYVLs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 17:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272355AbTGYVIo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 17:08:44 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:48290 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S272333AbTGYUkv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 16:40:51 -0400
Date: Fri, 25 Jul 2003 16:44:36 -0400
From: Ben Collins <bcollins@debian.org>
To: Torrey Hoffman <thoffman@arnor.net>
Cc: Chris Ruvolo <chris+lkml@ruvolo.net>, gaxt <gaxt@rogers.com>,
       Sam Bromley <sbromley@cogeco.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       linux firewire devel <linux1394-devel@lists.sourceforge.net>
Subject: Re: Firewire
Message-ID: <20030725204436.GD535@phunnypharm.org>
References: <20030725160706.GK23196@ruvolo.net> <20030725161803.GJ1512@phunnypharm.org> <1059155483.2525.16.camel@torrey.et.myrio.com> <20030725181303.GO23196@ruvolo.net> <20030725181252.GA607@phunnypharm.org> <3F217A39.2020803@rogers.com> <20030725182642.GD607@phunnypharm.org> <20030725184506.GE607@phunnypharm.org> <20030725193515.GQ23196@ruvolo.net> <1059166095.1465.3.camel@torrey.et.myrio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1059166095.1465.3.camel@torrey.et.myrio.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 25, 2003 at 01:48:16PM -0700, Torrey Hoffman wrote:
> On Fri, 2003-07-25 at 12:35, Chris Ruvolo wrote:
> > On Fri, Jul 25, 2003 at 02:45:06PM -0400, Ben Collins wrote:
> > > Maybe it wont. Try reverting back to stock, and apply this patch. I am
> > > pretty sure this will fix the problem for anyone having this issue.
> > 
> > Yes, I think this did it!  One change: needed to change HSBP_VERBOSE to
> > HSBP_DEBUG in csr.c.  
> > 
> 
> It works for me too... so far at least.  I've attached and mounted my
> external CDRW and 250 GB hard drives and have no errors in the system
> logs...  everything seems to work at first glance.  I will do a little
> stress testing after lunch and let you know how it goes.

Thanks for testing. Really though, you need to use the code in the repo.
I switched to doing the right thing by using mod_timer(). You will hit a
race every so often under heavy load if you don't use the newer code.


-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
