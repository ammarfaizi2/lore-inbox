Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261617AbULFTsr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261617AbULFTsr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 14:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261621AbULFTsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 14:48:47 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:55203 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261617AbULFTsp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 14:48:45 -0500
Message-Id: <200412061948.iB6JmOpY003565@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 10/11/2004 with nmh-1.1-RC3
To: Grzegorz Piotr Jaskiewicz <gj@pointblue.com.pl>
Cc: kernel list <linux-kernel@vger.kernel.org>, coreteam@netfilter.org
Subject: Re: ip contrack problem, not strictly followed RFC, DoS very much possible 
In-Reply-To: Your message of "Mon, 06 Dec 2004 14:54:59 +0100."
             <41B464B3.8020807@pointblue.com.pl> 
From: Valdis.Kletnieks@vt.edu
References: <41B464B3.8020807@pointblue.com.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-949328744P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 06 Dec 2004 14:48:24 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-949328744P
Content-Type: text/plain; charset=us-ascii

On Mon, 06 Dec 2004 14:54:59 +0100, Grzegorz Piotr Jaskiewicz said:

> There is little bug, eversince, no author would agree to correct it 
> (dunno why) in ip_conntrack_proto_tcp.c:91:
> unsigned long ip_ct_tcp_timeout_established =   5 DAYS;

If you so desire, you can probably workaround this by doing:

echo 100 > /proc/sys/net/ipv4/netfilter/ip_conntrack_tcp_timeout_established

Of course, then if you don't type in an SSH window for 5 minutes, it evaporates
on you - and even SSH keepalives don't help if a router takes a nose dive and
it takes 2 minutes for our NOC to slap it upside the head.  This is a case
*against* keepalives there - if a router hiccups and drops a keepalive on an
otherwise idle session, you nuke a perfectly good idle session for reasons
totally contrary to the original purpose of TCP, namely to *survive* such a
router burp.


--==_Exmh_-949328744P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBtLeIcC3lWbTT17ARAjw2AKDTxgzlWksz2FNpJsHo+/MrMjOflACg5rjQ
3d+mYTy337/bAznn8agf3Tk=
=xEEB
-----END PGP SIGNATURE-----

--==_Exmh_-949328744P--
