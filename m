Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267682AbUH1Tlo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267682AbUH1Tlo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 15:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267666AbUH1Tlo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 15:41:44 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:17426 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S267660AbUH1Tlj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 15:41:39 -0400
Date: Sat, 28 Aug 2004 21:41:29 +0200
From: Andries Brouwer <aebr@win.tue.nl>
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
Message-ID: <20040828194129.GA7713@pclin040.win.tue.nl>
References: <Pine.LNX.4.44.0408272158560.10272-100000@chimarrao.boston.redhat.com> <Pine.LNX.4.58.0408271902410.14196@ppc970.osdl.org> <20040828170515.GB24868@hh.idb.hist.no> <Pine.LNX.4.58.0408281038510.2295@ppc970.osdl.org> <20040828182954.GJ21964@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0408281132480.2295@ppc970.osdl.org> <20040828185613.GK21964@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0408281201290.2295@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408281201290.2295@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
X-Spam-DCC: : kweetal.tue.nl 1074; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2004 at 12:16:47PM -0700, Linus Torvalds wrote:

If I see it correctly, you want to group a file and some
ancillary files together.

The Unix way would be to make a directory and put them all there:
	xterm/xterm
	xterm/xterm.icon

But you are unsatisfied and want
	xterm
	xterm/xterm.icon

As long as we agree that the latter really means the former,
there are no problems in finding out what should happen.

The conclusion is, that a directory carries an additional bit
that says "if I am opened as a regular file then use the file
of the same name inside".

Now there is no attribute space, just a shorthand.

Andries
