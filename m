Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261698AbUB0BdZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 20:33:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261709AbUB0BdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 20:33:24 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:21932
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S261698AbUB0BdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 20:33:20 -0500
Message-ID: <403E9E4D.6090301@redhat.com>
Date: Thu, 26 Feb 2004 17:33:01 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Jakub Jelinek <jakub@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add getdents32t syscall
References: <20040226193819.GA3501@sunsite.ms.mff.cuni.cz> <Pine.LNX.4.58.0402261411420.7830@ppc970.osdl.org> <Pine.LNX.4.58.0402261415590.7830@ppc970.osdl.org> <20040226223212.GA31589@devserv.devel.redhat.com> <Pine.LNX.4.58.0402261504230.7830@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0402261504230.7830@ppc970.osdl.org>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Linus Torvalds wrote:

> The thing is, I hate encouraging glibc's behaviour of "we'll make up our
> own structures", and then ask the kernel to fix it later when it was done
> wrong in glibc. This is a totally new format that is totally unnecessary,
> and the RIGHT thing to do is to have glibc just use the proper 64-bit
> format.

Good idea.  Let's go back in time to 1994/5 and add d_type then.  May I
remember you that I always wanted large data types but whenever it was
proposed the kernel people (including you) said: we don't need it this
big now therefore it won't be changed.


> In other words, why doesn't glibc ever just make a new major number and
> make its "struct dirent" be the 64-bit version?

You can't be serious.  Can you even imagine the pain this would cause?

- -- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAPp5N2ijCOnn/RHQRAuuOAJ4rY41j0ifWbK3R8Qv5elA+RULCqwCeP+RC
pIC2Re4DR6tUZSPmqsijjGw=
=PfkG
-----END PGP SIGNATURE-----
