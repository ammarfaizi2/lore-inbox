Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269352AbUIYPTp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269352AbUIYPTp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 11:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269353AbUIYPTp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 11:19:45 -0400
Received: from mx1.redhat.com ([66.187.233.31]:60584 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269352AbUIYPTn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 11:19:43 -0400
Message-ID: <41558C6D.4050305@redhat.com>
Date: Sat, 25 Sep 2004 08:19:09 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a4) Gecko/20040923
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [time] add support for CLOCK_THREAD_CPUTIME_ID and CLOCK_PROCESS_CPUTIME_ID
References: <B6E8046E1E28D34EB815A11AC8CA312902CD3264@mtv-atc-605e--n.corp.sgi.com> <Pine.LNX.4.58.0409240508560.5706@schroedinger.engr.sgi.com> <4154F349.1090408@redhat.com> <Pine.LNX.4.58.0409242253080.13099@schroedinger.engr.sgi.com> <41550B77.1070604@redhat.com> <Pine.LNX.4.58.0409250743230.15887@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.58.0409250743230.15887@schroedinger.engr.sgi.com>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Christoph Lameter wrote:

> Yes and glibc will have to get through contortions to
> simulate a clock that returns the actual cpu time used. Why not cleanly
> do the clock_gettime syscall without doing any redirection of clocks?

First of all, unnecessary kernel code where it is not needed.  And
second, because with the definition of the CPUTIME clock in use for many
years now not all variants can be handled in the kernel.  We use this
clock to provide access to the TSC functionality.  This is nothing the
kernel does.


> Any implementation of the CPUTIME clocks is always easier to do in the
> kernel with just a few lines.

No, you don't know the glibc side.


> Ok, I will dig out my old patch and repost it to glibc-alpha.

I haven't gotten an answer to the question "is there really any value in
this kind of clock?".

- --
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBVYxt2ijCOnn/RHQRAmohAKCVAlRAxIHBi5uHqoKtfjfORQQNiACdHPuD
aCn2+pHl7MnBmWE2CAmSdb8=
=vJAO
-----END PGP SIGNATURE-----
