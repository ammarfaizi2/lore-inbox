Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261231AbVBGSf7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbVBGSf7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 13:35:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261236AbVBGSf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 13:35:58 -0500
Received: from sccrmhc11.comcast.net ([204.127.202.55]:50347 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261231AbVBGSfc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 13:35:32 -0500
Message-ID: <4207B4F5.4050401@comcast.net>
Date: Mon, 07 Feb 2005 13:35:33 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050111)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Peter Busser <busser@m-privacy.de>, linux-kernel@vger.kernel.org
Subject: Re: Sabotaged PaXtest
References: <200501311015.20964.arjan@infradead.org>	 <200501311357.59630.busser@m-privacy.de> <1107189699.4221.124.camel@laptopd505.fenrus.org>
In-Reply-To: <1107189699.4221.124.camel@laptopd505.fenrus.org>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Arjan van de Ven wrote:
> On Mon, 2005-01-31 at 13:57 +0100, Peter Busser wrote:
> 
>>Hi!

[...]

> the paxtest 0.9.6 that John Moser mailed to this list had this gem in
> it:
> @@ -39,8 +42,6 @@
>          */
>         int paxtest_mode = 1;
> 
> +       /* Dummy nested function */
> +       void dummy(void) {}
> 
>         mode = getenv( "PAXTEST_MODE" );
>         if( mode == NULL ) {
> 
> 
> which is clearly there with the only possible function of sabotaging the
> automatic PT_GNU_STACK setting by the toolchain (which btw is not fedora
> specific but happens by all new enough (3.3 or later) gcc compilers on
> all distros) since that requires an executable stack.

I'll say this AGAIN:  I execstack -c'd the directory after the first
borked up test and stuff randomly failed.  After upgrading FC3's kernel
though I got predictable results.


- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCB7T0hDd4aOud5P8RAk7XAJ4oYgr2ySTdg+y80f6pBasO+x8ttACfdjYx
++dQRSTGzTGP/Vsp2KZ6YHU=
=jp9U
-----END PGP SIGNATURE-----
