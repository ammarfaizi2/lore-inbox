Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282277AbRKWWuM>; Fri, 23 Nov 2001 17:50:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282282AbRKWWuG>; Fri, 23 Nov 2001 17:50:06 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:15536 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S282277AbRKWWt4>;
	Fri, 23 Nov 2001 17:49:56 -0500
Date: Fri, 23 Nov 2001 17:49:50 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Phil Sorber <aafes@psu.edu>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH][CFT] Re: 2.4.15-pre9 breakage (inode.c)
In-Reply-To: <1006554935.511.11.camel@praetorian>
Message-ID: <Pine.GSO.4.21.0111231748060.2422-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 23 Nov 2001, Phil Sorber wrote:

> does this affect non-ext2 systems? the only complaints i have seen on
> here were related to ext2, i am running reiserfs, should i have to be
> worried as well?

Same problem.

Trivial workaround to prevent damage is to do sync before umount.  It's
_not_ a real fix, though - just a way to get out of the situation without
fs damage.

For real fix see the last variant posted on l-k.

