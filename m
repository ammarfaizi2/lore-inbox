Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267190AbUH2Fom@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267190AbUH2Fom (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 01:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266831AbUH2Fom
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 01:44:42 -0400
Received: from dp.samba.org ([66.70.73.150]:18078 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S266679AbUH2Foj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 01:44:39 -0400
Date: Sat, 28 Aug 2004 22:44:37 -0700
From: Jeremy Allison <jra@samba.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: viro@parcelfarce.linux.theplanet.co.uk,
       Helge Hafting <helgehaf@aitel.hist.no>, Rik van Riel <riel@redhat.com>,
       Spam <spam@tnonline.net>, Jamie Lokier <jamie@shareable.org>,
       Hans Reiser <reiser@namesys.com>, David Masover <ninja@slaphack.com>,
       Diego Calleja <diegocg@teleline.es>, christophe@saout.de,
       vda@port.imtp.ilyichevsk.odessa.ua, christer@weinigel.se,
       Andrew Morton <akpm@osdl.org>, wichert@wiggy.net, jra@samba.org,
       hch@lst.de, linux-fsdevel@vger.kernel.org,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, flx@namesys.com,
       reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040829054437.GA8412@jeremy1>
Reply-To: Jeremy Allison <jra@samba.org>
References: <Pine.LNX.4.44.0408272158560.10272-100000@chimarrao.boston.redhat.com> <Pine.LNX.4.58.0408271902410.14196@ppc970.osdl.org> <20040828170515.GB24868@hh.idb.hist.no> <Pine.LNX.4.58.0408281038510.2295@ppc970.osdl.org> <20040828182954.GJ21964@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0408281132480.2295@ppc970.osdl.org> <20040828185613.GK21964@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0408281201290.2295@ppc970.osdl.org> <20040828194526.GL21964@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0408282205170.2295@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408282205170.2295@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2004 at 10:12:39PM -0700, Linus Torvalds wrote:
> 
> If we do expose them in the normal namespace, then ".." should work the
> way the namespace looks: if you do ".." on the "attribute directory" of a
> file, you get the directory that the file was in. Ie an old-style 
> user-space "getcwd()" would give the right path (well, an old-style 
> user-space getcwd() would probably refuse the file on the base that it is 
> S_IFREG, but ignoring that..)

Errr, why don't we check what Solaris does in these cases and
see if that makes sense. They do seem to have made some progress
along this path and it wouldn't make sense to create new semantics
just for the sake of it.

Jeremy.
