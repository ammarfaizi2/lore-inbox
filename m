Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263542AbTEDHWb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 03:22:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263547AbTEDHWb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 03:22:31 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:6786 "EHLO
	myware.akkadia.org") by vger.kernel.org with ESMTP id S263542AbTEDHWa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 03:22:30 -0400
Message-ID: <3EB4C28A.8050708@redhat.com>
Date: Sun, 04 May 2003 00:34:34 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030501
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Richard Henderson <rth@twiddle.net>
CC: Roland McGrath <roland@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix vsyscall unwind information
References: <200305020033.h420XUi12295@magilla.sf.frob.com> <20030503205159.GA29384@twiddle.net> <20030504062124.GA32457@twiddle.net>
In-Reply-To: <20030504062124.GA32457@twiddle.net>
X-Enigmail-Version: 0.75.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Richard Henderson wrote:

> Also adds unwind info for the sigreturn entry points.

Sweet.


> This can
> be used instead of special-case hacks currently in libgcc and 
> gdb, and by extension allows the kernel to change these entry
> points without breaking userland.

Exactly.  This means we can get rid of the int $0x80.  I.e., move the
sigreturn code in the two .S files for sysenter and int80.  Reducing the
cost of signals is always good.

I'm not sure how this use of sigreturn has to look like.  Linus, maybe
you should do it yourself.


- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+tMKL2ijCOnn/RHQRAoDbAJ4nnP3Hcb8xAeqjRHxgq0YZZmcs0wCdE4BE
Obuu/wRdq70aooscs1JOhto=
=5Sx4
-----END PGP SIGNATURE-----

