Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263077AbSJ1Huy>; Mon, 28 Oct 2002 02:50:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263081AbSJ1Huy>; Mon, 28 Oct 2002 02:50:54 -0500
Received: from mta02bw.bigpond.com ([139.134.6.34]:3023 "EHLO
	mta02bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S263077AbSJ1Hux>; Mon, 28 Oct 2002 02:50:53 -0500
From: Brad Hards <bhards@bigpond.net.au>
To: Jeff Garzik <jgarzik@pobox.com>, Peter Chubb <peter@chubb.wattle.id.au>
Subject: Kernel/userspace interfaces (was: Switching from IOCTLs to a RAMFS)
Date: Mon, 28 Oct 2002 17:48:17 +1000
User-Agent: KMail/1.4.5
Cc: linux-kernel@vger.kernel.org, hpa@zytor.com
References: <15804.28536.3553.712306@wombat.chubb.wattle.id.au> <3DBC825C.9060905@pobox.com>
In-Reply-To: <3DBC825C.9060905@pobox.com>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200210281848.17899.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Mon, 28 Oct 2002 11:18, Jeff Garzik wrote:
<stuff about posix_devctl() snipped>
> I sent a comment in to the only email address I could find describing
> the issues (politely!), but as a mere peon I doubt it will have much
> effect.  The best we can do is ignore this POSIX junk and hope it goes
> away...
I'd like something more positive than "hope it goes away"... :-)

This allows me to do my irregular "does anyone care about the kernel ABI / API 
definition?" song'n'dance.

Currently we use standard unix semantics - char devices, block devices, 
sockets, etc. However there is no definition for what that interface actually 
does. We have (most of ?) SUSv3, but there are a lot of other things we're 
doing. Some (many?) of the features aren't getting used because:
1. Not known by userspace programmers.
2. Non-standard semantics and no tutorial / example material.
3. Random changes to features and lack of versioning.

We also have serious problems with management of header files. "Use the 
headers that came with your glibc" misses ioctl() definitions, which are 
inherently kernel interfaces, not glibc interfaces.

I'll again offer to moderate a BoF, at LCA (http://www.linux.conf.au) in 
Perth. I don't have anything like the answers, so its only worth doing if 
someone with a clue is interested. LCA BoFs don't have much time or many 
slots, so if there's a decent amount of interest, it might be worth doing on 
the Tuesday (say for a couple of hours, in the vacant third mini-conf slot). 

Does anyone care?

Brad
- -- 
http://linux.conf.au. 22-25Jan2003. Perth, Aust. I'm registered. Are you?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9vOvBW6pHgIdAuOMRAtmAAKCCb1eWxksZpiVNPjFYERC+79sWSwCgv4a5
RbtwYjH9COJbhKwqBw22hyI=
=HW49
-----END PGP SIGNATURE-----

