Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265402AbTAGEA1>; Mon, 6 Jan 2003 23:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267285AbTAGEA1>; Mon, 6 Jan 2003 23:00:27 -0500
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:5544 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id <S265402AbTAGEAZ>; Mon, 6 Jan 2003 23:00:25 -0500
Date: Mon, 6 Jan 2003 20:02:30 -0800
From: Joshua Kwan <joshk@mspencer.net>
To: Adam Voigt <adam@cryptocomm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: High FS Activity Crash
Message-Id: <20030106200230.18ac9987.joshk@mspencer.net>
In-Reply-To: <1041861941.13245.26.camel@beowulf.cryptocomm.com>
References: <1041860708.13245.7.camel@beowulf.cryptocomm.com>
	<1041861020.13159.11.camel@beowulf.cryptocomm.com>
	<1041861227.13245.14.camel@beowulf.cryptocomm.com>
	<1041861823.13159.21.camel@beowulf.cryptocomm.com>
	<1041861941.13245.26.camel@beowulf.cryptocomm.com>
X-Mailer: Sylpheed version 0.8.8claws52 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.Tixv3ruV4SDLUO"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.Tixv3ruV4SDLUO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

If the disk is churning and churning, that could be why. Upgrade to a
kernel that has a low latency elevator that makes sure disk thrashing
doesn't kill system performance.

I use 2.4.20-ck2 on my server :)

Regards
Josh

Rabid cheeseburgers forced Adam Voigt<adam@cryptocomm.com> to write this
on 06 Jan 2003 09:05:40-0500:	

> Ok, on my fileserver I'm running Redhat 7.2 with Redhat kernel
> 2.4.7-10 and when I have a large number of people downloading from me
> at one time, Samba, ProFTPD, Apache, and SSH all stop responding, and
> I get the following in my log, the only thing special I could think
> about my setup is I have 3 NIC's bonded together to be load balanced
> on the same IP, any ideas? 
> 
> Jan  6 00:42:39 anubis kernel: Unable to handle kernel NULL pointer
> dereference at virtual address 00000024 
> Jan  6 00:42:39 anubis kernel:  printing eip: 
> Jan  6 00:42:39 anubis kernel: c0135cb0 
> Jan  6 00:42:39 anubis kernel: *pde = 00000000 
> Jan  6 00:42:39 anubis kernel: Oops: 0002 
> Jan  6 00:42:39 anubis kernel: CPU:    0 
> Jan  6 00:42:39 anubis kernel: EIP:   
> 0010:[__remove_from_lru_list+32/112] 
> Jan  6 00:42:39 anubis kernel: EIP:    0010:[<c0135cb0>] 
> Jan  6 00:42:39 anubis kernel: EFLAGS: 00010286 
> Jan  6 00:42:39 anubis kernel: eax: 00000000   ebx: ce310cc0   ecx:
> ce310cc0   edx: c9b708c0 
> Jan  6 00:42:39 anubis kernel: esi: ce310cc0   edi: ce310cc0   ebp:
> 00000000   esp: c1427f28 
> Jan  6 00:42:39 anubis kernel: ds: 0018   es: 0018   ss: 0018 
> Jan  6 00:42:39 anubis kernel: Process kswapd (pid: 5,
> stackpage=c1427000) 
> Jan  6 00:42:39 anubis kernel: Stack: c0135d8d ce310cc0 00000000
> c0138890 ce310cc0 00000003 c1690800 c13f4a64 
> Jan  6 00:42:39 anubis kernel:        00000080 c012cc6a 00000000
> c13f4a64 00000000 00000007 c012cfe3 c13f4a64 
> Jan  6 00:42:39 anubis kernel:        00000080 00000000 00000000
> 0000000d 000093b6 00000000 c0243600 00000000 
> Jan  6 00:42:39 anubis kernel: Call Trace:
> [__remove_from_queues+45/48][try_to_free_buffers+112/272]
> [try_to_release_page+58/96][do_page_launder+851/2112]
> [page_launder+40/96] Jan  6 00:42:39 anubis kernel: Call Trace:
> [<c0135d8d>] [<c0138890>][<c012cc6a>] [<c012cfe3>] [<c012d4f8>] 
> Jan  6 00:42:39 anubis kernel:    [do_try_to_free_pages+18/96]
> [kswapd+94/272] [_stext+0/48] [_stext+0/48] [kernel_thread+38/48]
> [kswapd+0/272] 
> Jan  6 00:42:39 anubis kernel:    [<c012d922>] [<c012d9ce>]
> [<c0105000>][<c0105000>] [<c0105716>] [<c012d970>] 
> Jan  6 00:42:39 anubis kernel: 
> Jan  6 00:42:39 anubis kernel: Code: 89 50 24 8b 44 24 08 8d 14 85 00
> 00 00 00 39 8a 6c 21 2b c0 
> 
> -- 
> Adam Voigt (adam@cryptocomm.com)
> The Cryptocomm Group
> My GPG Key: http://64.238.252.49:8080/adam_at_cryptocomm.asc
> 


-- 
Joshua Kwan
joshk@mspencer.net
pgp public key at http://joshk.mspencer.net/pubkey_gpg.asc
 
It's hard to keep your shirt on when you're getting something off your
chest.

--=.Tixv3ruV4SDLUO
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+GlFY6TRUxq22Mx4RAixDAJ9bGGHnJmiVXJbC66fwCozSE2rMcACfTRI5
+e9jw1sBTnLyMnUCzDF0zjc=
=eIh3
-----END PGP SIGNATURE-----

--=.Tixv3ruV4SDLUO--
