Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262654AbTJIXUY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 19:20:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262667AbTJIXUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 19:20:24 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:61370
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S262654AbTJIXUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 19:20:19 -0400
Message-ID: <3F85ED01.8020207@redhat.com>
Date: Thu, 09 Oct 2003 16:19:29 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030925 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: statfs() / statvfs() syscall ballsup...
References: <Pine.LNX.4.44.0310091525200.20936-100000@home.osdl.org>
In-Reply-To: <Pine.LNX.4.44.0310091525200.20936-100000@home.osdl.org>
X-Enigmail-Version: 0.81.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Linus Torvalds wrote:

> User space shouldn't know or care about frsize, and it doesn't even 
> necessarily make any sense on a lot of filesystems, so make it easy for 
> the user. It's not as if the rounding errors really matter.

There have been numerous requests to add a statvfs syscall, at least
made to me.  The problem is that the emulation through statfs cannot be
optimal.  The emulation has to get all kinds of additional information
(like mount flags) which in some cases lead to hangs or delays.

- From what I see statvfs is much more frequently used than statfs so such
an extension would be justified.  And then the kernel would be able to
determine all the right values and guide the user with them as it pleases.

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/he0B2ijCOnn/RHQRAg+GAKC48tj7myC+lITvghxPK/ZEWcLTnQCgpUh4
5whszj+14fucakVcsZ4sOIQ=
=EVjn
-----END PGP SIGNATURE-----

