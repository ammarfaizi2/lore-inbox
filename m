Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267607AbSKQVvo>; Sun, 17 Nov 2002 16:51:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267611AbSKQVvo>; Sun, 17 Nov 2002 16:51:44 -0500
Received: from mta01ps.bigpond.com ([144.135.25.133]:48352 "EHLO
	mta01ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S267607AbSKQVvn>; Sun, 17 Nov 2002 16:51:43 -0500
From: Brad Hards <bhards@bigpond.net.au>
To: David Lang <dlang@diginsite.com>, ebiederm@xmission.com
Subject: Re: lan based kgdb
Date: Mon, 18 Nov 2002 08:48:40 +1100
User-Agent: KMail/1.4.5
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0211171323360.10200-100000@dlang.diginsite.com>
In-Reply-To: <Pine.LNX.4.44.0211171323360.10200-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200211180848.40509.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Mon, 18 Nov 2002 08:32, David Lang wrote:
> a couple quick questions from an end-user
>
> 1. will an interface be dedicated to this use, or will it share an
> interface with other traffic.
I imagined that it would have to be shared. The world is not a PC, and you 
can't trivially add extra connectivtity to that embedded ARM board...

<snip>
> 3. if we really want to make this limited to the local wire why not use
> something other then UDP? either another IP protocol number (more likly to
> be blocked by routers) or somethign not IP compatable (so that routers
> couldn't forward it if they wanted to). especially if you are talking
> about useing a special (aka stripped down, simplified) stack for this
> interface instead of the full-blown version
If you really want link-local, use the link-local IP addresses (169.254/16). 
See http://files.zeroconf.org/draft-ietf-zeroconf-ipv4-linklocal.txt

(I actually have an implementation of this for linux, alas it is only in 
userspace :)

> normally I would agree that standards are good, becouse they let you
> interoperate with other equipment, but in this case I'm not sure that's
> really what we want. All communications is not IP :-)
All _good_ communication is IP :)

> as someone managing 60 or so remote boxes, this sounds really nice, if it
> can be made to work securely.
OK, I'm confused again. Do you want remote, or to you want link-local?

Brad

- -- 
http://linux.conf.au. 22-25Jan2003. Perth, Aust. I'm registered. Are you?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE92A64W6pHgIdAuOMRArrEAJ9Yp6w85APLudklNBVxfY6nAF066ACfeLc7
z00tKrs79Ri3k7UbFNCQzJo=
=VXrF
-----END PGP SIGNATURE-----

