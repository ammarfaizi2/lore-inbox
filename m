Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265027AbUF1PUY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265027AbUF1PUY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 11:20:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265025AbUF1PUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 11:20:24 -0400
Received: from mail009.syd.optusnet.com.au ([211.29.132.64]:7077 "EHLO
	mail009.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S265027AbUF1PUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 11:20:11 -0400
Message-ID: <40E03713.9010208@kolivas.org>
Date: Tue, 29 Jun 2004 01:19:47 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7 (X11/20040615)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Oswald Buddenhagen <ossi@kde.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Staircase scheduler v7.4
References: <200406251840.46577.mbuesch@freenet.de> <200406261929.35950.mbuesch@freenet.de> <1088363821.1698.1.camel@teapot.felipe-alfaro.com> <200406272128.57367.mbuesch@freenet.de> <1088373352.1691.1.camel@teapot.felipe-alfaro.com> <Pine.LNX.4.58.0406281013590.11399@kolivas.org> <1088412045.1694.3.camel@teapot.felipe-alfaro.com> <40DFDBB2.7010800@yahoo.com.au> <1088423626.1699.0.camel@teapot.felipe-alfaro.com> <40E00AEA.4050709@kolivas.org> <20040628150343.GD2478@ugly.local>
In-Reply-To: <20040628150343.GD2478@ugly.local>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Oswald Buddenhagen wrote:
| On Mon, Jun 28, 2004 at 10:11:22PM +1000, Con Kolivas wrote:
|
|>The design of staircase would make renicing normal interactive things
|>-ve values bad for the latency of other nice 0 tasks s is not
|>recommended for X or games etc. Initial scheduling latency is very
|>dependent on nice value in staircase. If you set a cpu hog to nice -5
|>it will hurt audio at nice 0 and so on.
|>
|
| i think using nice for both cpu share and latency is broken by design ...
| a typical use case on my system: for real-time tv recording i need
| mencoder to get some 80% of the cpu time on average. that means i have
| to nice -<something "big"> it to prevent compiles, flash plugins running
| amok, etc. from making mencoder explode (i.e., overrun buffers). but that
| entirely destroys interactivity; in fact the desktop becomes basically
| unusable.

You want mencoder to use 80% of your cpu and be scheduled fast enough to
not drop frames. Sounds to me like both latency and cpu share are
required, no? And if something uses up 80% of your cpu your
interactivity drops. Why is that a surprise? If something wants lower
latency but doesnt want a lot of cpu, it will only use what it wants. I
don't see a problem here.

If X is not smooth, then that is a problem. This scheduler is still
under development.

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFA4DcTZUg7+tp6mRURAirZAJ9703erbnS4UikDhpXGn41JuHxaqgCeIshy
099yGuzDyg3BLCEI5/S5xLo=
=xuB1
-----END PGP SIGNATURE-----
