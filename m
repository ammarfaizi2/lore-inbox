Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274957AbTHGB0p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 21:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275060AbTHGB0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 21:26:45 -0400
Received: from mta2.srv.hcvlny.cv.net ([167.206.5.5]:57599 "EHLO
	mta2.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S274957AbTHGB0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 21:26:44 -0400
Date: Wed, 06 Aug 2003 21:26:30 -0400
From: Jeff Sipek <jeffpc@optonline.net>
Subject: Re: [PATCH][TRIVIAL] Bugzilla bug # 322 - double logical operator
 drivers/char/sx.c
In-reply-to: <3F319EE7.8010409@techsource.com>
To: Timothy Miller <miller@techsource.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <200308062126.37658.jeffpc@optonline.net>
MIME-version: 1.0
Content-type: Text/Plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
Content-description: clearsigned data
User-Agent: KMail/1.5.2
References: <200308061830.05586.jeffpc@optonline.net>
 <3F319EE7.8010409@techsource.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wednesday 06 August 2003 20:35, Timothy Miller wrote:
> Josef 'Jeff' Sipek wrote:
> > Just a simple fix to make the statements more readable. (instead of
> > "i < TIMEOUT > 0" the statement is divided into two, joined by &&.)
>
> Can you really DO (x < y > z) and have it work as an anded pair of
> comparisons?  Maybe this is an addition to C that I am not aware of.
>
> I would expect (x < y > z) to be equivalent to ((x < y) > z).

Ah, very true. I wonder what the author intended. Also, since the 'z' is 0 in 
all the cases, the statement "(i < TIMEOUT) > 0" can be reduced to "i < 
TIMEOUT".

Jeff.

- -- 
Trust me, you don't want me doing _anything_ first thing in the morning.
		- Linus Torvalds
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/MarKwFP0+seVj/4RAi/xAKCvFPeDmsbG88rt08wm30+l3NP90ACgv7hF
wFn/OwQnZfrJsNQOK9AAPz0=
=8DdO
-----END PGP SIGNATURE-----

