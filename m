Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266526AbUFQP1N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266526AbUFQP1N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 11:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266539AbUFQP1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 11:27:13 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:6294 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S266526AbUFQP1J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 11:27:09 -0400
Date: Fri, 18 Jun 2004 01:27:03 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org, viro@math.psu.edu
Subject: Re: Patch: 2.6.7/fs/dnotify.c - make dn_lock a regular spinlock
Message-Id: <20040618012703.77b441c9.sfr@canb.auug.org.au>
In-Reply-To: <20040617163826.A4558@freya>
References: <20040617163826.A4558@freya>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Fri__18_Jun_2004_01_27_03_+1000_3DnSlpouTG/2QNV5"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Fri__18_Jun_2004_01_27_03_+1000_3DnSlpouTG/2QNV5
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi Adam,

On Thu, 17 Jun 2004 16:38:26 -0700 "Adam J. Richter" <adam@yggdrasil.com> wrote:
>
> 	In linux-2.6.7/fs/dnotify.c, the local varible dn_lock is
> declared as rw_lock_t, but the lock is only taken exclusively.
> So, let's "document" this fact, save a few bytes and save a few
> cycles by changing it to spinlock_t.

Fine by me, but other opinions are always welcome.

> 	If this patch looks acceptable to you, could you please
> tell the appropriate person to integrate it or advise me what to
> do if you want me to proceed some other way?  I don't know if you
> submit your patches directly to Linus or through someone else,
> like Al Viro.

Well, Al was the last to modify the dnotify code, if memory serves.
Getting his OK is always a good idea for this sort of thing.  Otherwise,
fine my me.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__18_Jun_2004_01_27_03_+1000_3DnSlpouTG/2QNV5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA0bhHFG47PeJeR58RAgowAJ9ENP4BuZ/gCsSIROKVMKHcXAT9qACgwHXL
Y2Q6J1SupM3Nr74z0BZBBmk=
=0k5C
-----END PGP SIGNATURE-----

--Signature=_Fri__18_Jun_2004_01_27_03_+1000_3DnSlpouTG/2QNV5--
