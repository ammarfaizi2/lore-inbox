Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264903AbUAHOJa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 09:09:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264917AbUAHOJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 09:09:30 -0500
Received: from trinity.webmaking.ms ([213.131.251.60]:26837 "HELO
	trinity.webmaking.ms") by vger.kernel.org with SMTP id S264903AbUAHOJ0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 09:09:26 -0500
Date: Thu, 8 Jan 2004 15:09:17 +0100
From: Thomas Fischbach <webmaster@kennygno.net>
To: davidsen@tmr.com (bill davidsen)
Cc: linux-kernel@vger.kernel.org
Subject: Re: can't mount encrypted dvd with 2.6.0
Message-Id: <20040108150917.18537b1e@kyp.intra>
In-Reply-To: <bti3g1$7lt$1@gatekeeper.tmr.com>
References: <20040107151948.4376d881@kyp.intra>
	<bti3g1$7lt$1@gatekeeper.tmr.com>
X-Mailer: Sylpheed version 0.9.8claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Thu__8_Jan_2004_15_09_17_+0100_7ha/eAozfzUuHURc"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Thu__8_Jan_2004_15_09_17_+0100_7ha/eAozfzUuHURc
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On 7 Jan 2004 23:07:45 GMT
davidsen@tmr.com (bill davidsen) wrote:

> In article <20040107151948.4376d881@kyp.intra>,
> Thomas Fischbach  <webmaster@kennygno.net> wrote:
> 
> | if I create an encrypted iso image:
> | dd if=/dev/zero of=/files/image.iso bs=512 count=$((1024*4400))
> | losetup -e aes -k 256 /dev/loop1 /files/image.iso
> | mkisofs -r -o /dev/loop1 /files/stuff/*
> ===> try adding -pad here

[...]

I think -pad is used by default.

I tried the patch from Ben and it works.
http://testing.lkml.org/slashdot.php?mid=442410

Thanks

-- 
Thomas Fischbach
http://www.kennygno.net
webmaster@kennygno.net

--Signature=_Thu__8_Jan_2004_15_09_17_+0100_7ha/eAozfzUuHURc
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQE//WSNhty018ANwB4RAr18AJ9YTifHbmGt3cGql4eWWXD+qUANCwCcC7uj
svUELgyxPMCaHsgKRPhUbzk=
=xBQG
-----END PGP SIGNATURE-----

--Signature=_Thu__8_Jan_2004_15_09_17_+0100_7ha/eAozfzUuHURc--
