Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261670AbUL3QX6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbUL3QX6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 11:23:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261668AbUL3QX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 11:23:58 -0500
Received: from c148216.adsl.hansenet.de ([213.39.148.216]:46208 "EHLO
	fusebox.fsfeurope.org") by vger.kernel.org with ESMTP
	id S261670AbUL3QXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 11:23:41 -0500
To: linux-kernel@vger.kernel.org
Cc: dm-crypt@saout.de
Subject: Re: PROBLEM: Kernel 2.6.10 crashing repeatedly and hard
References: <m3is6k4oeu.fsf@reason.gnu-hamburg>
From: "Georg C. F. Greve" <greve@fsfeurope.org>
Organisation: Free Software Foundation Europe
X-PGP-Fingerprint: 2D68 D553 70E5 CCF9 75F4 9CC9 6EF8 AFC2 8657 4ACA
X-PGP-Affinity: will accept encrypted messages for GNU Privacy Guard
X-Home-Page: http://gnuhh.org
X-Accept-Language: en, de
Date: Thu, 30 Dec 2004 17:23:17 +0100
In-Reply-To: <m3is6k4oeu.fsf@reason.gnu-hamburg> (Georg C. F. Greve's message
	of "Thu, 30 Dec 2004 01:31:37 +0100")
Message-ID: <m38y7fn4ay.fsf@reason.gnu-hamburg>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="20041230172317+0100-64656733-12391328-91779438";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--20041230172317+0100-64656733-12391328-91779438

[ update ]

Okay, tried to find out what is causing the kernel to crash and so I
replaced the dm-crypt part by cryptoloop: same effect.

Then I tried ext3 on top of LVM2 RAID5 with no encryption and it still
crashes. Not sure what is causing the problem exactly, but it does not
seem that dm-crypt is to blame anymore.

The message I saw on the remote console when it crashed with pure ext3
on raid5 was:

 Assertion failure in journal_start() at fs/jbd/transaction.c:271: "handle->h_transaction->t_journal == journal"


Hope this helps -- filed the bug as #3968 on buzilla.kernel.org, more
info at 

  http://bugzilla.kernel.org/show_bug.cgi?id=3968

Help appreciated, let me know if you have an idea.

Regards,
Georg

-- 
Georg C. F. Greve                                       <greve@gnu.org>
Free Software Foundation Europe	                 (http://fsfeurope.org)
Brave GNU World	                           (http://brave-gnu-world.org)

--20041230172317+0100-64656733-12391328-91779438
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.3.92 (GNU/Linux)

iD8DBQBB1Ct1bvivwoZXSsoRAlQiAJ9f/xFoljpzG041ttBDZcKxEPAPgwCaAmkI
ny2HKC15P8D2NPFyOKINYGY=
=dqK1
-----END PGP SIGNATURE-----
--20041230172317+0100-64656733-12391328-91779438--
