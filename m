Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267421AbTACG0q>; Fri, 3 Jan 2003 01:26:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267423AbTACG0q>; Fri, 3 Jan 2003 01:26:46 -0500
Received: from mta01bw.bigpond.com ([139.134.6.78]:29136 "EHLO
	mta01bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S267421AbTACG0p>; Fri, 3 Jan 2003 01:26:45 -0500
From: Brad Hards <bhards@bigpond.net.au>
To: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] Deprecate exec_usermodehelper, fix request_module.
Date: Fri, 3 Jan 2003 17:21:57 +1100
User-Agent: KMail/1.4.5
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030103050859.4E01B2C070@lists.samba.org>
In-Reply-To: <20030103050859.4E01B2C070@lists.samba.org>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200301031722.03325.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Fri, 3 Jan 2003 16:08, Rusty Russell wrote:
> + * Must be called from process context.  Returns a negative error code
> + * if program was not execed successfully, or (exitcode << 8 + signal)
> + * of the application (0 if wait is not set).
Any chance that you can remove this (existing) restriction. It'd be good to be 
able to use this in some networking code (eg netif_carrier_[off|on]() ), but 
that might be in interrupt context.

It may be just a matter of duplicating the arguments, but I really know SFA 
about this stuff, and am loath to touch it least it turn to mush in my 
fingers.

Brad
- -- 
http://linux.conf.au. 22-25Jan2003. Perth, Aust. I'm registered. Are you?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE+FSwLW6pHgIdAuOMRAgMxAKChfs9HtklDxSUfFDkcrPf/Sk269gCfUYvX
er/EOyc0FZGZV031E0+Ymy4=
=SvBh
-----END PGP SIGNATURE-----

