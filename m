Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278449AbRJVJzd>; Mon, 22 Oct 2001 05:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278464AbRJVJzX>; Mon, 22 Oct 2001 05:55:23 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:65475 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S278449AbRJVJzM>;
	Mon, 22 Oct 2001 05:55:12 -0400
Date: Mon, 22 Oct 2001 05:55:47 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Keith Owens <kaos@ocs.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] binfmt_misc.c, kernel-2.4.12 
In-Reply-To: <Pine.GSO.4.21.0110220526480.2294-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0110220543140.2294-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


While we are at it, that would also fix the idiocy with "v7 and sysvfs live
in the same module, need to edit modules.conf to make mount -t v7 ... work".
I can easily think of many other examples of that sort.  Hell, after a
look at /etc/modules.conf on a Debian box...  And yes, stuff with default
options for soundcards... _ouch_

Is there any chance to get that done in 2.4?  Removal of defaults from
modprobe binary is a different story, but at least getting rid of
temptation to add new ones would be a Nice Thing(tm).  Adding relevant
stuff on the kernel side wouldn't break anything and could be tested
gradually...

I'm more than willing to help with that; if you start doing something
of that kind in 2.4 - count me in.  AFAICS it can be done without
breaking compatibility and it's long overdue.

