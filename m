Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbUBVPl5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 10:41:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261570AbUBVPl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 10:41:57 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:55431 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261567AbUBVPly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 10:41:54 -0500
To: Jamie Lokier <jamie@shareable.org>
Cc: Alex Belits <abelits@phobos.illtel.denver.co.us>,
       =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>,
       linux-kernel@vger.kernel.org
Subject: Re: UTF-8 practically vs. theoretically in the VFS API
References: <20040216222618.GF18853@mail.shareable.org>
	<Pine.LNX.4.58.0402161431260.30742@home.osdl.org>
	<20040217071448.GA8846@schmorp.de>
	<Pine.LNX.4.58.0402170739580.2154@home.osdl.org>
	<20040217161111.GE8231@schmorp.de>
	<Pine.LNX.4.58.0402170820070.2154@home.osdl.org>
	<20040217164651.GB23499@mail.shareable.org>
	<yw1xr7wtcz0n.fsf@ford.guide>
	<20040217205707.GF24311@mail.shareable.org>
	<Pine.LNX.4.58.0402171402460.23115@sm1420.belits.com>
	<20040217214733.GJ24311@mail.shareable.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 22 Feb 2004 08:32:10 -0700
In-Reply-To: <20040217214733.GJ24311@mail.shareable.org>
Message-ID: <m1vflzjfk5.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier <jamie@shareable.org> writes:

> Alex Belits wrote:
> > > No, I think hacking the terminal I/O is the best bet here.  Then _all_
> > > programs which currently work with UTF-8 terminals, which is rapidly
> > > becoming most of them, will work the same with both kinds of terminal,
> > > and the illusion of perfection will be complete and beautiful.
> > 
> >   UTF-8 terminals (and variable-encoding terminals) alreay exist,
> > gnome-terminal is one of them. They are, of course, bloated pigs, but I
> > would rather have the bloat and idiosyncrasy in the user interface where
> > it belongs.
> 
> Yes, I am using it right now.  The fancy characters work well in it.
> Problem is, sometimes I have to use a non-UTF-8 terminal, and I would
> naturally like to access my files in the same way.

Basically I think this is just a matter of modifying telnetd and
sshd so that for the display they follow the users locale,
at least in cooked mode.

Does anyone have a good grasp what the exact semantics should be and
where the translation should happen?  I know we need to delay the
translation as long as possible so we can get binary streams flowing
through these protocols? 

I guess my question is when do we know the information is going to
a terminal so we should translate it?

Eric
