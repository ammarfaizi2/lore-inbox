Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268247AbUJDPjq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268247AbUJDPjq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 11:39:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268214AbUJDPiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 11:38:50 -0400
Received: from 13.2-host.augustakom.net ([80.81.2.13]:49065 "EHLO phoebee.mail")
	by vger.kernel.org with ESMTP id S268223AbUJDPfI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 11:35:08 -0400
Date: Mon, 4 Oct 2004 17:35:05 +0200
From: Martin Zwickel <martin.zwickel@technotrend.de>
To: linux-kernel@vger.kernel.org
Subject: Re: net_device: set_multicast_list called from interrupt?
Message-ID: <20041004173505.7c441a1d@phoebee>
In-Reply-To: <20041004172621.3dd8945f@phoebee>
References: <20041004172621.3dd8945f@phoebee>
X-Mailer: Sylpheed-Claws 0.9.12cvs53 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Operating-System: Linux Phoebee 2.6.7-rc2-mm2 i686 Intel(R) Pentium(R) 4
 CPU 2.40GHz
X-Face: $rTNP}#i,cVI9h"0NVvD.}[fsnGqI%3=N'~,}hzs<FnWK/T]rvIb6hyiSGL[L8S,Fj`u1t.
 ?J0GVZ4&
Organization: Technotrend AG
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Mon__4_Oct_2004_17_35_05_+0200_ZZ8SygfHqhCKgHGV"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Mon__4_Oct_2004_17_35_05_+0200_ZZ8SygfHqhCKgHGV
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Mon, 4 Oct 2004 17:26:21 +0200
Martin Zwickel <martin.zwickel@technotrend.de> bubbled:

> Hi there!
> 
> I don't know if this is the right place, but I hope so.
> 
> I wrote a network-driver years ago for the 2.4er kernel's.
> 
> Now I ported it to the 2.6er kernel but I get some problems because
> set_multicast_list is called from an interrupt and my driver want's to
> free/allocate some memory.
> 
> Why did the driver work under 2.4, and now stops running on 2.6?
> 
> I had a look at http://lwn.net/Articles/30107/:
> Driver porting: Network drivers
> 
> but there was nothing about newly implemented soft-interrupts.
> 
> Thanks,
> Martin
> 

Ah, just tested it under 2.4er. It's called from an interrupt too.
So I have to workaround the free/alloc.

Sorry!

Martin

-- 
MyExcuse:
Your EMAIL is now being delivered by the USPS.

Martin Zwickel <martin.zwickel@technotrend.de>
Research & Development

TechnoTrend AG <http://www.technotrend.de>

--Signature=_Mon__4_Oct_2004_17_35_05_+0200_ZZ8SygfHqhCKgHGV
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBYW2pmjLYGS7fcG0RAvnsAKCtfmdZhXilNnMkC3nGiy/msBvnhwCgo5hq
qFSh31BlYG3ynj5UbRRq0XY=
=HCST
-----END PGP SIGNATURE-----

--Signature=_Mon__4_Oct_2004_17_35_05_+0200_ZZ8SygfHqhCKgHGV--
