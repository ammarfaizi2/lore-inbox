Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264500AbTFQEVD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 00:21:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264535AbTFQEVD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 00:21:03 -0400
Received: from h80ad2689.async.vt.edu ([128.173.38.137]:29568 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S264500AbTFQEVB (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 00:21:01 -0400
Message-Id: <200306170434.h5H4YZPZ003025@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Janice Girouard <girouard@us.ibm.com>
Cc: "David S. Miller" <davem@redhat.com>,
       Daniel Stekloff <stekloff@us.ibm.com>, janiceg@us.ibm.com,
       jgarzik@pobox.com, Larry Kessler <lkessler@us.ibm.com>,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com, niv@us.ibm.com
Subject: Re: patch for common networking error messages 
In-Reply-To: Your message of "Mon, 16 Jun 2003 21:12:50 CDT."
             <OFCA1A4F38.D782F1D3-ON85256D48.000A5CED@us.ibm.com> 
From: Valdis.Kletnieks@vt.edu
References: <OFCA1A4F38.D782F1D3-ON85256D48.000A5CED@us.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_218344882P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 17 Jun 2003 00:34:34 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_218344882P
Content-Type: text/plain; charset=us-ascii

On Mon, 16 Jun 2003 21:12:50 CDT, Janice Girouard said:

> Okay.  That solves the issue of events generated in a plethora of formats
> for the same event.  Any suggestions on what should be included in this new
> family?  I can present a patch to suggest a starting point. However, it
> would be great to hear from everyone that has any initial thoughts.

Well, at the risk of torquing off any SCO supporters, I'd suggest a quick
peek over at the general design of the AIX errpt/trace systems - in both
cases, data comes out of the kernel in a formatted binary stream, and then
a 'template' file is used to drive the parsing of the formatted data.

Quite slick overall, and nicely extensible - you add a new kernel subsystem
that has more trace points, you just tack its templates onto the end of
the format file and you're good to go....

(And SCO can't even claim that's their code - it's pretty obvious the
parentage of the AIX errpt/trace logging is the OS/VS1 and MVS SMF logging
features :)


--==_Exmh_218344882P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+7ppacC3lWbTT17ARAnRPAJ4tmv1gOrC3xPdA/9RRB6aIc+ox4wCg3Y3M
ALPo18K54qzckAkE1Xa7B4g=
=00MR
-----END PGP SIGNATURE-----

--==_Exmh_218344882P--
