Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264505AbUBIKrd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 05:47:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264510AbUBIKrd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 05:47:33 -0500
Received: from 10fwd.cistron-office.nl ([62.216.29.197]:25788 "EHLO
	smtp.cistron-office.nl") by vger.kernel.org with ESMTP
	id S264505AbUBIKrc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 05:47:32 -0500
Date: Mon, 9 Feb 2004 11:47:29 +0100
From: Miquel van Smoorenburg <miquels@cistron.nl>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: Does anyone still care about BSD ptys?
Message-ID: <20040209104729.GA19401@traveler.cistron.net>
Reply-To: linux-kernel@vger.kernel.org
References: <c07c67$vrs$1@terminus.zytor.com> <c07i5r$ctq$1@news.cistron.nl> <20040209100940.GF21151@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20040209100940.GF21151@parcelfarce.linux.theplanet.co.uk> (from viro@parcelfarce.linux.theplanet.co.uk on Mon, Feb 09, 2004 at 11:09:40 +0100)
X-Mailer: Balsa 2.0.16
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004.02.09 11:09, viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Mon, Feb 09, 2004 at 08:59:39AM +0000, Miquel van Smoorenburg wrote:
> > In article <c07c67$vrs$1@terminus.zytor.com>,
> > H. Peter Anvin <hpa@zytor.com> wrote:
> > >Does anyone still care about old-style BSD ptys, i.e. /dev/pty*?  I'm
> > >thinking of restructuring the pty system slightly to make it more
> > >dynamic and to make use of the new larger dev_t, and I'd like to get
> > >rid of the BSD ptys as part of the same patch.
> > 
> > bootlogd(8) which is used by Debian and Suse is started as the
> > first thing at boottime. It needs a pty, and tries to use /dev/pts
> > if it's there but falls back to BSD style pty's if /dev/pts isn't
> > mounted - which will be the case 99% of the time.
> 
> So what's the problem with calling mount(2)?

Well, nothing really, but removing BSD style support in the 2.6 series
now will break existing installations. Doing it in 2.7 would be fine.

Mike.
