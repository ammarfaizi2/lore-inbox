Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261678AbVAXWLX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbVAXWLX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 17:11:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbVAXWIX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 17:08:23 -0500
Received: from brmea-mail-3.Sun.COM ([192.18.98.34]:7625 "EHLO
	brmea-mail-3.sun.com") by vger.kernel.org with ESMTP
	id S261678AbVAXWFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 17:05:11 -0500
Date: Mon, 24 Jan 2005 17:04:35 -0500
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: [patch 1/13] Qsort
In-reply-to: <20050123044637.GA54433@muc.de>
To: Andi Kleen <ak@muc.de>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, Felipe Alfaro Solana <lkml@mac.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-kernel@vger.kernel.org, Buck Huppmann <buchk@pobox.com>,
       Neil Brown <neilb@cse.unsw.edu.au>,
       Andreas Gruenbacher <agruen@suse.de>,
       "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
       Andrew Morton <akpm@osdl.org>, Olaf Kirch <okir@suse.de>,
       Tim Hockin <thockin@hockin.org>
Message-id: <41F570F3.3020306@sun.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <20050122203326.402087000@blunzn.suse.de>
 <20050122203618.962749000@blunzn.suse.de>
 <Pine.LNX.4.58.0501221257440.1982@shell3.speakeasy.net>
 <FB9BAC88-6CE2-11D9-86B4-000D9352858E@mac.com> <m1r7kc27ix.fsf@muc.de>
 <Pine.LNX.4.61.0501230357580.2748@dragon.hygekrogen.localhost>
 <20050123044637.GA54433@muc.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Andi Kleen wrote:
>>How about a shell sort?  if the data is mostly sorted shell sort beats 
>>qsort lots of times, and since the data sets are often small in-kernel, 
>>shell sorts O(n^2) behaviour won't harm it too much, shell sort is also 
>>faster if the data is already completely sorted. Shell sort is certainly 
>>not the simplest algorithm around, but I think (without having done any 
>>tests) that it would probably do pretty well for in-kernel use... Then 
>>again, I've known to be wrong :)
> 
> 
> I like shell sort for small data sets too. And I agree it would be 
> appropiate for the kernel.
> 

FWIW, we already have a Shell sort for the ngroups stuff in
kernel/sys.c:groups_sort() that could be made generic.

- --
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me,
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB9XDzdQs4kOxk3/MRAs2ZAJ4if1XRFAiWsgb1wvTInFLUVGHesgCfWxCJ
Efyrr4PkG/KrqefAVAQjt+c=
=/OPh
-----END PGP SIGNATURE-----
