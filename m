Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750761AbVIFQ6U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbVIFQ6U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 12:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750760AbVIFQ6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 12:58:20 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:11481 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1750761AbVIFQ6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 12:58:19 -0400
Message-Id: <200509061658.j86GwB5w029481@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: walking.to.remember@gmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: what will connect the fork() with its following code ? a simple example below: 
In-Reply-To: Your message of "Tue, 06 Sep 2005 17:15:51 +0800."
             <6b5347dc0509060215128d477e@mail.gmail.com> 
From: Valdis.Kletnieks@vt.edu
References: <6b5347dc0509060215128d477e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1126025888_2971P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 06 Sep 2005 12:58:09 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1126025888_2971P
Content-Type: text/plain; charset=us-ascii

On Tue, 06 Sep 2005 17:15:51 +0800, "Sat." said:

Not a kernel problem, please consult an intro-to-C list next time....

> if(!(pid=fork())){
>      ......
>      printk("in child process");
>      ......
> }else{
>      .....
>      printk("in father process"); 
>      .....
> }
> 

> values., and do nothing . so the bridge  between the new process and
> its following code, printk("in child process"), seems disappear 

I'm assuming you actually meant printf() (which is the userspace stdio call)
rather than printk() (which is the inside-the-kernel variant).

'man setbuf' - most likely the output of the child process is buffered and
never actually output before it exits.  You want to set stdout to be
line-buffered or unbuffered, or write to stderr (unbuffered by default) rather
than stdout. 


--==_Exmh_1126025888_2971P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDHcqgcC3lWbTT17ARAjANAJ9xbZaSESYmhsBc73Dm2oE/WCA3SQCbBzaN
8h5hJlb6YKCeDZ45p3Jp5Ac=
=dZ5t
-----END PGP SIGNATURE-----

--==_Exmh_1126025888_2971P--
