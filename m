Return-Path: <linux-kernel-owner+w=401wt.eu-S932171AbXACXOc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbXACXOc (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 18:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932175AbXACXOc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 18:14:32 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:55755 "EHLO smtps.tip.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932171AbXACXOb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 18:14:31 -0500
Date: Thu, 4 Jan 2007 10:14:23 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Eric Sandeen <sandeen@sandeen.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] fix memory corruption from misinterpreted bad_inode_ops
 return values
Message-Id: <20070104101423.06bdd664.sfr@canb.auug.org.au>
In-Reply-To: <459BF927.2020108@sandeen.net>
References: <459BF927.2020108@sandeen.net>
X-Mailer: Sylpheed version 2.3.0beta5 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Thu__4_Jan_2007_10_14_23_+1100_Dmcw0cIYQ+Y8STQm"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Thu__4_Jan_2007_10_14_23_+1100_Dmcw0cIYQ+Y8STQm
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi Eric,

On Wed, 03 Jan 2007 12:42:47 -0600 Eric Sandeen <sandeen@sandeen.net> wrote:
>
> So here's the first stab at fixing it.  I'm sure there are style points
> to be hashed out.  Putting all the functions as static inlines in a header
> was just to avoid hundreds of lines of simple function declarations before
> we get to the meat of bad_inode.c, but it's probably technically wrong to
> put it in a header.  Also if putting a copyright on that trivial header file
> is going overboard, just let me know.  Or if anyone has a less verbose
> but still correct way to address this problem, I'm all ears.

Since the only uses of these functions is to take their addresses, the
inline gains you nothing and since the only uses are in the one file, you
should just define them in that file.

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__4_Jan_2007_10_14_23_+1100_Dmcw0cIYQ+Y8STQm
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFFnDjUFdBgD/zoJvwRAob5AJ4pKz9/YueqwjVHivjHRJv8xAHnigCgghPw
tAjuCA9op53L2BGYTqalptk=
=wZYn
-----END PGP SIGNATURE-----

--Signature=_Thu__4_Jan_2007_10_14_23_+1100_Dmcw0cIYQ+Y8STQm--
