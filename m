Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262582AbRE3G6p>; Wed, 30 May 2001 02:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262638AbRE3G6Z>; Wed, 30 May 2001 02:58:25 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:33449 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262582AbRE3G6P>;
	Wed, 30 May 2001 02:58:15 -0400
Date: Wed, 30 May 2001 02:58:10 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andreas Dilger <adilger@turbolinux.com>
cc: Linux kernel development list <linux-kernel@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, torvalds@transmeta.com
Subject: Re: [CHECKER] 84 bugs in 2.4.4/2.4.4-ac8 where NULL pointers are
 deref'd
In-Reply-To: <200105300649.f4U6naMl021300@webber.adilger.int>
Message-ID: <Pine.GSO.4.21.0105300254160.12645-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 30 May 2001, Andreas Dilger wrote:

> > 	b) doesn't fix anything that could be triggered - ext2_delete_entry()
> > can happen only if you've already done lookup. I.e. no problems had been
> > found in that block back when we were finding the entry.
> 
> That means there is no need to check dir in ext2_check_dir_entry(),
> is there?  If all callers to ext2_delete_entry() already verify the
> buffer in ext2_find_entry() (which they appear to do), then there is
> no point in calling ext2_check_dir_entry() at all.

<shrug> modulo memory corruption right under you - yes.

