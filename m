Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261316AbTIJJhx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 05:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261325AbTIJJhx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 05:37:53 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:19154
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S261316AbTIJJhw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 05:37:52 -0400
Message-ID: <3F5EF0B9.7020207@redhat.com>
Date: Wed, 10 Sep 2003 02:36:57 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030904 Thunderbird/0.2a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: "Hu, Boris" <boris.hu@intel.com>
Subject: Re: [PATCH] Split futex global spinlock futex_lock
References: <37FBBA5F3A361C41AB7CE44558C3448E01C0B69E@pdsmsx403.ccr.corp.intel.com>
In-Reply-To: <37FBBA5F3A361C41AB7CE44558C3448E01C0B69E@pdsmsx403.ccr.corp.intel.com>
X-Enigmail-Version: 0.81.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I've run some tests on a 4p P4 HT machine.  Some heavy futex using
benchmark code runs about 6% faster with the patch.  So, despite the
reduced time the futex lock is actually taken after Jamie's patch the
separate locks still add benefits.

Plus, currently we do not allocate locks so that the futexes fall in
different buckets.  To some extend this is possible and would be a
possible optimization if this patch goes in.

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/XvC62ijCOnn/RHQRApUsAJ0RB/WsVZTgC31yIbAFL4KdMi8UcgCeI+Gv
uAVQQReC9Tl1g8HogsReVdA=
=vRBt
-----END PGP SIGNATURE-----

