Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932282AbWAUTrX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbWAUTrX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 14:47:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932304AbWAUTrW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 14:47:22 -0500
Received: from mx3.mail.ru ([194.67.23.149]:42567 "EHLO mx3.mail.ru")
	by vger.kernel.org with ESMTP id S932282AbWAUTrW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 14:47:22 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Olaf Hering <olh@suse.de>
Subject: Re: cc-version not available to change EXTRA_CFLAGS
Date: Sat, 21 Jan 2006 22:47:12 +0300
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <200601212207.49483.arvidjaar@mail.ru> <20060121191140.GA17661@suse.de>
In-Reply-To: <20060121191140.GA17661@suse.de>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601212247.14101.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Saturday 21 January 2006 22:11, Olaf Hering wrote:
>  On Sat, Jan 21, Andrey Borzenkov wrote:
> > does chmod +x scripts/gcc-version.sh help?
>
> no, cc-version is not expanded in this context.

well it does in this trivial test:

cc-version = $(shell foo/baz 2234)

FOO = $(shell set -x; if [ $(cc-version) -lt 2000 ] ; then echo y; else echo 
n; fi)

bar:
	echo $(FOO)


I get exactly the same result if foo/baz is not executable or returns empty 
string (in the former case I also get error message from make but may be it 
is supressed, I never fully groked kernel Makefiles).

So again - does scripts/gcc-version.sh returns any usable value? Is it 
executable?

- -andrey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD4DBQFD0o/CR6LMutpd94wRAjuFAJj2Ov4Z2iVxamYY/IxkLzOGRb1fAJwIBOxt
aH91icTk8dTKzO/VzLjlLA==
=DNXC
-----END PGP SIGNATURE-----
