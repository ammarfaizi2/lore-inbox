Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129584AbRAKAr7>; Wed, 10 Jan 2001 19:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129868AbRAKArs>; Wed, 10 Jan 2001 19:47:48 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:37512 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129584AbRAKArb>;
	Wed, 10 Jan 2001 19:47:31 -0500
Date: Wed, 10 Jan 2001 19:47:23 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Chris Mason <mason@suse.com>
cc: Marc Lehmann <pcg@goof.com>, reiserfs-list@namesys.com,
        linux-kernel@vger.kernel.org, vs@namesys.botik.ru
Subject: Re: [reiserfs-list] major security bug in reiserfs (may affect SuSE
 Linux)
In-Reply-To: <243350000.979152523@tiny>
Message-ID: <Pine.GSO.4.21.0101101945090.13614-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 10 Jan 2001, Chris Mason wrote:

> Ah thanks, that makes more sense.  But, copy_to_user is only working on
> namelen bytes, and reclen is bigger than that.  So, who is checking the
> value for the buf->current_dir pointer?

Look at the thing again. Especially at the place where reclen is calculated.
Notice the calls of put_user() before and after copy_to_user(). Add them
up. Round.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
