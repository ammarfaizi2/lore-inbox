Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316250AbSFETMJ>; Wed, 5 Jun 2002 15:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316322AbSFETMI>; Wed, 5 Jun 2002 15:12:08 -0400
Received: from twinlark.arctic.org ([208.44.199.239]:41160 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP
	id <S316250AbSFETLr>; Wed, 5 Jun 2002 15:11:47 -0400
Date: Wed, 5 Jun 2002 12:11:48 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Alan Cox <alan@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-pre10-ac2
In-Reply-To: <200206051804.g55I4mK19323@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.44.0206051204070.11987-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

so i haven't had a chance to dig into this further, but i think there may
be some .PRECIOUS foo missing.  i had hit ^C a few times to cancel out a
"make -j3 dep", and a "make -j3 bzImage" while i tweaked other things...
and somehow in the process include/linux/sunrpc/svcsock.h disappeared.

i notice two files where svcsock.h appears on the LHS of a make rule --
.hdepend and tmp_include_depends.  .hdepend has a .PRECIOUS entry, but
tmp_include_depends doesn't.

maybe one of those files wasn't generated properly when i hit ^C during
the "make -j3 dep"?  after the ^C i re-configured and re-did make dep...
but i recall after the make menuconfig it didn't tell me i needed to do
the make dep... and i know it didn't finish the first make dep.

anyhow, sorry i haven't tried to reproduce it, just thought i'd mention it
though.

-dean



