Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261290AbTCETVS>; Wed, 5 Mar 2003 14:21:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261292AbTCETVS>; Wed, 5 Mar 2003 14:21:18 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:9179 "EHLO
	myware.akkadia.org") by vger.kernel.org with ESMTP
	id <S261290AbTCETVR>; Wed, 5 Mar 2003 14:21:17 -0500
Message-ID: <3E6650D4.8060809@redhat.com>
Date: Wed, 05 Mar 2003 11:32:36 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4a) Gecko/20030303
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Better CLONE_SETTLS support for Hammer
References: <3E664836.7040405@redhat.com> <20030305190622.GA5400@wotan.suse.de>
In-Reply-To: <20030305190622.GA5400@wotan.suse.de>
X-Enigmail-Version: 0.73.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Andi Kleen wrote:

> If you just want to save one mmap/allocation: I think the context switch
> overhead will be more expensive than the allocation.

And two more things:

1. every process will already use the prctl(ARCH_SET_FS).  We are
talking here only about the 2nd thread and later.  We need to use
prctl(ARCH_SET_FS) for TLS support.


2. May I remind you that you were in the crowd who complained when we
requested a dedicated thread register?  Yes, I still would prefer that
but I have no energy to battle for that.

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+ZlDV2ijCOnn/RHQRAncTAJ9TOHCpPZKWqD/1BeZVpzGenYvtZACcDaYJ
Y1kyJd90RT60PpyjnR9q1Mg=
=WADr
-----END PGP SIGNATURE-----

