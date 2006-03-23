Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751147AbWCWJHt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbWCWJHt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 04:07:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbWCWJHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 04:07:49 -0500
Received: from mail26.syd.optusnet.com.au ([211.29.133.167]:51666 "EHLO
	mail26.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751147AbWCWJHt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 04:07:49 -0500
References: <20060322205305.0604f49b.akpm@osdl.org> <4422554D.6000602@att.net> <20060323080925.GP4285@suse.de>
Message-ID: <cone.1143104848.990946.31285.501@kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: Jens Axboe <axboe@suse.de>
Cc: Ryan =?ISO-8859-1?B?TS4=?= <kubisuro@att.net>, ck@vds.kolivas.org,
       linux-kernel@vger.kernel.org
Subject: Re: -mm merge plans
Date: Thu, 23 Mar 2006 20:07:28 +1100
Mime-Version: 1.0
Content-Type: multipart/signed;
    boundary="=_mimegpg-kolivas.org-31285-1143104848-0001";
    micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME GnuPG-signed message.  If you see this text, it means that
your E-mail or Usenet software does not support MIME signed messages.

--=_mimegpg-kolivas.org-31285-1143104848-0001
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Jens Axboe writes:

> It's a heuristic, and sometimes that will work well and sometimes it
> will not. What if during this period of inactivity, you start bringing
> everything in from swap again, only to page it right out because the
> next memory hog starts running? From a logical standpoint, swap prefetch
> and the vm must work closely together to avoid paging in things which
> really aren't needed.

If the system is idle it doesn't cost anything to bring those pages in 
(laptop mode disables any prefetching if you're thinking about power 
consumption on laptops). And if the system wants the ram that has been 
filled with prefetched pages wrongly, the prefetched pages are at the tail 
end of the inactive LRU list with a copy on backing store so if they're not 
accessed they'll be the first thing dropped in preference to anything 
else, without any I/O.

Cheers,
Con


--=_mimegpg-kolivas.org-31285-1143104848-0001
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBEImVRZUg7+tp6mRURAokDAJ0TH2IR35l4i++FZFU/ZxppD+tvLACgjwQz
1ATen9CQAuK1n+vq6ei464c=
=ykOA
-----END PGP SIGNATURE-----

--=_mimegpg-kolivas.org-31285-1143104848-0001--
