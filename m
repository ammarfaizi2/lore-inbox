Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267671AbUH1TvW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267671AbUH1TvW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 15:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267696AbUH1Ts6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 15:48:58 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25745 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267671AbUH1Tp3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 15:45:29 -0400
Date: Sat, 28 Aug 2004 20:45:26 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: Helge Hafting <helgehaf@aitel.hist.no>, Rik van Riel <riel@redhat.com>,
       Spam <spam@tnonline.net>, Jamie Lokier <jamie@shareable.org>,
       Hans Reiser <reiser@namesys.com>, David Masover <ninja@slaphack.com>,
       Diego Calleja <diegocg@teleline.es>, christophe@saout.de,
       vda@port.imtp.ilyichevsk.odessa.ua, christer@weinigel.se,
       Andrew Morton <akpm@osdl.org>, wichert@wiggy.net, jra@samba.org,
       hch@lst.de, linux-fsdevel@vger.kernel.org,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, flx@namesys.com,
       reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040828194526.GL21964@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.44.0408272158560.10272-100000@chimarrao.boston.redhat.com> <Pine.LNX.4.58.0408271902410.14196@ppc970.osdl.org> <20040828170515.GB24868@hh.idb.hist.no> <Pine.LNX.4.58.0408281038510.2295@ppc970.osdl.org> <20040828182954.GJ21964@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0408281132480.2295@ppc970.osdl.org> <20040828185613.GK21964@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0408281201290.2295@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408281201290.2295@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2004 at 12:16:47PM -0700, Linus Torvalds wrote:
> So if we do support it, I think we should just make the attribute point
> look exactly like a normal directory, since that path would work as-is. If
> we don't support it (and at directory points), we might want to just
> consider it a special root.
> 
> NOTE! Anybody who tries to use the "getcwd()" string as a real path is 
> already broken - you have pathname permissions that may not make it 
> possible to look up the path you see.

OK, forget getcwd().  What does lookup of .. do from that point?  *Especially*
for stuff you've got from regular files.  That's the decision that needs to
be made.
