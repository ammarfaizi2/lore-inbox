Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267607AbUH2KvQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267607AbUH2KvQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 06:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267623AbUH2KvQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 06:51:16 -0400
Received: from nessie.weebeastie.net ([220.233.7.36]:12952 "EHLO
	theirongiant.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id S267607AbUH2KvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 06:51:07 -0400
Date: Sun, 29 Aug 2004 20:44:13 +1000
From: CaT <cat@zip.com.au>
To: Hans Reiser <reiser@namesys.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Helge Hafting <helgehaf@aitel.hist.no>,
       Rik van Riel <riel@redhat.com>, Spam <spam@tnonline.net>,
       Jamie Lokier <jamie@shareable.org>, David Masover <ninja@slaphack.com>,
       Diego Calleja <diegocg@teleline.es>, christophe@saout.de,
       vda@port.imtp.ilyichevsk.odessa.ua, christer@weinigel.se,
       Andrew Morton <akpm@osdl.org>, wichert@wiggy.net, jra@samba.org,
       hch@lst.de, linux-fsdevel@vger.kernel.org,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, flx@namesys.com,
       reiserfs-list@namesys.com,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040829104413.GE871@zip.com.au>
References: <Pine.LNX.4.44.0408272158560.10272-100000@chimarrao.boston.redhat.com> <Pine.LNX.4.58.0408271902410.14196@ppc970.osdl.org> <20040828170515.GB24868@hh.idb.hist.no> <Pine.LNX.4.58.0408281038510.2295@ppc970.osdl.org> <4131074D.7050209@namesys.com> <Pine.LNX.4.58.0408282159510.2295@ppc970.osdl.org> <4131A3B2.30203@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4131A3B2.30203@namesys.com>
Organisation: Furball Inc.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 29, 2004 at 02:36:50AM -0700, Hans Reiser wrote:
> Linus Torvalds wrote:
> >On Sat, 28 Aug 2004, Hans Reiser wrote:
> >>I object to openat().....
> >
> >Sound slike you object to O_XATTRS, not openat() itself.
> >
> >Realize that openat() works independently of any special streams, it's
> >fundamentally a "look up name starting from this file" (rather than
> >"starting from root" or "starting from cwd").
>
> well, isn't that namespace fragmentation by definition?  If you can't go
> 
> cat filenameA/metas/permissions > filenameB/metas/permissions
> 
> find / -exec cat {}/permissions \; | grep 4777 | wc -l

My apologies if this question has been raised (and answered) elsewhere.
I tried to keep up with the flamefest/discussion but it wasn't always
possible.

How would you do it for directories without making certain names
illegal? ie taking the above you'd do:

cat dirA/metas/permissions > dirB/metas/permissions

But how does that distinguish an access to the metas for dirA and dirB
from an access to a file called permissions within the metas directories
of dirA and dirB?

I think what Linus is trying to do, as far as naming, is create a
consistant access scheme that works for all types of objects in the
fs without making certain names illegal (and with plugins, those
names are not even a fixed thing I believe).

Feel free to correct me if I'm wrong, ofcourse. :)

-- 
    Red herrings strewn hither and yon.
