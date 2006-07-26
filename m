Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751119AbWGZL22@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbWGZL22 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 07:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751382AbWGZL22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 07:28:28 -0400
Received: from pool-72-66-202-44.ronkva.east.verizon.net ([72.66.202.44]:37829
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1751119AbWGZL21 (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 07:28:27 -0400
Message-Id: <200607261128.k6QBSJ4o020737@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Al Boldi <a1426z@gawab.com>
Cc: Peter Williams <pwil3058@bigpond.net.au>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE][RFC] PlugSched-6.4 for 2.6.18-rc2
In-Reply-To: Your message of "Wed, 26 Jul 2006 07:45:33 +0300."
             <200607260745.33264.a1426z@gawab.com>
From: Valdis.Kletnieks@vt.edu
References: <200607241857.52389.a1426z@gawab.com> <200607252127.14024.a1426z@gawab.com> <200607251940.k6PJeWbu023928@turing-police.cc.vt.edu>
            <200607260745.33264.a1426z@gawab.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1153913298_5911P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 26 Jul 2006 07:28:19 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1153913298_5911P
Content-Type: text/plain; charset=us-ascii

On Wed, 26 Jul 2006 07:45:33 +0300, Al Boldi said:
> Valdis.Kletnieks@vt.edu wrote:

> > On an SMP system, you can have one CPU doing one class of scheduling (long
> > timeslice for computational, for example), while another CPU is dedicated
> > to doing RT scheduling, and so on.  It's not clear to me that "different
> > classes per CPU" makes any real sense on a UP....
> 
> Conceptually there should be no difference between UP and MP.
> 
> Think HyperThreading.

Which is why a UP kernel can schedule on both sides of an HT core.

Yeah, I got it now. ;)

An HT core still *has* "the other instruction stream" it can schedule
differetly.  You can't say "We'll schedule this one this way and that other
one that way" when there *is* no "that other one".

(And if you look at the current code, you'll realize that HT is conceptually
different from both UP *and* MP - go look at the places where the *current*
scheduler is HT-aware, and how that was a big win over when it thought each
HT was a fully capable MP......)

--==_Exmh_1153913298_5911P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEx1HScC3lWbTT17ARAqlrAJ90jqZGl9A/ZnHoDuc5WpCVSp3vAQCeIJTt
En3vKM1KzQCNsnXB+dZF/yo=
=CYkY
-----END PGP SIGNATURE-----

--==_Exmh_1153913298_5911P--
