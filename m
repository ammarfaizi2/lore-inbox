Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261944AbUBWQdL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 11:33:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbUBWQdK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 11:33:10 -0500
Received: from terra.irts.fr ([194.206.161.9]:24002 "EHLO ns1.terranet.fr")
	by vger.kernel.org with ESMTP id S261944AbUBWQc6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 11:32:58 -0500
Message-ID: <403A2ADB.9040002@laposte.net>
Date: Mon, 23 Feb 2004 17:31:23 +0100
From: MALET JL <malet.jean-luc@laposte.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; fr-FR; rv:1.5) Gecko/20031007
X-Accept-Language: fr, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [linux 2.6.3] [gcc 3.3.3] compile errors
X-Priority: 2 (high)
References: <403911B3.10601@laposte.net> <20040223074221.5f711665.rddunlap@osdl.org>
In-Reply-To: <20040223074221.5f711665.rddunlap@osdl.org>
X-Enigmail-Version: 0.82.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig661E68A84254A97C3D3E9ADB"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig661E68A84254A97C3D3E9ADB
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Randy.Dunlap a écrit :

>On Sun, 22 Feb 2004 21:31:47 +0100 mjl <malet.jean-luc@laposte.net> wrote:
>
>| hello please cc me since I'm not a member
>| all my builds fails with this error
>| 
>| In file included from ../include/swab.h:20,
>|                  from ../include/misc.h:12,
>|                  from io.c:21:
>| /usr/include/linux/byteorder/swab.h:133: error: syntax error before "__u16"
>| /usr/include/linux/byteorder/swab.h:146: error: syntax error before "__u32"
>
>You are using userspace headers for building the kernel.
>Maybe you have a symbolic link from linux/include/asm to the
>userspace headers.  If so, Don't Do That.
>In any case, don't use userspace headers to build the kernel.
>  
>
the problem is that this is a part of compile log from a userspace 
program....... I builded the kernel right but can't compile some 
userspace programs (such as Mplayer, linux-utils.....)
the configuration I use :
copy from /usr/src/linux/include/asm to /usr/include/asm
copy from /usr/src/linux/include/asm-generic to /usr/include/asm-generic
copy from /usr/src/linux/include/linux to /usr/include/linux

is this wrong ? I've done this all the time (since 2.4.2 kernel) without 
problem..... if i'm wrong please correct my behaviour

>
>| make[1]: *** [io.o] Error 1
>| make[1]: Leaving directory `/usr/src/sorcery/reiserfsprogs-3.6.13/lib'
>| make: *** [all-recursive] Error 1
>| 
>| 
>| I looked into the source and  the line is
>| 
>| 
>| static __inline__ __attribute_const__ __u16 __fswab16(__u16 x)
>| {
>| 
>| 
>| which don't looks bad ......
>
>
>
>--
>~Randy
>  
>


--------------enig661E68A84254A97C3D3E9ADB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD4DBQFAOirbcl3j/qUaL14RApSnAKC7g0SLCMbodzQ/ck+yJAHhtVAZFACY6yEb
09nhARMI0pgNv9wWm8UJ/w==
=kB+X
-----END PGP SIGNATURE-----

--------------enig661E68A84254A97C3D3E9ADB--

