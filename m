Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751236AbVKQVZi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbVKQVZi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 16:25:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbVKQVZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 16:25:38 -0500
Received: from smtprelay03.ispgateway.de ([80.67.18.15]:42960 "EHLO
	smtprelay03.ispgateway.de") by vger.kernel.org with ESMTP
	id S1751236AbVKQVZi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 16:25:38 -0500
From: Ingo Oeser <ioe-lkml@rameria.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/11] unpaged: ZERO_PAGE in VM_UNPAGED
Date: Thu, 17 Nov 2005 22:25:26 +0100
User-Agent: KMail/1.7.2
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>
References: <Pine.LNX.4.61.0511171925290.4563@goblin.wat.veritas.com> <Pine.LNX.4.61.0511171938080.4563@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0511171938080.4563@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1256992.g7Bujoyvzu";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200511172225.31973.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1256992.g7Bujoyvzu
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Hugh,

On Thursday 17 November 2005 20:38, Hugh Dickins wrote:
> It's strange enough to be looking out for anonymous pages in VM_UNPAGED
> areas, let's not insert the ZERO_PAGE there - though whether it would
> matter will depend on what we decide about ZERO_PAGE refcounting.

We do we refcount ZERO_PAGE at all?
Ok, there may be multiple, but they exist always and always at
the same physical addresses, right?

So why do we care at all?
Memory hotplug?
Doesn't it suffice there, that they are reverse mappable?

Aren't they a perfect candidate for a VM_UNPAGED from /dev/zero :-)


Regards

Ingo Oeser


--nextPart1256992.g7Bujoyvzu
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDfPVLU56oYWuOrkARAmeTAJ9DGZB4AMmkeqx0k7u57qOEdkuqRQCdFNP5
EKP/7Pt2Hvv5NnbSVfsam2w=
=gzyb
-----END PGP SIGNATURE-----

--nextPart1256992.g7Bujoyvzu--
