Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262886AbTCKJiL>; Tue, 11 Mar 2003 04:38:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262885AbTCKJiL>; Tue, 11 Mar 2003 04:38:11 -0500
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:51879 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id <S262886AbTCKJiJ> convert rfc822-to-8bit;
	Tue, 11 Mar 2003 04:38:09 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Alastair Stevens <alastair.stevens@mrc-bsu.cam.ac.uk>
Subject: Re: VM / OOM troubles in 2.4.20-ck4 (-aa VM)
Date: Tue, 11 Mar 2003 20:48:41 +1100
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <Pine.GSO.4.50.0303041249251.5801-100000@quaratino> <200303051127.33140.kernel@kolivas.org> <Pine.GSO.4.50.0303110904211.3993-100000@quaratino>
In-Reply-To: <Pine.GSO.4.50.0303110904211.3993-100000@quaratino>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Message-Id: <200303112048.46565.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tue, 11 Mar 2003 20:10, Alastair Stevens wrote:
> > > Our dual Athlon server with 512Mb RAM / 1.2Gb swap, and not
> > > particularly heavily loaded, lasted 81 days with 2.4.20-ck1 under
> > > RH8.0, and then succumbed with these errors:
> > >
> > >   VM error: killing process wineserver
> > >    _alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
> >
> > I'm not aware of any memory leak / vm problems with -ck although that may
> > be possible. However ck4 does not have the OOM killer enabled so it's not
> > that in action; you simply have run out of memory and it can't allocate
> > any more. Have you tried without the aa vm addons in ck? Does this happen
> > with vanilla 2.4.20? -ck is a very different branch.
>
> FWIW - these problems don't appear to be happening with stock
> 2.4.21-pre5. Of course I can't say for sure, since the circumstances
> will never be te same twice, but the machine survived the same sort of
> hammering as the other day (with memory and swap almost full), but is
> now happily relaxing again:
>
>         total:    used:    free:  shared: buffers:  cached:
> Mem:  528072704 410812416 117260288        0 113184768 66420736
> Swap: 1258426368 23404544 1235021824
> MemTotal:       515696 kB
> MemFree:        114512 kB
> MemShared:           0 kB
> Buffers:        110532 kB
> Cached:          56848 kB
> SwapCached:       8016 kB
> Active:         131172 kB
> Inactive:        86036 kB
> HighTotal:           0 kB
> HighFree:            0 kB
> LowTotal:       515696 kB
> LowFree:        114512 kB
> SwapTotal:     1228932 kB
> SwapFree:      1206076 kB
>
> So this time, WINE does _not_ appear to have been leaking like a sieve!
> Stranger and stranger....

Cannot pass judgement on that alone. It must be fully reproducible in some way 
and not happen with another kernel.

If it really is my kernel then I do want to know what the cause is. Ideally 
testing -ck4 without the aa vm addons (just reverse patch it) and see if that 
makes the problem go away. I'm no VM hacker though, and if it turns out to be 
the vm addons then you should test an -aa kernel with the vm addons and see 
if that exhibits the same problem. _Then_ you can tell AA about it. All of 
this depends on whether you can find some way of reproducing the problem and 
are interested in helping debug it :-P

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE+bbD7F6dfvkL3i1gRAjHfAJ4iv5/FMglzMeY2PGcf+MGJGeVnHACeI/Sz
GPUNSgrWvcBgNE+9TBf1e1s=
=R4hY
-----END PGP SIGNATURE-----

