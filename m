Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267425AbTBISwK>; Sun, 9 Feb 2003 13:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267430AbTBISwJ>; Sun, 9 Feb 2003 13:52:09 -0500
Received: from uswest-dsl-142-38.cortland.com ([209.162.142.38]:56839 "HELO
	warez.scriptkiddie.org") by vger.kernel.org with SMTP
	id <S267425AbTBISwI>; Sun, 9 Feb 2003 13:52:08 -0500
Date: Sun, 9 Feb 2003 11:01:51 -0800 (PST)
From: Lamont Granquist <lamont@scriptkiddie.org>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: Stephen Clark <sclark46@earthlink.net>, <linux-kernel@vger.kernel.org>
Subject: Re: NAT counting
In-Reply-To: <20030206231044.GA8704@hh.idb.hist.no>
Message-ID: <20030209105503.M4561-100000@coredump.scriptkiddie.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 7 Feb 2003, Helge Hafting wrote:
> On Thu, Feb 06, 2003 at 09:46:44AM -0500, Stephen Clark wrote:
> > Hi all,
> >
> > Is Linux being fixed to prevent this?
> >
> >
> > "how to remotely count the number of machines hiding behind a NAT box"
> > <http://www.research.att.com/%7Esmb/papers/fnat.pdf> /
> >
> Not a problem.  The purpose of NAT isn't to "hide" stuff, but
> to share an ipv4 address.  If you need more than that, let a
> firewall mangle your packets in interesting ways.
> You can probably do that with linux if you really want to...

NAT should work correctly though.  It'd be nice if it didn't violate RFC
1323 by having non-monotonically increasing TCP timestamps for machines
that it is NAT'ing.  The RFC 1323 violations are proably just as useful as
the IPid field for this "NAT counting" *and* they can break things in
certain situations (e.g. receiving a SYN to a TIME_WAIT socket with a
smaller TCP timestamp).  I wouldn't mind at all if someone tried to fix
iptables so that it would do all the proper header munging to hide the
fact that there were multiple machines behind it (obviously this would be
slower, so it'd need to be an option that wasn't on by default...)

