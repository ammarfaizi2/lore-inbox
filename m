Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932234AbWFUQeN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbWFUQeN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 12:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932236AbWFUQeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 12:34:13 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:63662 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S932234AbWFUQeM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 12:34:12 -0400
Date: Wed, 21 Jun 2006 18:34:10 +0200
From: Andreas Mohr <andim2@users.sourceforge.net>
To: Bodo Eggert <7eggert@gmx.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, andi@lisas.de,
       Andrew Morton <akpm@osdl.org>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       hal@lists.freedesktop.org
Subject: Re: [linux-usb-devel] USB/hal: USB open() broken? (USB CD burner underruns, USB HDD hard resets)
Message-ID: <20060621163410.GA22736@rhlx01.fht-esslingen.de>
Reply-To: andi@lisas.de
References: <6pnj7-32Q-7@gated-at.bofh.it> <6pJWg-34g-5@gated-at.bofh.it> <6pKfL-3sx-29@gated-at.bofh.it> <6pKpl-3Sx-23@gated-at.bofh.it> <6pLll-5iq-15@gated-at.bofh.it> <E1FsqGX-0001eu-AT@be1.lrz> <1150887236.15275.37.camel@localhost.localdomain> <Pine.LNX.4.58.0606211802590.3817@be1.lrz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0606211802590.3817@be1.lrz>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jun 21, 2006 at 06:16:03PM +0200, Bodo Eggert wrote:
> On Wed, 21 Jun 2006, Alan Cox wrote:
> > Ar Mer, 2006-06-21 am 02:07 +0200, ysgrifennodd Bodo Eggert:
> 
> > > This does not work, since O_EXCL does not work:
> > > http://lkml.org/lkml/2006/2/5/137
> > 
> > It works fine. Its an advisory exclusive locking scheme which is
> > precisely what is needed and precisely how some vendors implement their
> > solution.
> 
> This will be as effective as "/var/lock/please-don't-touch-the-burner",
> and the lock is more portable ...

Indeed, until all(!) relevant apps specify the cooperative O_EXCL flag,
there will always be some trouble left somewhere...
And of course don't even dare trying to do a simply shell cat on the raw
I/O device during an ongoing burning operation, will you!?

Maybe it's better to (additionally?) go down the route of fixing up
low-level communication weaknesses (since it's been semi-confirmed that it's
an USB communication issue, see other thread part).
IMHO this is a severe user experience issue that shouldn't be fixed up
("covered", "hidden") by the O_EXCL thingy alone.

Andreas Mohr
