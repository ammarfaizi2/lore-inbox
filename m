Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269473AbUICAzi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269473AbUICAzi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 20:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269480AbUICAto
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 20:49:44 -0400
Received: from c002781a.fit.bostream.se ([217.215.235.8]:26011 "EHLO
	mail.tnonline.net") by vger.kernel.org with ESMTP id S269464AbUICAql
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 20:46:41 -0400
Date: Fri, 3 Sep 2004 02:46:29 +0200
From: Spam <spam@tnonline.net>
Reply-To: Spam <spam@tnonline.net>
X-Priority: 3 (Normal)
Message-ID: <793789713.20040903024629@tnonline.net>
To: David Masover <ninja@slaphack.com>
CC: "Martin J. Bligh" <mbligh@aracnet.com>, Hans Reiser <reiser@namesys.com>,
       Linus Torvalds <torvalds@osdl.org>, Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       <viro@parcelfarce.linux.theplanet.co.uk>,
       Christoph Hellwig <hch@lst.de>, <linux-fsdevel@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives
In-Reply-To: <4137BDA7.4040304@slaphack.com>
References: <20040826150202.GE5733@mail.shareable.org>
 <200408282314.i7SNErYv003270@localhost.localdomain>
 <20040901200806.GC31934@mail.shareable.org>
 <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org>
 <20040902002431.GN31934@mail.shareable.org> <413694E6.7010606@slaphack.com>
 <Pine.LNX.4.58.0409012037300.2295@ppc970.osdl.org>
 <4136A14E.9010303@slaphack.com>
 <Pine.LNX.4.58.0409012259340.2295@ppc970.osdl.org>
 <4136C876.5010806@namesys.com>
 <Pine.LNX.4.58.0409020030220.2295@ppc970.osdl.org>
 <4136E0B6.4000705@namesys.com> <14260000.1094149320@flay>
 <4137BDA7.4040304@slaphack.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1

> Martin J. Bligh wrote:
|>>For 30 years nothing much has happened in Unix filesystem semantics
|>>because of sheer cowardice
> |
> |
> | Or because it works fine, and isn't broken.

> Ok, maybe it wasn't cowardice.  Maybe it was laziness.

> Because cowardice tells me that data corruption is bad.  Data corruption
> kills kittens.  End data corruption now!

> Unfortunately, the only way to allow files to survive a crash is to
> implement transactions.  The simplest way is to do it in the filesystem
> and to export an interface to userland.  This is what Hans is doing,
> though AFAIK it's not done yet.

  I thought reiser4 had its journaling and atomic commits. Am I
  mistaken? I run reiser4 as primary fs on my test systems and it seem
  to work as expected.

> Laziness tells me that I should just use Windows anyway, because "it
> works".  Switching to Linux requires training, porting apps requires
> work, and using Linux instead of Windows is a hell of a lot more work
> than just patching programs to do something like

> + start_transaction()
> ~  write()
> ~  blah()
> ~  write()
> + end_transaction()

> How'd you like to be able to tell users "If a file gets corrupted, it's
> either a bug in OpenOffice or your hardware eats data."
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.4 (GNU/Linux)
> Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

> iQIVAwUBQTe9pngHNmZLgCUhAQLTZQ/5AZq31sPKOWB/eI4WtVhM76V2+pmQdfNk
> aZkPtwhZlVrGDJscp45OVNthwMiSskD07om4obUMac79BCmA5805clZ7i0X1uzQB
> SecyX/7XITWz3iwF4VIaxJgDoo7YPFfbpWS0NTmhDJPt6h5Z+goEccLdTABj5kVk
> gbex4xNgXzPrnopvjnWx+K2K3ydvXiX+8bWV200F9S+j0uCObcfSZ357uQPqlReP
> gKQhEs0pCcoQQua81rXJfUhP8hCbegCpUmhJNI0MwoTUvHTnBU/+99+cCsTLR4gN
> 1XlbS9SIaaBXG7/AV9L7iQO5GF1t8mTMSe163EOzZ7ypLDb2km5e7zZ7t2DrA6SE
> Jgd0xT3cHjDgp1b3qhdeWYvt0QVfz5CGaiHukkT4pEOpsrM09BOhDhY72B74swuV
> byDIJ+y4X3J08i/a0zt15hBlVz1FUq7ac7doZZDt3orj93t3B/y4Xpb7tgzVGoWP
> T5AkR+uS5dGRUoMSI/btnPIK4ERlhbwFzCB5lgkas5kjp4dnawIKAk1wxPdhvEle
> g3SsNqSfBsA9hs6tzVw341GaWj6AWV7oOfg3j0c9I+7nt8SX5UeuTCwBWtCuwd/H
> +nnBulusiMnAm3tzQxq8aMpSVAqsZDywjgXSler1mNik4Ow5I5JdXl+Bf2ZWHF+G
> VHk4JVxMt/c=
> =3z3Z
> -----END PGP SIGNATURE-----

