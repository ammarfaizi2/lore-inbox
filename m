Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265225AbTLFSWG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 13:22:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265226AbTLFSWG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 13:22:06 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:8605 "EHLO
	myware.akkadia.org") by vger.kernel.org with ESMTP id S265225AbTLFSWD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 13:22:03 -0500
Message-ID: <3FD21E09.4080504@redhat.com>
Date: Sat, 06 Dec 2003 10:20:57 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031121 Thunderbird/0.4a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@yahoo.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] FIx  'noexec' behavior
References: <20031206172720.52128.qmail@web14909.mail.yahoo.com>
In-Reply-To: <20031206172720.52128.qmail@web14909.mail.yahoo.com>
X-Enigmail-Version: 0.82.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jon Smirl wrote:
> This patch makes Mozilla fail to load on my system. If I back it out everything
> is fine again. No error messages, Mozilla just hangs for about thirty seconds
> and exits.

What do all the mounts on this system look like?

The changes in fact change the kernel ABI but any programs which has
problems with this is buggy and it either can easily be changed, or it
actively does something compromising the security of the system.
Anyway, stalling is the least I expect since the kernel returns a new
error.  Unless, of course, there is another programming mistake in the
program's code.

- -- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/0h4J2ijCOnn/RHQRAhx7AJ4lUy5JcdE0bCwoKh6LMP0t/uOoMACgst4N
mnLPEmLg3SIBUDTVVYZlpfQ=
=sZ/A
-----END PGP SIGNATURE-----
