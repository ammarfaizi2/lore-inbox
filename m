Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262518AbTHUIcd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 04:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262522AbTHUIcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 04:32:33 -0400
Received: from 13.2-host.augustakom.net ([80.81.2.13]:27520 "EHLO phoebee")
	by vger.kernel.org with ESMTP id S262518AbTHUIc3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 04:32:29 -0400
Date: Thu, 21 Aug 2003 10:32:27 +0200
From: Martin Zwickel <martin.zwickel@technotrend.de>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-t3: vfs/ext3 do_lookup bug?!
Message-Id: <20030821103227.7d8fe531.martin.zwickel@technotrend.de>
In-Reply-To: <20030821004018.1fb79bbb.akpm@osdl.org>
References: <20030820171431.0211930e.martin.zwickel@technotrend.de>
	<20030820113625.6a75d699.akpm@osdl.org>
	<bi0grq$49r$1@build.pdx.osdl.net>
	<20030821083337.6fc701b9.martin.zwickel@technotrend.de>
	<20030820234119.33362f7a.akpm@osdl.org>
	<20030821092534.0eb08a89.martin.zwickel@technotrend.de>
	<20030821004018.1fb79bbb.akpm@osdl.org>
Organization: TechnoTrend AG
X-Mailer: Sylpheed version 0.9.3claws36 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Operating-System: Linux Phoebee 2.4.21-rc4 i686 Intel(R) Pentium(R) 4 CPU
 2.40GHz
X-Face: $rTNP}#i,cVI9h"0NVvD.}[fsnGqI%3=N'~,}hzs<FnWK/T]rvIb6hyiSGL[L8S,Fj`u1t.
 ?J0GVZ4&
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="sE96j45C.p=.?B),"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--sE96j45C.p=.?B),
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Aug 2003 00:40:18 -0700
Andrew Morton <akpm@osdl.org> bubbled:

> Sigh.  Well the filesystem obviously shat itself, so the fsck errors aren't
> that surprising.
> 
> My guess would be that something oopsed while holding a directory semaphore
> and you missed the oops.  Maybe you were in X at the time?

yes, but I cant find an oops in my /var/log/messages and .?.gz. the last oops
is a month ago.
well, something really strange happened and if it happens again, i'll try to
figure it out what went wrong.

> 
> If it happens again, please remember that dmesg needs the `-s 1000000'
> option to prevent it from truncating output.

yep, will do that next time.

> 
> > ps.: 2.6.0-t3 scheduler performance is not that good...
> 
> It's pretty bad.  I'm running 2.6.0-test3-mm1 here which has Ingo/Con
> goodies and it is significantly improved.
> 
> Once that code is working sufficiently well for everyone and there is
> consensus that the general direction is correct and the possible
> regressions with mixed database workloads are sorted out, we'll fix it up. 
> So don't panic yet.

I tried many patches for test2. and some worked not that bad.
ok, i'll give -mm1 a try.

and thx for the help.

Regards,
Martin

-- 
MyExcuse:
temporary routing anomaly

Martin Zwickel <martin.zwickel@technotrend.de>
Research & Development

TechnoTrend AG <http://www.technotrend.de>

--sE96j45C.p=.?B),
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/RIObmjLYGS7fcG0RArOHAJ9jt1FZe/tc9hErAPrx5xbFWlYzCwCfU4p4
JzY0jBdL+jhFTZoWFlLHN6A=
=NDsp
-----END PGP SIGNATURE-----

--sE96j45C.p=.?B),--
