Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267635AbUH1TSb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267635AbUH1TSb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 15:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267632AbUH1TSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 15:18:30 -0400
Received: from adsl-216-102-214-42.dsl.snfc21.pacbell.net ([216.102.214.42]:10763
	"EHLO cynthia.pants.nu") by vger.kernel.org with ESMTP
	id S267625AbUH1TST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 15:18:19 -0400
Date: Sat, 28 Aug 2004 12:18:15 -0700
From: Brad Boyer <flar@allandria.com>
To: Jeremy Allison <jra@samba.org>
Cc: Christoph Hellwig <hch@infradead.org>, Jamie Lokier <jamie@shareable.org>,
       Rik van Riel <riel@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Diego Calleja <diegocg@teleline.es>, christophe@saout.de,
       vda@port.imtp.ilyichevsk.odessa.ua, christer@weinigel.se,
       spam@tnonline.net, akpm@osdl.org, wichert@wiggy.net, reiser@namesys.com,
       hch@lst.de, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040828191815.GA20865@pants.nu>
References: <Pine.LNX.4.58.0408261217140.2304@ppc970.osdl.org> <Pine.LNX.4.44.0408261607070.27909-100000@chimarrao.boston.redhat.com> <20040826204841.GC5733@mail.shareable.org> <20040826205218.GE1570@legion.cup.hp.com> <20040827101956.B29672@infradead.org> <20040828035629.GE1285@jeremy1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040828035629.GE1285@jeremy1>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2004 at 08:56:29PM -0700, Jeremy Allison wrote:
> I am well aware of what netatalk does. However netatalk
> isn't as widely used as Samba. Things they can get away
> with would cause our user community to flay us alive.
> 
> We need a proper solution, not a nasty hack.
> 
> That's like me telling you to "learn from *BSD". You have
> different user constituencies, you have to serve yours,
> I have to serve mine.

While I do think that there are some hacks in netatalk, the
hacks there are not nearly as bad as the hacks that made it
into the kernel to support exporting a native Mac filesystem.
Take a look at the fork code in the hfs filesystem from 2.4
or before for exporting to netatalk.  It's disgusting, and
mostly because there is no easy way to export the resource
fork and extra metadata that is essential to the client. The
2.6 code doesn't have that anymore, but I don't think it
actually works with netatalk either. Perhaps someone can
correct me on that, but I don't see how it could work.

I would hope that something comes out of this whole discussion
that will allow a much better interface between the hfs/hfsplus
code in the kernel and netatalk.

	Brad Boyer
	flar@allandria.com

