Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265643AbUABVK3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 16:10:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265644AbUABVK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 16:10:29 -0500
Received: from h80ad254a.async.vt.edu ([128.173.37.74]:43967 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S265643AbUABVK1 (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 16:10:27 -0500
Message-Id: <200401022110.i02LALKa014919@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.0 batch scheduling, HT aware 
In-Reply-To: Your message of "Fri, 02 Jan 2004 12:56:16 PST."
             <Pine.LNX.4.44.0401021252070.2488-100000@bigblue.dev.mdolabs.com> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.44.0401021252070.2488-100000@bigblue.dev.mdolabs.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1718534732P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 02 Jan 2004 16:10:21 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1718534732P
Content-Type: text/plain; charset=us-ascii

On Fri, 02 Jan 2004 12:56:16 PST, Davide Libenzi said:
> On Fri, 2 Jan 2004, Bill Davidsen wrote:
> 
> > Yes and even worse, if you stop running setiathome the scientific task 
> > *still* only gets half the available CPU!
> 
> Look that this is not true. If one core is not running any task, the idle 
> task (if not polling) does "hlt" and the "what they call Fetch And 

What Bill said was:

>> memory-bound seti&home at CPU1. Even without hyperthreading, your
>> scientific task is going to run at 50% of speed and seti&home is going
>> to get second half. Oops.

> Yes and even worse, if you stop running setiathome the scientific task 
> *still* only gets half the available CPU!

So Bill is pointing out that on a *normal* SMP, you get 50% whether or
not the other processor is busy.

> The difference is that with HT running a task on one sibling actually 
> does (or can) slow the other. That's not true with true SMP, at least 
> not directly, since the resourses shared (memory and disk) are much 
> farther away from the CPU.

And this is where Bill talks about issues like the one you mentioned about
sharing the dispatch engine.

So I think you and Bill are actually saying the same exact thing.


--==_Exmh_-1718534732P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/9d49cC3lWbTT17ARAiKEAKDbpqkiJTBPAqwfV6l0rORurTYBBQCgwjd7
qJOPKxKKo0M2Dgf3kHSEk0s=
=JNol
-----END PGP SIGNATURE-----

--==_Exmh_-1718534732P--
