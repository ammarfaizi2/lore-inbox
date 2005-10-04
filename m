Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965013AbVJDWWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965013AbVJDWWM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 18:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965016AbVJDWWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 18:22:12 -0400
Received: from h80ad254c.async.vt.edu ([128.173.37.76]:38863 "EHLO
	h80ad254c.async.vt.edu") by vger.kernel.org with ESMTP
	id S965013AbVJDWWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 18:22:11 -0400
Message-Id: <200510042221.j94MLv3P006180@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: Martin Drab <drab@kepler.fjfi.cvut.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4 in-kernel file opening 
In-Reply-To: Your message of "Tue, 04 Oct 2005 13:41:49 EDT."
             <Pine.LNX.4.61.0510041329180.29678@chaos.analogic.com> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.60.0510041924520.8210@kepler.fjfi.cvut.cz>
            <Pine.LNX.4.61.0510041329180.29678@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1128464516_2752P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 04 Oct 2005 18:21:56 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1128464516_2752P
Content-Type: text/plain; charset=us-ascii

On Tue, 04 Oct 2005 13:41:49 EDT, "linux-os (Dick Johnson)" said:

> You are never supposed to use files inside the kernel; period!

Usually true.  However, feel free to look at kernel/acct.c and suggest
a way of implementing it in a backward-compatible way that doesn't use
filp_open() and filp_close().  Keep in mind you can't use the 'connector'
framework the way auditd and friends do, because the sys_acct() call has
semantics of writing directly to a file without a listening daemon....

--==_Exmh_1128464516_2752P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDQwCEcC3lWbTT17ARArkTAJ9gQUgQVN0UEpLMxehBjouIjcl3rgCg4qCP
hTRSFZdZqK+JJrDi2W4IFVE=
=fyc2
-----END PGP SIGNATURE-----

--==_Exmh_1128464516_2752P--
