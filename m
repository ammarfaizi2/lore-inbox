Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264823AbSKRTwf>; Mon, 18 Nov 2002 14:52:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264836AbSKRTwf>; Mon, 18 Nov 2002 14:52:35 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:29058
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id <S264823AbSKRTwc>; Mon, 18 Nov 2002 14:52:32 -0500
Message-ID: <3DD946A2.7030501@redhat.com>
Date: Mon, 18 Nov 2002 11:59:30 -0800
From: Ulrich Drepper <drepper@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>
CC: Mark Mielke <mark@mark.mielke.cc>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [rfc] epoll interface change and glibc bits ...
References: <Pine.LNX.4.44.0211181034290.979-100000@blue1.dev.mcafeelabs.com>
In-Reply-To: <Pine.LNX.4.44.0211181034290.979-100000@blue1.dev.mcafeelabs.com>
X-Enigmail-Version: 0.65.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Davide Libenzi wrote:

> epoll does hook f_op->poll() and hence uses the asm/poll.h bits.

It does today.  We are talking about "you promise that this will be the
case ever after or we'll cut your head off".  I have no idea why you're
so reluctant since you don't have to maintain any of the user-level
bits.  And it is not you who has to deal with the fallout of a change
when it happens.

If epoll is so different from poll (and this is what I've been told frmo
Davide) then there should be a clear separation of the interfaces and
all those arguing to unify the data types and constants better should
rethink there understanding.

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE92Uai2ijCOnn/RHQRAnxbAJ9grqqA0HgAJTkHSpJMAxEBu6QFDwCeONNv
UI85HprHxc+v+dYmMPEVzR8=
=hZm1
-----END PGP SIGNATURE-----

