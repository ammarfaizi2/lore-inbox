Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131802AbRAXNUv>; Wed, 24 Jan 2001 08:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131876AbRAXNUl>; Wed, 24 Jan 2001 08:20:41 -0500
Received: from p3EE3CA66.dip.t-dialin.net ([62.227.202.102]:11524 "HELO
	emma1.emma.line.org") by vger.kernel.org with SMTP
	id <S131802AbRAXNUd>; Wed, 24 Jan 2001 08:20:33 -0500
Date: Wed, 24 Jan 2001 14:20:02 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [NFS] Linux 2.2.18 nfs v3 server bug (was: Incompatible: FreeBSD 4.2 client, Linux 2.2.18 nfsv3 server, read-only export)
Message-ID: <20010124142002.A1405@emma1.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20010123015612.H345@quadrajet.flashcom.com> <20010123162930.B5443@emma1.emma.line.org> <wuofwynsj5.fsf_-_@bg.sics.se> <20010123105350.B344@quadrajet.flashcom.com> <20010124041437.A28212@emma1.emma.line.org> <14958.28927.756597.940445@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <14958.28927.756597.940445@notabene.cse.unsw.edu.au>; from neilb@cse.unsw.edu.au on Wed, Jan 24, 2001 at 17:06:55 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jan 2001, Neil Brown wrote:

> freebsd-stable removed!  reiserfs gone. Who goes next:-? Alan?

The bugs, I hope.

> I stuffed up when I tried to interpret the error, but after much
> sensible correction, here is a patch.  Please try it, and suggest any
> other errs that should be tested for (or maybe we should invert the
> sense of the test, and test for error codes that ACCESS is allowed to
> return.

This looks better and it makes FreeBSD able to ls the directory, and on
touch /mnt/try, I get EROFS on the client, so this is okay; however, the
access reply does not include EXECUTE permissions which I find strange,
since the client lists this:

drwxrwxrwt  23 root  wheel  706 Jan  2 11:53 /mnt

Evidently, the directory has execution permissions for everyone.

-- 
Matthias Andree
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
