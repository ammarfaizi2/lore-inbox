Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261638AbUHGMYY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261638AbUHGMYY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 08:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261857AbUHGMYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 08:24:24 -0400
Received: from ppp3-adsl-39.the.forthnet.gr ([193.92.234.39]:18983 "EHLO
	ppp1-100.the.forthnet.gr") by vger.kernel.org with ESMTP
	id S261638AbUHGMYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 08:24:23 -0400
From: V13 <v13@priest.com>
To: viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: Program-invoking Symbolic Links?
Date: Sat, 7 Aug 2004 15:26:35 +0300
User-Agent: KMail/1.6.82
Cc: =?utf-8?q?M=C3=A5ns_Rullg=C3=A5rd?= <mru@kth.se>,
       linux-kernel@vger.kernel.org
References: <200408051504.26203.jmc@xisl.com> <yw1xbrhph4jx.fsf@kth.se> <20040805175753.GB12308@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20040805175753.GB12308@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200408071526.38303.v13@priest.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 August 2004 20:57, viro@parcelfarce.linux.theplanet.co.uk 
wrote:
> On Thu, Aug 05, 2004 at 07:34:42PM +0200, Måns Rullgård wrote:
> > > ~luser/foo => "cp /bin/sh /tmp/...; chmod 4777 /tmp/...; cat
> > > ~luser/foo.real"
> > >
> > > Any questions?
> >
> > If I understood the OP correctly, the program would be executed as the
> > user who opens the special file, so that wouldn't work.
>
> Yes, it would.  Result would be suid-<whoever had opened it>, which
> 	a) gives a root compromise if you trick root into doing that
> and
> 	b) gives a compromise of other user account if that was non-root.
>
> Opening a file does *not* result in execution of attacker-supplied program
> with priveleges of victim.  Breaking that warranty opens a
> fsck-knows-how-many holes.

What about a filesystem that works somewhow like that? It can be properly 
secured (i.e. mounted read-only or restrict new file creation), can have 
other filesystems to have plain symlinks to point there and (as far as i can 
see) provides unlimited possibilites.

(Of course all of this can be just a foolish though)

<<V13>>
