Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261348AbVGKJBV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261348AbVGKJBV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 05:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261390AbVGKJBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 05:01:21 -0400
Received: from scrat.hensema.net ([62.212.82.150]:14507 "EHLO
	scrat.hensema.net") by vger.kernel.org with ESMTP id S261348AbVGKJBV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 05:01:21 -0400
From: Erik Hensema <erik@hensema.net>
Subject: Re: reiser4 vs politics: linux misses out again
Date: Mon, 11 Jul 2005 09:01:18 +0000 (UTC)
Message-ID: <slrndd4dau.bct.erik@bender.home.hensema.net>
References: <danen6$h3p$1@sea.gmane.org> <200507100510.j6A5ATun010304@laptop11.inf.utfsm.cl>
Reply-To: erik@hensema.net
User-Agent: slrn/0.9.8.0 (Linux)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand (vonbrand@inf.utfsm.cl):
[on reiserfs4]
>> >>                                                   and _can_ do things
>> >> no other FS can
>
> Mostly useless things...

Depends on your point of view. If you define things to be useful
only when POSIX requires them, then yes, reiser4 contains a lot
of useless stuff.
However, it's the 'beyond POSIX'-stuff what makes reiser4
interesting.

Multistream files have been useful on other OSses for years. They
might be useful on Linux too (Samba will surely like them).

The plugin architecture is very interesting. Sometimes you don't
need files to be in the POSIX namespace. Why would you want to
store a mysql database in files? Why not skip the overhead of the
VFS and POSIX rules and just store them in a more efficient way?
Maybe you can create a swapfile plugin. No need for a swapfile to
be in the POSIX namespace either.
It's just a fun thing to experiment with. It's not always
nescesary to let the demand create the means. Give programmers
some powerful tools and wait and see what wonderful things start
to evolve.

And yes, maybe in ten years time POSIX is just a subsystem in
Linux. Maybe commerciale Unix vendors will start following Linux
as 'the' standard instead of the other way around. Seems fun to
me :-)

I think this debate will mostly boil down to 'do we want to
experiment with beyond-POSIX filesystems in linux?'.
Clearly we don't _need_ it now. There simply are no users. But
will users come when reiser4 is merged? Nobody knows.

IMHO reiser4 should be merged and be marked as experimental. It
should probably _always_ be marked as experimental, because we
_know_ we're going to need some other -- more generic -- API when
we decide we like the features of reiser4. The reiser4 APIs
should probably be implemented as generic VFS APIs. But since we
don't know yet what features we're going to use, let reiser4 be
self contained. Maybe reiser5 or reiser6 will follow standard
VFS-beyond-POSIX rules, with ext4 and JFS2 also implementing them.

It's just too damn hard to predict the future. IMHO better just
merge reiser4 and let it be clear to everybody that reiser4 is an
experiment.
As long as it doesn't affect the rest of the kernel and it's
clear to the users that reiser4 is *not* going to be the
standard, it's fine with me.

-- 
Erik Hensema <erik@hensema.net>
