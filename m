Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261707AbUB0HFn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 02:05:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbUB0HFn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 02:05:43 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:30894
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S261707AbUB0HFl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 02:05:41 -0500
Message-ID: <403EEC25.9090300@redhat.com>
Date: Thu, 26 Feb 2004 23:05:09 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Jakub Jelinek <jakub@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add getdents32t syscall
References: <20040226193819.GA3501@sunsite.ms.mff.cuni.cz> <Pine.LNX.4.58.0402261411420.7830@ppc970.osdl.org> <Pine.LNX.4.58.0402261415590.7830@ppc970.osdl.org> <20040226223212.GA31589@devserv.devel.redhat.com> <Pine.LNX.4.58.0402261504230.7830@ppc970.osdl.org> <403E9E4D.6090301@redhat.com> <Pine.LNX.4.58.0402262212340.2563@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0402262212340.2563@ppc970.osdl.org>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Linus Torvalds wrote:

> No, I'm not suggesting you do it for this one thing, obviously. But 
> there's bound to be _thousands_ of these stupid things where glibc has 
> compatibility crap that makes no sense.

No there are not, at least not for the libc which everybody uses.  FC
comes with three versions.  They each have increasing kernel
requirements.  The normally used version assumes a recent kernel (2.4.20
in FC1, hopefully 2.6.x in FC2) which allows to eliminate all
compatibility with older kernels.  This cuts out almost all of the
cruft.  The other libcs are for various degrees of backward
compatibility for apps which do not follow the API rules and depend on
non-guaranteed behavior of one sort or another.


Anyway, if you add the d_type field after the string and we do the
memmove that already much better than what we have to do today.

- -- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAPuwl2ijCOnn/RHQRAtKkAKCjyzGzwEOgH8MFTWYkXhJOrhHHZACeML4p
wBKxnHhbQNQaycRwocS4Bjc=
=69Uo
-----END PGP SIGNATURE-----
