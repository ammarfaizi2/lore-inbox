Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264820AbUFLOE7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264820AbUFLOE7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 10:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264811AbUFLOE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 10:04:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:17860 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264826AbUFLOCR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 10:02:17 -0400
Date: Sat, 12 Jun 2004 16:01:42 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: ganzinger@mvista.com
Cc: Geoff Levand <geoffrey.levand@am.sony.com>,
       high-res-timers-discourse@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] high-res-timers patches for 2.6.6
Message-ID: <20040612140142.GA3728@devserv.devel.redhat.com>
References: <40C7BE29.9010600@am.sony.com> <1086861862.2733.6.camel@laptop.fenrus.com> <40C8F68F.4030601@mvista.com> <20040611062256.GB13100@devserv.devel.redhat.com> <40CA3342.9020105@mvista.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
In-Reply-To: <40CA3342.9020105@mvista.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 11, 2004 at 03:33:38PM -0700, George Anzinger wrote:
> Can I be so bold as to ask about the changed to the timer list code?  
> Assuming we scrapped all the ifdefs, that is.

I wonder what kind of resolution is needed. I'd love for timers to just be
in "absolute time" using some fixed point arith, and then when the timer
queue gets run you look at the current time and run all the ones that
expired so far. That way you can make the HZ timer irq run this list, but if
it's cheap enough and you then want higher accuracy, also the RTC clock, and
potentially even some oddball thing like the idle loop or network interrupts
for network timers, or video vsync irqs or .. or ..


--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAywzGxULwo51rQBIRAr6pAKCQ5lbQcb2KBAuTUlUXqf6VK9z4MQCghAik
GckB7Q8JAF27O8UPmwC3v6I=
=SL9k
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--
