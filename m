Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266219AbUG0CIM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266219AbUG0CIM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 22:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266221AbUG0CIM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 22:08:12 -0400
Received: from c3p0.cc.swin.edu.au ([136.186.1.30]:32014 "EHLO swin.edu.au")
	by vger.kernel.org with ESMTP id S266219AbUG0CIH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 22:08:07 -0400
To: Clemens Schwaighofer <cs@tequila.co.jp>
Cc: Andrew Morton <akpm@osdl.org>, kernel@kolivas.org, Joel.Becker@oracle.com,
       linux-kernel@vger.kernel.org
From: Tim Connors <tconnors+linuxkernel1090893567@astro.swin.edu.au>
Subject: Re:  Autotune swappiness01
In-reply-to: <4105AD1C.2050507@tequila.co.jp>
References: <cone.1090801520.852584.20693.502@pc.kolivas.org>	<20040725173652.274dcac6.akpm@osdl.org>	<cone.1090802581.972906.20693.502@pc.kolivas.org>	<20040726202946.GD26075@ca-server1.us.oracle.com>	<20040726134258.37531648.akpm@osdl.org>	<cone.1090882721.156452.20693.502@pc.kolivas.org>	<4105A761.9090905@tequila.co.jp> <20040726180943.4c871e4f.akpm@osdl.org> <4105AD1C.2050507@tequila.co.jp>
X-Face: m+g#A-,3D0}Ygy5KUD`Hckr=I9Au;w${NzE;Iz!6bOPqeX^]}KGt=l~r!8X|W~qv'`Ph4dZczj*obWD25|2+/a5.$#s23k"0$ekRhi,{cP,CUk=}qJ/I1acc
Message-ID: <slrn-0.9.7.4-15175-21673-200407271159-tc@hexane.ssi.swin.edu.au>
Date: Tue, 27 Jul 2004 12:03:29 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clemens Schwaighofer <cs@tequila.co.jp> said on Tue, 27 Jul 2004 10:17:16 +0900:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Andrew Morton wrote:
> | Clemens Schwaighofer <cs@tequila.co.jp> wrote:
> 
> |>I have 1 GB and I had a setting of 51 (seemed to be perhaps gentoo
> |>default or so) and I especially after a weekend (2 days off) it is
> |>always the "monday-morning-swap-hell" where I have to wait 5min until he
> |>swapped in the apps he swapped out during weekend.
> |>
> |>I changed that to 20 now, but I don't know if this will make things
> |>worse or better.
> |
> | It may appear to be better, but you now have 100, maybe 200 megabytes less
> | pagecache available across the entire working day.
> 
> which might slow down overall working speed? or responsness of programs?

Depends on what you do. Do you compile kernels regularly? In
particular, do you have to wait for them, or do you just let them sit
in the background, and come back to them when you rememeber, since
you've been busy doing real work for the past 5 hours? If you wait,
then I guess you want high swapiness.

For the rest of us who don't have to regularly read in hundreds of
megs of disk, and don't need to use that hundreds of megs of disk over
and over and over again (As far as I can see, this is just about
everyone who's not a kernel developer or some big app developer[1]), I
guess we get by just fine having smaller swapiness.

[1] Maybe kde is bloated enough that you if want to start the equiv of
an xterm all the time, maybe caching helps a lot there, but I make a
point of using lean apps[2].

[2] Sad when you consider xemacs lean, isn't it? ;)

-- 
TimC -- http://astronomy.swin.edu.au/staff/tconnors/
-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GS d- s:- a-- C+++(++++) UL(SOBI)+++(++++) P+++ L+++ E++(----)
W++(--) N+++ o K+++ w---(++) O- M--(+) V PS++ PE-(--) Y PGP t->+
!5 X R? tv- b- DI+ D--- G e++>++++ h* r(--) !y+
------END GEEK CODE BLOCK------
