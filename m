Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266115AbUJHWsB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266115AbUJHWsB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 18:48:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266137AbUJHWsB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 18:48:01 -0400
Received: from mx1.redhat.com ([66.187.233.31]:65469 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266115AbUJHWr6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 18:47:58 -0400
Message-ID: <41671900.3070408@redhat.com>
Date: Fri, 08 Oct 2004 15:47:28 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a5) Gecko/20041003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [BUG] ia32 ptrace on x86-64 broken for syscalls with 6 parameters
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Running an ia32 strace on x86-64 to look at an ia32 application which
uses syscalls which have six parameters (e.g., mmap2, fadvise64_64)
shows that the values reported to strace are bogus.  The very same
program, strace, and glibc binaries on an ia32 machine show the correct
result.  The system call (I tried mmap2) is also correctly executed.
I.e., it is the ptrace interface.

This happens with both, em64t and amd64 machines.  In both cases the
vsyscall DSO was used.

This is with the current FC kernel which corresponds to rc3-bk6.

- --
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBZxkA2ijCOnn/RHQRAsKdAJ4klGY2WV4S1866evJWzOcqM8yhLQCeLN5S
9Jfk40pOpd7rW7ncJ1i51Ek=
=1O9f
-----END PGP SIGNATURE-----
