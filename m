Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263729AbTENTHY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 15:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263735AbTENTHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 15:07:24 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:4276 "EHLO
	myware.akkadia.org") by vger.kernel.org with ESMTP id S263729AbTENTHV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 15:07:21 -0400
Message-ID: <3EC296CE.9050704@redhat.com>
Date: Wed, 14 May 2003 12:19:42 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030513
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christopher Hoover <ch@murgatroid.com>
CC: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] 2.5.68 FUTEX support should be optional
References: <20030513213157.A1063@heavens.murgatroid.com> <20030514071446.A2647@infradead.org> <20030514005213.A3325@heavens.murgatroid.com>
In-Reply-To: <20030514005213.A3325@heavens.murgatroid.com>
X-Enigmail-Version: 0.75.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Christopher Hoover wrote:

> +config FUTEX
> +       bool "Futex support"
> +       depends on MMU
> +       default y
> +       ---help---
> +       Say Y if you want support for Fast Userspace Mutexes (Futexes).
> +
> +endmenu

If this is what is wanted (and I don't really think it's useful is a MMU
is available) you should explain the consequences in the help text.
Basically, no current and future glibc version has the slightest chance
of working.

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+wpbO2ijCOnn/RHQRAj18AJ9uyaEouJILT2Nk3RmxL9QA9xfiYwCeMLOg
Egve3dwd9NOcBRGPgT062Nw=
=cnrE
-----END PGP SIGNATURE-----

