Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266809AbUFYQsI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266809AbUFYQsI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 12:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266804AbUFYQsI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 12:48:08 -0400
Received: from mout0.freenet.de ([194.97.50.131]:36503 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id S266808AbUFYQq4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 12:46:56 -0400
From: Michael Buesch <mbuesch@freenet.de>
To: Con Kolivas <kernel@kolivas.org>
Subject: Re: [PATCH] Staircase scheduler v7.4
Date: Fri, 25 Jun 2004 18:46:43 +0200
User-Agent: KMail/1.6.2
References: <200406251840.46577.mbuesch@freenet.de>
In-Reply-To: <200406251840.46577.mbuesch@freenet.de>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200406251846.46286.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Friday 25 June 2004 18:40, you wrote:
> Hi,
> 
> I just applied the patch against 2.6.7-bk7 and saw
> the following strange thing:
> 
> I was compiling some program, as suddenly compilation
> stopped. g++ was running (sorry, I didn't look at the
> process state. Maybe it was in T or something like that),
> but it didn't get any timeslice. (so didn't execute. Simply
> stayed around and didn't finish).
> I noticed this since I switched from staircase 7.1 to 7.4
> a few minutes ago. No such problems before.
> I'm not really sure, if it's a staircase problem. Just
> wanted to let you know.

Oh, forgot to say, that load was quite a bit too high.
It was aprox 6.0, but should have been 2.0 (or at absolute
maximum 3.0), as there were not so many running processes.
There was the g++ at nice 0, some process running at nice 19 and
tvtime at nice 0. All other processes were not taking much CPU
and sleeping most of the time. (X and KDE was running, but
I don't think they can cause this load.)

- -- 
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA3FbzFGK1OIvVOP4RAlgbAJ9eOW2vI/8vv6ZGPDWe6ZmGMW2Y2QCfVN64
DuRJpB+G9FSrenG/rlWA8zo=
=YH0g
-----END PGP SIGNATURE-----
