Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266174AbUBKUd0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 15:33:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266184AbUBKUdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 15:33:25 -0500
Received: from brmea-mail-3.Sun.COM ([192.18.98.34]:58068 "EHLO
	brmea-mail-3.sun.com") by vger.kernel.org with ESMTP
	id S266174AbUBKUdX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 15:33:23 -0500
Date: Wed, 11 Feb 2004 12:33:06 -0800
From: Tim Hockin <thockin@sun.com>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, viro@math.psu.edu
Subject: Re: PATCH - raise max_anon limit
Message-ID: <20040211203306.GI9155@sun.com>
Reply-To: thockin@sun.com
References: <20040206221545.GD9155@sun.com> <20040207005505.784307b8.akpm@osdl.org> <20040207094846.GZ21151@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040207094846.GZ21151@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 07, 2004 at 09:48:47AM +0000, viro@parcelfarce.linux.theplanet.co.uk wrote:
> > It would be better to lose the sysctl and do it all dynamically.
> > 
> > Options are:
> > 
> > a) realloc the bitmap when it fills up
> > 
> >    Simple, a bit crufty, doesn't release memory.

This can work if it's OK to allocate pages during set_max_anon() (which
includes changing the spinlock to a sema or always allocating before the
lock).

> d) grab a couple of pages and be done with that.  That gives us 64Kbits.

Maybe that is just the simplest answer?  It can be a simple constant that is
changeable at compile time, and leave it at that

What's most likely to cause the least argument?

> PS: psu.edu address is still valid, but I rarely read that mailbox...

Sorry - it's what was listed in MAINTAINERS, so I used it.

Tim
-- 
Tim Hockin
Sun Microsystems, Linux Software Engineering
thockin@sun.com
All opinions are my own, not Sun's
