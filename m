Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264125AbTEORd4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 13:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264133AbTEORd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 13:33:56 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:53690
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S264125AbTEORdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 13:33:54 -0400
Message-ID: <3EC3D247.20609@redhat.com>
Date: Thu, 15 May 2003 10:45:43 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030513
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
CC: Christopher Hoover <ch@murgatroid.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.68 FUTEX support should be optional
References: <20030513213157.A1063@heavens.murgatroid.com> <20030514071446.A2647@infradead.org> <20030514005213.A3325@heavens.murgatroid.com> <3EC296CE.9050704@redhat.com> <20030515184738.C626@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <20030515184738.C626@nightmaster.csn.tu-chemnitz.de>
X-Enigmail-Version: 0.75.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Ingo Oeser wrote:

> Is this also the case, if I don't want threading at all on my
> system? Does glibc still have a seperate static library for this,

This has nothing to do with static linking or not.

glibc, when compiled with nptl, will always include uses of futexes.
But since there is no contention and the fast path is entirely handled
at userlevel, the actual kernel functionality is not required.

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+w9JH2ijCOnn/RHQRApR/AKCHcHAUsXfz834/ZH0z3iQneNMh4gCfUMzA
RB4+2XbfsJZXpkWQUx5NXPY=
=XGtI
-----END PGP SIGNATURE-----

