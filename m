Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266562AbUBLTi6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 14:38:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266564AbUBLTi6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 14:38:58 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:39445 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S266562AbUBLTiz (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 14:38:55 -0500
Message-Id: <200402121938.i1CJcpVb002430@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Konstantin Kudin <konstantin_kudin@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Strange boot with multiple identical disks 
In-Reply-To: Your message of "Thu, 12 Feb 2004 11:28:48 PST."
             <20040212192848.29083.qmail@web21204.mail.yahoo.com> 
From: Valdis.Kletnieks@vt.edu
References: <20040212192848.29083.qmail@web21204.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1607311684P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 12 Feb 2004 14:38:51 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1607311684P
Content-Type: text/plain; charset=us-ascii

On Thu, 12 Feb 2004 11:28:48 PST, Konstantin Kudin <konstantin_kudin@yahoo.com>  said:

>  Now I am trying to add the failing one as /hdc, and
> boot. Linux starts to display all kinds of weird
> messages, and thinks that / partition was shut down
> uncleanly. I just hit "reset". Then I disable /hdc via
> the boot option hdc=noprobe, and things boot fine. If
> I try to disable raid via raid=noautodetect, the bunch
> of errors still appears and the boot is no go. Done
> this several times, without /hdc things are fine, with
> - all kinds of issues.
> 
>  What is the problem for linux to boot on /hda when
> /hdc is detected and has almost identical setup? 

Sometimes, the LABEL= support is your enemy.  You probably have
multiple partitions with the same LABEL=, and your /etc/fstab is
picking up the "wrong" ones.  Try giving partition names instead.

--==_Exmh_-1607311684P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAK9ZLcC3lWbTT17ARAsy1AKCGEk1B1n5y5tPRvNc2PVTJg0lQUQCfSyxQ
QwnkcpEP7nf0yeBfznZ66bA=
=FOjm
-----END PGP SIGNATURE-----

--==_Exmh_-1607311684P--
