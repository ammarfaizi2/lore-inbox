Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268327AbUIBSYa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268327AbUIBSYa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 14:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268343AbUIBSYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 14:24:16 -0400
Received: from as8-6-1.ens.s.bonet.se ([217.215.92.25]:4790 "EHLO
	zoo.weinigel.se") by vger.kernel.org with ESMTP id S268327AbUIBSXK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 14:23:10 -0400
To: Jamie Lokier <jamie@shareable.org>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       Hans Reiser <reiser@namesys.com>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives (was: silent semantic changes with reiser4)
References: <20040901200806.GC31934@mail.shareable.org>
	<200409021407.i82E70hx004899@laptop11.inf.utfsm.cl>
	<20040902173214.GB24932@mail.shareable.org>
From: Christer Weinigel <christer@weinigel.se>
Organization: Weinigel Ingenjorsbyra AB
Date: 02 Sep 2004 20:23:09 +0200
In-Reply-To: <20040902173214.GB24932@mail.shareable.org>
Message-ID: <m3pt54il82.fsf@zoo.weinigel.se>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier <jamie@shareable.org> writes:

>     1. Local Google (by which I mean a search engine on your local machine),
>        Real-time (by which I mean the results are always up to date):
> 
>        Every file modified since last search is known to the query engine.
>        This is a reality: BeOS does it; WinFS is expected to do it.
> 
>        Thus we have real-time local free text search engine, and other
>        features like searching inside files and for file names.  The
>        point is the real-time nature of it: the results you get
>        correspond to exactly the contents of the filesystem at the time of
>        the query (writes which occur _during_ a query are obviously
>        not coherent with this, but writes which complete before the
>        query, even immediately before, appear in the results).

Can be done with dnotify/inotify and a cache daemon keeping track of
mtime.  Yes, this will need a kernel change to make sure mtime always
changed when the file changes, but it does not require anything else.

>     2. MP3 player scanning artists & titles:

Same.

>     3. Email program scanning for subject lines fast:

Same here.

>     4. Blog server caching built pages:
>     5. Programming environment scanning for tags:
>     6. File transfer program scanning for shared deltas.

And so on.

  /Christer

-- 
"Just how much can I get away with and still go to heaven?"

Freelance consultant specializing in device driver programming for Linux 
Christer Weinigel <christer@weinigel.se>  http://www.weinigel.se
