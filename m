Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261295AbVFZKDb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261295AbVFZKDb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 06:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261340AbVFZKDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 06:03:30 -0400
Received: from [80.71.243.242] ([80.71.243.242]:45493 "EHLO tau.rusteko.ru")
	by vger.kernel.org with ESMTP id S261295AbVFZKD0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 06:03:26 -0400
To: Hubert Chan <hubert@uhoreg.ca>
Cc: Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@osdl.org>,
       Jeff Mahoney <jeffm@suse.de>, penberg@gmail.com, ak@suse.de,
       flx@namesys.com, zam@namesys.com, vs@thebsh.namesys.com,
       linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: -mm -> 2.6.13 merge status
References: <20050620235458.5b437274.akpm@osdl.org.suse.lists.linux.kernel>
	<p73d5qgc67h.fsf@verdi.suse.de> <42B86027.3090001@namesys.com>
	<20050621195642.GD14251@wotan.suse.de> <42B8C0FF.2010800@namesys.com>
	<84144f0205062223226d560e41@mail.gmail.com> <42BB0151.3030904@suse.de>
	<20050623114318.5ae13514.akpm@osdl.org> <20050623193247.GC6814@suse.de>
	<1119717967.9392.2.camel@localhost> <42BDAF3D.6060809@namesys.com>
	<87slz6f0vn.fsf@evinrude.uhoreg.ca>
From: Nikita Danilov <nikita@clusterfs.com>
Date: Sun, 26 Jun 2005 14:03:24 +0400
In-Reply-To: <87slz6f0vn.fsf@evinrude.uhoreg.ca> (Hubert Chan's message of
 "Sat, 25 Jun 2005 19:54:52 -0400")
Message-ID: <m1k6kh1llf.fsf@clusterfs.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.5 (chayote, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hubert Chan <hubert@uhoreg.ca> writes:

> On Sat, 25 Jun 2005 12:23:41 -0700, Hans Reiser <reiser@namesys.com> said:
>
>>>> assert("trace_hash-89", is_hashed(foo) != 0);
>
>> Lots of people like corporate anonymity.  Some don't.  I don't.  I
>> like knowing who wrote what. ...
>
> For what it's worth (I know: not much), I like the named asserts in
> Reiser4/Reiserfs.  Although I haven't been bitten by any BUGs yet (maybe
> I'm just lucky), whenever I see these on the mailing list, it gives the
> impression that the users are interacting more directly with the
> developers, and it helps us to get to know the developers better.
>
> If people really want more standard-looking identifiers, I think Namesys
> should keep the names and make a hybrid identifier, like
> "nikita-123(<file>:<line>)"

This already happens: together with <uid>-<serial>, reiser4 outputs
__FILE__, __LINE__, __FUNCTION__, and a bunch of other stuff:

----------------------------------------------------------------------
reiser4[xine(11262)]: txn_end (fs/reiser4/txnmgr.c:504)[nominaodiosasunt-2967]:
code: -2 at fs/reiser4/search.c:1285
reiser4 panicked cowardly: assertion failed: lock_stack_isclean(get_current_lock_stack())
----------------------------------------------------------------------

Nikita.
