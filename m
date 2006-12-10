Return-Path: <linux-kernel-owner+w=401wt.eu-S1762637AbWLJVjk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762637AbWLJVjk (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 16:39:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762646AbWLJVjj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 16:39:39 -0500
Received: from smtp-vbr8.xs4all.nl ([194.109.24.28]:2664 "EHLO
	smtp-vbr8.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762637AbWLJVjj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 16:39:39 -0500
Date: Sun, 10 Dec 2006 22:39:26 +0100
From: Folkert van Heusden <folkert@vanheusden.com>
To: Mitchell Blank Jr <mitch@sfgoth.com>
Cc: Willy Tarreau <w@1wt.eu>, linux-kernel@vger.kernel.org,
       kernel-janitors@lists.osdl.org
Subject: Re: strncpy optimalisation? (lib/string.c)
Message-ID: <20061210213925.GE30197@vanheusden.com>
References: <20061210205230.GB30197@vanheusden.com>
	<20061210210614.GD24090@1wt.eu>
	<20061210214934.GC47959@gaz.sfgoth.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061210214934.GC47959@gaz.sfgoth.com>
Organization: www.unixexpert.nl
X-Chameleon-Return-To: folkert@vanheusden.com
X-Xfmail-Return-To: folkert@vanheusden.com
X-Phonenumber: +31-6-41278122
X-URL: http://www.vanheusden.com/
X-PGP-KeyID: 1F28D8AE
X-GPG-fingerprint: AC89 09CE 41F2 00B4 FCF2  B174 3019 0E8C 1F28 D8AE
X-Key: http://pgp.surfnet.nl:11371/pks/lookup?op=get&search=0x1F28D8AE
Read-Receipt-To: <folkert@vanheusden.com>
Reply-By: Mon Dec 11 21:32:58 CET 2006
X-Message-Flag: PGP key-id: 0x1f28d8ae - consider encrypting your e-mail to me
	with PGP!
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Original code completely pads the destination with zeroes,
> > while yours only adds the last zero. Your code does what
> > strncpy() is said to do, but maybe there's a particular
> > reason for it to behave differently in the kernel
> No, the kernel's strncpy() behaves the same as the one in libc.  Run
> "man strncpy" if you don't believe me.
> In the common case where you just want to copy a string and avoid
> overflow use strlcpy() instead

Oops you're right! Maybe someone should take a look if the strncpy's
should be replaced by strlcpy's then because it is (ought to be) faster.


Folkert van Heusden

-- 
Ever wonder what is out there? Any alien races? Then please support
the seti@home project: setiathome.ssl.berkeley.edu
----------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com
