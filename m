Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751275AbWISPcf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbWISPcf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 11:32:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbWISPce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 11:32:34 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:10890 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1751275AbWISPce (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 11:32:34 -0400
Message-Id: <200609191532.k8JFWJfE022222@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: rohitseth@google.com
Cc: Andrew Morton <akpm@osdl.org>, devel@openvz.org,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Patch 01/05]- Containers: Documentation on using containers
In-Reply-To: Your message of "Thu, 14 Sep 2006 18:38:33 PDT."
             <1158284314.5408.146.camel@galaxy.corp.google.com>
From: Valdis.Kletnieks@vt.edu
References: <1158284314.5408.146.camel@galaxy.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1158679939_3447P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 19 Sep 2006 11:32:19 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1158679939_3447P
Content-Type: text/plain; charset=us-ascii

On Thu, 14 Sep 2006 18:38:33 PDT, Rohit Seth said:

(Sorry for the late reply...)


> --- linux-2.6.18-rc6-mm2.org/Documentation/containers.txt	1969-12-31 16:00:00.000000000 -0800
> +++ linux-2.6.18-rc6-mm2.ctn/Documentation/containers.txt	2006-09-14 17:13:48.000000000 -0700

> +5- Remove a task from container
> +	echo <pid> rmtask

echo <pid> > rmtask

is what I think was intended.  Also, I'm not sure <pid> is the best
meta-syntax - anybody got a better idea?

> +9- Freeing a container
> +	cd /mnt/configfs/containers/
> +	rmdir test_container

What happens if you try to remove a container that still has active tasks? Are
you relying on the VFS to catch the 'non-empty directory'? (of course, 'rm -r'
has predictable semantics here).

I see support for "add a task" and "remove a task", but none for listing
the current tasks in the container?

--==_Exmh_1158679939_3447P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFEA2DcC3lWbTT17ARAuEnAKDHiyJVsxy1o8ANtsqR0VxDxNscjQCfU4XQ
X0ttGEopdUWVC3wozMhXoto=
=aywv
-----END PGP SIGNATURE-----

--==_Exmh_1158679939_3447P--
