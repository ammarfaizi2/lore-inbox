Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263932AbUDVLB4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263932AbUDVLB4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 07:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263935AbUDVLBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 07:01:24 -0400
Received: from mx1.redhat.com ([66.187.233.31]:14489 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263928AbUDVK6L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 06:58:11 -0400
Date: Thu, 22 Apr 2004 12:56:25 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390 (9/9): no timer interrupts in idle.
Message-ID: <20040422105625.GA27339@devserv.devel.redhat.com>
References: <OF99EB5E0C.21B30690-ONC1256E7E.003B1339-C1256E7E.003BCEE8@de.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
In-Reply-To: <OF99EB5E0C.21B30690-ONC1256E7E.003B1339-C1256E7E.003BCEE8@de.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 22, 2004 at 12:53:15PM +0200, Martin Schwidefsky wrote:
> active in idle, a "0" indicates that the HZ timer is switchted off.
> The semantic "the next tick is THIS many <ticks> from now" IHMO doesn't make
> any sense. Skipping ticks will have some really bad effects, e.g. if the xtime
> isn't up-to-date network packets will get incorrect time stamps, timer events
> will be delivered too late, etc.

why? Most hardware have an alternative time source for such time stamps.
Timer events *won't* be delivered too late, simply *because* the timer said
"don't bother checking back for X amount of time", so when that time has
expired (eg the delay) then the timer comparison tells the kernel "ok this
one is due now".

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAh6TYxULwo51rQBIRAuvrAJ93+MhgWtmd5NSm2WebvzHyrihhnACdGfKX
rsh1dIvH5K6NF8TPVPlHQCM=
=9zyw
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
