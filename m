Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262454AbVA0AHF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262454AbVA0AHF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 19:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262528AbVA0AGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 19:06:48 -0500
Received: from turing-police.cirt.vt.edu ([128.173.54.129]:27910 "EHLO
	turing-police.cirt.vt.edu") by vger.kernel.org with ESMTP
	id S262460AbVAZV3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 16:29:20 -0500
Message-Id: <200501261951.j0QJovSn019728@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: John Richard Moser <nigelenki@comcast.net>
Cc: Sytse Wielinga <s.b.wielinga@student.utwente.nl>,
       Linus Torvalds <torvalds@osdl.org>, Bill Davidsen <davidsen@tmr.com>,
       Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues 
In-Reply-To: Your message of "Wed, 26 Jan 2005 14:31:00 EST."
             <41F7EFF4.40303@comcast.net> 
From: Valdis.Kletnieks@vt.edu
References: <1106157152.6310.171.camel@laptopd505.fenrus.org> <200501191947.j0JJlf3j024206@turing-police.cc.vt.edu> <41F6604B.4090905@tmr.com> <Pine.LNX.4.58.0501250741210.2342@ppc970.osdl.org> <41F6816D.1020306@tmr.com> <41F68975.8010405@comcast.net> <Pine.LNX.4.58.0501251025510.2342@ppc970.osdl.org> <41F691D6.8040803@comcast.net> <Pine.LNX.4.58.0501251054400.2342@ppc970.osdl.org> <41F6A5F8.5030100@comcast.net> <20050126160620.GE23182@speedy.student.utwente.nl>
            <41F7EFF4.40303@comcast.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1106769057_13567P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 26 Jan 2005 14:50:57 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1106769057_13567P
Content-Type: text/plain; charset=us-ascii

On Wed, 26 Jan 2005 14:31:00 EST, John Richard Moser said:

> [*] Grsecurity
>   Security Level (Custom)  --->
>   Address Space Protection  --->
>   Role Based Access Control Options  --->
>   Filesystem Protections  --->
>   Kernel Auditing  --->
>   Executable Protections  --->
>   Network Protections  --->
>   Sysctl support  --->
>   Logging Options  --->
> 
> ?? Address Space Protection ??
>  [ ] Deny writing to /dev/kmem, /dev/mem, and /dev/port
>  [ ] Disable privileged I/O
>  [*] Remove addresses from /proc/<pid>/[maps|stat]
>  [*] Deter exploit bruteforcing
>  [*] Hide kernel symbols
> 
> Need I continue?  There's some 30 or 40 more options I could show.  If
> you can't use your enter, left, right, up, y, n, and ? keys, you're
> crippled and won't be able to patch and unpatch crap either.

Just because I can use my arrow keys doesn't mean I can find which part of
a 250,000 line patch broke something.

If it's done as 30 or 40 patches, each of which implements ONE OPTION, then
it's pretty easy to play binary search to find what broke something.

And don't give me "it doesn't break anything" - in the past, I've fed at least
2 bug fixes on things I found broken back to the grsecurity crew (one was a
borkage in the process-ID-randomization code, another was a bad parenthesis
matching breaking the intent of an 'if' in one of the filesystem protection
checks (symlink or fifo or something like that).

--==_Exmh_1106769057_13567P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFB9/ShcC3lWbTT17ARAhHPAJ9j0OSATQn69v3cRYxSMdHtLjSJ9ACeNH3l
erHCFFi7K4vUIyYkj1Pf30E=
=1nLX
-----END PGP SIGNATURE-----

--==_Exmh_1106769057_13567P--
