Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292178AbSCSTjs>; Tue, 19 Mar 2002 14:39:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292231AbSCSTjm>; Tue, 19 Mar 2002 14:39:42 -0500
Received: from [12.150.248.132] ([12.150.248.132]:63581 "EHLO
	dhcp-177.hsv.redhat.com") by vger.kernel.org with ESMTP
	id <S292178AbSCSTjT>; Tue, 19 Mar 2002 14:39:19 -0500
Date: Tue, 19 Mar 2002 13:38:06 -0600
From: Tommy Reynolds <reynolds@redhat.com>
To: "chiranjeevi vaka" <cvaka_kernel@yahoo.com>
Cc: washer@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: using kmalloc
Message-Id: <20020319133806.13a40872.reynolds@redhat.com>
In-Reply-To: <20020319192644.9097.qmail@web21304.mail.yahoo.com>
Organization: Red Hat Software, Inc. / Embedded Development
X-Mailer: Sylpheed version 0.7.4cvs6 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: Nr)Jjr<W18$]W/d|XHLW^SD-p`}1dn36lQW,d\ZWA<OQ/XI;UrUc3hmj)pX]@n%_4n{Zsg$ t1p@38D[d"JHj~~JSE_udbw@N4Bu/@w(cY^04u#JmXEUCd]l1$;K|zeo!c.#0In"/d.y*U~/_c7lIl 5{0^<~0pk_ET.]:MP_Aq)D@1AIQf.juXKc2u[2pSqNSi3IpsmZc\ep9!XTmHwx
X-Message-Flag: Outlook Virus Warning: Reboot within 12 seconds or risk loss of all files and data!
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="0L9oqQy=.JzMs?+l"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0L9oqQy=.JzMs?+l
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Uttered "chiranjeevi vaka" <cvaka_kernel@yahoo.com>, spoke thus:

>  I am trying to get something around 600 to 1000 bytes
>  using kmalloc. This one is for some changes in TCP/IP
>  stack. I am trying to implement a new kernel data
>  structure in tcp layer. So can you suggest me what
>  functionality to use to come out of that hanging.

Be sure to use "kmalloc( 1000, GFP_ATOMIC )" if you don't want to block waiting
for the memory.  Check for a NULL result, because you might not be able to get
the memory.
--0L9oqQy=.JzMs?+l
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iEYEARECAAYFAjyXk6MACgkQWEn3bOOMcuq0ngCghCnT4MYOfg76KfITH40TACBU
19AAn3yb9/3JY9Hm06EU+h6ZUsq8uk3j
=ysPu
-----END PGP SIGNATURE-----

--0L9oqQy=.JzMs?+l--

