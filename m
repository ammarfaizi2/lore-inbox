Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265743AbSJTCxg>; Sat, 19 Oct 2002 22:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265745AbSJTCxg>; Sat, 19 Oct 2002 22:53:36 -0400
Received: from c16688.thoms1.vic.optusnet.com.au ([210.49.244.54]:26249 "EHLO
	pc.kolivas.net") by vger.kernel.org with ESMTP id <S265743AbSJTCxe>;
	Sat, 19 Oct 2002 22:53:34 -0400
Content-Type: text/plain; charset=US-ASCII
From: Con Kolivas <conman@kolivas.net>
Reply-To: conman@kolivas.net
To: Andrew Morton <akpm@digeo.com>
Subject: Re: Pathological case identified from contest
Date: Sun, 20 Oct 2002 12:59:13 +1000
User-Agent: KMail/1.4.3
References: <1034820820.3dae1cd4bc0e3@kolivas.net> <1034839006.3dae63de3f69a@kolivas.net> <3DAE6826.72C345EE@digeo.com>
In-Reply-To: <3DAE6826.72C345EE@digeo.com>
Cc: Rik van Riel <riel@conectiva.com.br>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210201259.34935.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Thu, 17 Oct 2002 05:35 pm, you wrote:
> Con Kolivas wrote:
> > ...
> > Well this has become more common with 2.5.43-mm2. I had to abort the
> > process_load run 3 times when benchmarking it. Going back to other
> > kernels and trying them it didnt happen so I dont think its my hardware
> > failing or something like that.
>
> No, it's a bug in either the pipe code or the CPU scheduler I'd say.
>
> You could try backing out to the 2.5.40 pipe implementation; not sure if
> that would tell us much though.

I massaged the patch a little for it to apply and  it _is_ the offending code. 
Backing out the pipe changes fixed the problem. I was unable to reproduce the 
holdup I was seeing with process_load even at higher data sizes. Now what?

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9shwEF6dfvkL3i1gRAkQgAJ9J3uKeQ5AT3vCPPbGKgk0xuW4V1gCfXBJ3
93vaP5XLpT/WRGAqcVOxVkU=
=OluT
-----END PGP SIGNATURE-----
