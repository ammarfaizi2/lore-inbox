Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272546AbTGaP2S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 11:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272545AbTGaP1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 11:27:09 -0400
Received: from fed1mtao05.cox.net ([68.6.19.126]:33248 "EHLO
	fed1mtao05.cox.net") by vger.kernel.org with ESMTP id S272546AbTGaPY5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 11:24:57 -0400
Date: Thu, 31 Jul 2003 08:24:55 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Miles Bader <miles@gnu.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Bernardo Innocenti <bernie@develer.com>,
       Willy Tarreau <willy@w.ods.org>, Christoph Hellwig <hch@lst.de>,
       uClinux development list <uclinux-dev@uclinux.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel 2.6 size increase
Message-ID: <20030731152455.GE27214@ip68-0-152-218.tc.ph.cox.net>
References: <20030723222747.GF643@alpha.home.local> <200307242227.16439.bernie@develer.com> <20030729222921.GK16051@ip68-0-152-218.tc.ph.cox.net> <1059518889.6838.19.camel@dhcp22.swansea.linux.org.uk> <20030729230657.GL16051@ip68-0-152-218.tc.ph.cox.net> <buoptjsepib.fsf@mcspd15.ucom.lsi.nec.co.jp> <20030730153311.GA27214@ip68-0-152-218.tc.ph.cox.net> <buoel07tqi5.fsf@mcspd15.ucom.lsi.nec.co.jp> <20030731041743.GD27214@ip68-0-152-218.tc.ph.cox.net> <buo1xw7thi1.fsf@mcspd15.ucom.lsi.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <buo1xw7thi1.fsf@mcspd15.ucom.lsi.nec.co.jp>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 31, 2003 at 02:03:34PM +0900, Miles Bader wrote:
> Tom Rini <trini@kernel.crashing.org> writes:
> > > The point was that in _some_ embedded systems, the space-savings is
> > > wanted, and so a useful thing for linux to support.
> > 
> > As has been pointed out, there's things like the block layer that aren't
> > needed if you have just a subset of common embedded-device filesystems and
> > some network stuff seems to have creeped back in.  All I'm trying to say
> > is that before you go too far down the CONFIG_SYSFS route, investigate the
> > others first as there's a fair chance of saving even more.
> 
> I'm not really trying to defend this particular config option, just
> saying that the attitude of `why bother trying to cut down, it's more
> featureful to include everything!' is not always valid.

I hate email sometimes.  My attitude is "some things you really can't
cut out".  I really am all for trying to cut things out, it's just that
some things are tied in rather well (like sysfs and root device as
opposed to the static table before).

> You may very well be right that other subsystems offer better
> gain/pain, and I'm all for attacking the low-hanging-fruit first.
> 
> > To what end?  One of the things we (== PPC folks) at OLS was that, wow,
> > doing PM as some sort of one-off sucks, and if at all possible we want
> > to get device information (and pm dependancies) passed in so we can tell
> > sysfs and get any shared driver done right for free, among other
> > reasons.
> 
> [What's PM?  Power Management?  What does that have to do with anything?]

Power Management, sysfs plays / will play a role in finding out the order
in which devices get powered down.  This is important on some types of
embedded devices (and arguably important everywhere).

-- 
Tom Rini
http://gate.crashing.org/~trini/
