Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263898AbTLEHN4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 02:13:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263902AbTLEHN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 02:13:56 -0500
Received: from ahriman.bucharest.roedu.net ([141.85.128.71]:6019 "EHLO
	ahriman.bucharest.roedu.net") by vger.kernel.org with ESMTP
	id S263898AbTLEHNy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 02:13:54 -0500
Date: Fri, 5 Dec 2003 09:14:04 +0200 (EET)
From: Mihai RUSU <dizzy@roedu.net>
X-X-Sender: dizzy@ahriman.bucharest.roedu.net
To: Nathan Scott <nathans@sgi.com>
cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jens Axboe <axboe@suse.de>, Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: kernel BUG at mm/filemap.c:332!
In-Reply-To: <20031204211611.GA567@frodo>
Message-ID: <Pine.LNX.4.56L0.0312050907350.26770@ahriman.bucharest.roedu.net>
References: <Pine.LNX.4.56L0.0312041645560.7551@ahriman.bucharest.roedu.net>
 <Pine.LNX.4.58.0312040834480.2055@home.osdl.org>
 <Pine.LNX.4.56L0.0312041849250.10045@ahriman.bucharest.roedu.net>
 <20031204211611.GA567@frodo>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Fri, 5 Dec 2003, Nathan Scott wrote:

> Was your filesystem near full?  There was a 2.4 deadlock fixed
> recently which could be what you hit there.

No it wasnt. It has a ~50% usage.

> You'll want a more recent 2.4 XFS kernel I suspect - Steve made
> several improvements in this area awhile back.

Ok. I know about improvements since XFS 1.1 and I assumed that using a 
recent (ie 2.6.0-test11) kernel the XFS bits with it whould be recent and 
such have those improvements.

> OK, looks like a default mkfs then (with an old-ish mkfs binary)?

True. Its a general /var partition, there waasnt any interest in giving 
mkfs paramteres for it.

> Newer mkfs' will give you a better AG layout and unwritten extents
> would be turned on - not relevent to this problem at all though.

Ok, noted :)

> An "ls -ld" and "xfs_bmap -v" on the directory would also provide
> me a bit more info to work with -- thanks!

$ ls -ld interfaces/
drwxr-xr-x    2 root     root        16384 Dec  5 09:06 interfaces/

$ /usr/sbin/xfs_bmap interfaces/
interfaces/:
        0: [0..7]: 25238288..25238295
        1: [8..31]: 25238304..25238327


> I have a few ideas about what this might be, let me stew on those
> for a bit and try a few things.

Thanks!

> -- 
> Nathan

- -- 
Mihai RUSU                                    Email: dizzy@roedu.net
GPG : http://dizzy.roedu.net/dizzy-gpg.txt    WWW: http://dizzy.roedu.net
                       "Linux is obsolete" -- AST
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/0DA+PZzOzrZY/1QRAnRoAJ9/VKw3okVloX1gTdayWXf1zxeJqACg1h9S
P9hQSHgK/K1CmlgT9/2L+H8=
=8PPr
-----END PGP SIGNATURE-----
