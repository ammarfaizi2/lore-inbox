Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262422AbTJFRm3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 13:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262449AbTJFRm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 13:42:29 -0400
Received: from ldap.somanetworks.com ([216.126.67.42]:20412 "EHLO
	mail.somanetworks.com") by vger.kernel.org with ESMTP
	id S262422AbTJFRmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 13:42:24 -0400
Date: Mon, 6 Oct 2003 13:42:15 -0400
From: Georg Nikodym <georgn@somanetworks.com>
To: Jan Schubert <Jan.Schubert@GMX.li>
Cc: Massimo Dal Zotto <dz@debian.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0_test6: CONFIG_I8K produces wrong/no keycodes for special
 buttons
Message-Id: <20031006134215.7b857e06.georgn@somanetworks.com>
In-Reply-To: <3F814B37.5040009@GMX.li>
References: <200310061034.h96AYGVP021010@dizzy.dz.net>
	<3F814B37.5040009@GMX.li>
Organization: SOMA Networks
X-Mailer: Sylpheed version 0.9.5claws28 (GTK+ 1.2.10; i386-pc-linux-gnu)
X-Face: #EE>^U0b8z^y>O0BZ>JJMGXyyxSP?<W-(g1&Yh;2p1'N6AeM]{Zfu(v>Uhe8ptGua4P}`QZ
 m%yb7CYwN^TiGQcP&mncyDrjAtLh7cB|m{$C,ww;yaYi*YvQllxb*vet
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Mon__6_Oct_2003_13_42_15_-0400_nAiTl.MswtSWsBaI"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Mon__6_Oct_2003_13_42_15_-0400_nAiTl.MswtSWsBaI
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Mon, 06 Oct 2003 13:00:07 +0200
Jan Schubert <Jan.Schubert@GMX.li> wrote:

> Massimo Dal Zotto wrote:
> 
> >The inspiron 8000 has 4 multimedia buttons, 2 volume buttons and 3
> >Fn-key combinations. Other Dell laptops have only one or two buttons.
> >
> >The multimedia buttons generate the following raw scancodes which can
> >be dumped with showkey -s:
> >
> >    0xe0 0x01	play
> >    0xe0 0x02	stop
> >    0xe0 0x03	back
> >    0xe0 0x04	forward
> >
> >Since the raw scancodes are generate by the keyboard like any other
> >key they should be handled by the 2.6.0 kernel as in 2.4.x. If this
> >doesn't work it is a bug in the kernel. Did you try showkey -s with
> >2.6.0?
> >

For the keys that show nothing, if you look at /var/log/messages, I
think you'll see something like:

> This is what i get:
> play - <nothing>

Oct  6 13:39:24 keller kernel: atkbd.c: Unknown key pressed (translated set 2, code 0x176, data 0x1, on isa0060/serio0).
Oct  6 13:39:24 keller kernel: atkbd.c: Unknown key released (translated set 2, code 0x176, data 0x81, on isa0060/serio0).


> Stop -
> 0xe0 0x22
> 0xe0 0xa2
> back - <nothing>

Oct  6 13:39:29 keller kernel: atkbd.c: Unknown key pressed (translated set 2, code 0x11e, data 0x3, on isa0060/serio0).
Oct  6 13:39:29 keller kernel: atkbd.c: Unknown key released (translated set 2, code 0x11e, data 0x83, on isa0060/serio0).

> forward-
> 0x6a
> 0xea

-g (who's been too lazy to attempt the atkbd.c patchery needed to fix this)

--Signature=_Mon__6_Oct_2003_13_42_15_-0400_nAiTl.MswtSWsBaI
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/gal7oJNnikTddkMRAkY6AJ99TFYlhaVRap+fudcQiCgU2yf7uACeLTdC
CMFMX1OVagkT3kVVhEKBr+E=
=iJbm
-----END PGP SIGNATURE-----

--Signature=_Mon__6_Oct_2003_13_42_15_-0400_nAiTl.MswtSWsBaI--
