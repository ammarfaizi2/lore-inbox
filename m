Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264925AbUAHO6h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 09:58:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264954AbUAHO6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 09:58:36 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:14862 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S264925AbUAHO6d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 09:58:33 -0500
Date: Thu, 8 Jan 2004 09:46:23 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Thomas Fischbach <webmaster@kennygno.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: can't mount encrypted dvd with 2.6.0
In-Reply-To: <20040108150917.18537b1e@kyp.intra>
Message-ID: <Pine.LNX.3.96.1040108094236.12465C-101000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: MULTIPART/SIGNED; PROTOCOL="application/pgp-signature"; MICALG=pgp-sha1; BOUNDARY="Signature=_Thu__8_Jan_2004_15_09_17_+0100_7ha/eAozfzUuHURc"
Content-ID: <Pine.LNX.3.96.1040108094236.12465D@gatekeeper.tmr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--Signature=_Thu__8_Jan_2004_15_09_17_+0100_7ha/eAozfzUuHURc
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.3.96.1040108094236.12465E@gatekeeper.tmr.com>

On Thu, 8 Jan 2004, Thomas Fischbach wrote:

> On 7 Jan 2004 23:07:45 GMT
> davidsen@tmr.com (bill davidsen) wrote:
> 
> > In article <20040107151948.4376d881@kyp.intra>,
> > Thomas Fischbach  <webmaster@kennygno.net> wrote:
> > 
> > | if I create an encrypted iso image:
> > | dd if=/dev/zero of=/files/image.iso bs=512 count=$((1024*4400))
> > | losetup -e aes -k 256 /dev/loop1 /files/image.iso
> > | mkisofs -r -o /dev/loop1 /files/stuff/*
> > ===> try adding -pad here
> 
> [...]
> 
> I think -pad is used by default.

-pad is used by default on cdrecord, but not on mkisofs AFAIK. Since you
didn't specify how you did the burn, or I missed it, I thought it was
worth a try in case you were using some other software.

> 
> I tried the patch from Ben and it works.
> http://testing.lkml.org/slashdot.php?mid=442410

Then hopefully it will appear in a future bk after additional testing.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

--Signature=_Thu__8_Jan_2004_15_09_17_+0100_7ha/eAozfzUuHURc
Content-Type: APPLICATION/PGP-SIGNATURE
Content-ID: <Pine.LNX.3.96.1040108094236.12465F@gatekeeper.tmr.com>
Content-Description: 

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQE//WSNhty018ANwB4RAr18AJ9YTifHbmGt3cGql4eWWXD+qUANCwCcC7uj
svUELgyxPMCaHsgKRPhUbzk=
=xBQG
-----END PGP SIGNATURE-----

--Signature=_Thu__8_Jan_2004_15_09_17_+0100_7ha/eAozfzUuHURc--
