Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267726AbTCFDlD>; Wed, 5 Mar 2003 22:41:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267736AbTCFDlD>; Wed, 5 Mar 2003 22:41:03 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:44253
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id <S267726AbTCFDlC>; Wed, 5 Mar 2003 22:41:02 -0500
Message-ID: <3E66C5F4.5000106@redhat.com>
Date: Wed, 05 Mar 2003 19:52:20 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4a) Gecko/20030303
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@redhat.com>
CC: Andi Kleen <ak@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Better CLONE_SETTLS support for Hammer
References: <3E664836.7040405@redhat.com> <20030305190622.GA5400@wotan.suse.de> <3E6650D4.8060809@redhat.com> <20030305212107.GB7961@wotan.suse.de> <3E668267.5040203@redhat.com> <20030305210856.B16093@redhat.com>
In-Reply-To: <20030305210856.B16093@redhat.com>
X-Enigmail-Version: 0.73.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Benjamin LaHaise wrote:

> Instead, 
> making x86-64 TLS support based off of the stack pointer, or even using 
> a fixed per-cpu segment register such that gs:0 holds the pointer to the 
> thread "current" would be better.

Gee, here is somebody who knows about thread APIs and ABIs.  You're
really embarrassing yourself.


> Make the users of threads suffer, not 
> every single application and syscall in the system.

Whether you like it or not, people are using threads.  TLS requires a
thread register even in single-threaded applications.  The mechanism I
proposed would use segments if <4GB addresses can be allocated,
otherwise fall back to prctl(ARCH_SET_FS).  This is about as good as you
can get it.

Remove anything and hammer is the only architecture without good thread
support which undoubtedly makes you happy but almost nobody else.

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+ZsX02ijCOnn/RHQRAv87AJ4hHmL0N8ckGGsqROBk439jiUPAVgCgi/1K
NayzBhn7WQwjGATGaDzv0Pc=
=JXCv
-----END PGP SIGNATURE-----

