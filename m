Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262898AbTIGFld (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 01:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262893AbTIGFld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 01:41:33 -0400
Received: from lpbproductions.com ([68.98.208.147]:52628 "HELO
	lpbproductions.com") by vger.kernel.org with SMTP id S262898AbTIGFlb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 01:41:31 -0400
From: Matt Heler <lkml@lpbproductions.com>
To: Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]O20int
Date: Sat, 6 Sep 2003 22:41:38 -0700
User-Agent: KMail/1.5.9
References: <200309040053.22155.kernel@kolivas.org>
In-Reply-To: <200309040053.22155.kernel@kolivas.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200309062241.42920.lkml@lpbproductions.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Wow.. I tried 2.6.0-test4-mm4 + your 020 init patch on top .. I've noticed 
consiberable improvements. When I last used your scheduler patches WineX used 
to pauses in Warcraft3 , now no such pauses exist.. and everything seems 
smooth and snappy ..  great work

Matt


On Wednesday 03 September 2003 07:53 am, Con Kolivas wrote:
> D----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Fine tuning mainly.
>
> Smaller timeslice granularity for most interactive tasks and larger for
> less interactive. Smaller for each extra cpu.
>
> Smaller bounds on interactive credit.
>
> Idle tasks can gain interactive credits; Idle tasks get more interactivity;
> Uninterruptible sleep wakers are not seen as idle.
>
> Kernel threads participate in timeslice granularity requeuing.
>
> This patch is incremental on top of O19int which is included in
> 2.6.0-test4-mm4. It will not apply onto mm5 which has all my stuff backed
> out. This patch and a full patch against 2.6.0-test4 can be found here:
>
> http://kernel.kolivas.org/2.5
>
> Con
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.2 (GNU/Linux)
>
> iD8DBQE/VgBaZUg7+tp6mRURAtvgAJoClT078T9wLLlEq8+pct3Yigrq3wCgja4P
> HjXKw3YJSey4DWpA2I+Tyi4=
> =nvCB
> -----END PGP SIGNATURE-----
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/WsUUleY/n9G/oZ8RAgXcAJ43BQouqQkq1IVz6ujh1P44xnl/dACfTg4J
6KRKy+GrhNu2FC3rPSruT6M=
=fwqL
-----END PGP SIGNATURE-----
