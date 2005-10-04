Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964810AbVJDPj3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964810AbVJDPj3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 11:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964812AbVJDPj3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 11:39:29 -0400
Received: from h80ad24ca.async.vt.edu ([128.173.36.202]:29841 "EHLO
	h80ad24ca.async.vt.edu") by vger.kernel.org with ESMTP
	id S964810AbVJDPj2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 11:39:28 -0400
Message-Id: <200510041539.j94FdJmO028772@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: John Richard Moser <nigelenki@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: The price of SELinux (CPU) 
In-Reply-To: Your message of "Tue, 04 Oct 2005 00:28:40 EDT."
             <434204F8.2030209@comcast.net> 
From: Valdis.Kletnieks@vt.edu
References: <434204F8.2030209@comcast.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1128440359_2862P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 04 Oct 2005 11:39:19 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1128440359_2862P
Content-Type: text/plain; charset=us-ascii

On Tue, 04 Oct 2005 00:28:40 EDT, John Richard Moser said:

> At any rate, my personal end goal is a secure high-performance operating
> system, as user friendly as 

Step 0: Sooner or later, "secure" and "user friendly" *will* come into conflict.
At that point, you have to make a choice. Note that in many cases, we *made* the
choice years or even decades ago, and we've gotten used to the choices made.
For instance, you'd certainly get better performance and user friendliness if
you just stubbed out permission() in fs/namei.c and capable(), and just had them
return "let the guy do it".  But somehow, I don't think anybody would find that
very palatable.

Similarly, the stuff that comes out of Redmond, in general, has security issues
precisely because they chose "user friendly" when they got to Step 0.  Being
able to put Javascript and/or executable binaries in e-mail for automatic
execution is certainly user-friendly - but it's not secure.

In any case, the overhead isn't 7%.  If anything, it's probably closer to 0.7%,
and dropping with each kernel release as the code gets tuned and optimized even
more.  And beware the impact of micro-optimizations and macro-performance - there
was recently a code change to reduce the number and size of avtab entries.  That
slowed down the actual code path slightly, but overall was actually a performance
win, especially on smaller memory-constrained machines, due to the drastic drop
in overall slab consumption.

And remember - the first time that a security system prevents (for example) an
exploit against an Apache bug from being used to take over a system, it's paid
for itself.  When the FBI faxes you that "Hold Evidence" order, it means you may
not be seeing that server again for weeks, if ever.....

--==_Exmh_1128440359_2862P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDQqIncC3lWbTT17ARAsUqAKDXOYxL1PWsFFPnuBtpv/dBYZ7iqwCg6u1B
JpK5u42qBpJjdA0alwcxxpI=
=iZNh
-----END PGP SIGNATURE-----

--==_Exmh_1128440359_2862P--
