Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264902AbTIJHgs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 03:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264904AbTIJHgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 03:36:48 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:53713
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S264902AbTIJHgr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 03:36:47 -0400
Message-ID: <3F5ED467.2030103@redhat.com>
Date: Wed, 10 Sep 2003 00:36:07 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030904 Thunderbird/0.2a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: "Hu, Boris" <boris.hu@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Split futex global spinlock futex_lock
References: <37FBBA5F3A361C41AB7CE44558C3448E01C0B69E@pdsmsx403.ccr.corp.intel.com> <20030910064727.GN4306@holomorphy.com>
In-Reply-To: <20030910064727.GN4306@holomorphy.com>
X-Enigmail-Version: 0.81.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

William Lee Irwin III wrote:

> This looks nice and straightforward. How much did it speed up the
> benchmarks?

I just tested it on a UP P4 HT machine.  I wouldn't expect much
difference here, bigger machines should show more (I'll try to get
things to work on my 4p machine).  Volano performance increased by a bit
(~1%) but this is close to the error range.

Before: about 15479 messages per second
Now:    about 15615 messages per second

The glibc test suite still passes so the code should be fine.

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/XtRn2ijCOnn/RHQRAs+3AKCJ5C2WafltO9mCUiOfrw6ADiqCwACfQ3lc
b2z6DNKQqQz1X3/DreZIdpc=
=ILjm
-----END PGP SIGNATURE-----

