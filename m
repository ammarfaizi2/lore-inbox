Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264463AbUBOKf5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 05:35:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264484AbUBOKf5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 05:35:57 -0500
Received: from main.gmane.org ([80.91.224.249]:53665 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264463AbUBOKfy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 05:35:54 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jan Rychter <jan@rychter.com>
Subject: Re: Oopsing cryptoapi (or loop device?) on 2.6.*
Date: Sat, 14 Feb 2004 18:35:35 -0800
Message-ID: <m265e9oyrs.fsf@tnuctip.rychter.com>
References: <402A4B52.1080800@centrum.cz> <402A7765.FD5A7F9E@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 66-27-68-14.san.rr.com
X-Spammers-Please: blackholeme@rychter.com
User-Agent: Gnus/5.110002 (No Gnus v0.2) XEmacs/21.4 (Reasonable Discussion,
 linux)
Cancel-Lock: sha1:+acFdwhC0MWWSuCNfS6znW8NmeE=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

>>>>> "Jari" == Jari Ruusu <jariruusu@users.sourceforge.net> writes:
 Jari> Michal Kwolek wrote:
 >> I've got a reproducible oops when using cryptoloop on vanilla 2.6.0,
 >> 2.6.1 and 2.6.2 (2.4.* works fine).
 >>
 >> Way to reproduce: dd if=/dev/urandom of=crypto bs=1024
 >> count=some_size losetup -e some_cipher /dev/loop0 crypto
 >> #Any of those commands causes oops and hard lockup:
 >> cp /dev/loop0 /dev/null mkreiserfs /dev/loop0 mkfs.ext2 /dev/loop0
 >>
 >> Loop without cryptoapi works fine: dd if=/dev/urandom of=crypto
 >> bs=1024 count=some_size losetup /dev/loop0 crypto cp /dev/loop0
 >> /dev/null
 >> #ok, no oops

 Jari> Can you try again using loop-AES? loop-AES does not fall apart
 Jari> like the mainline implementation does. loop-AES is here:

FWIW, I've just tried loop-AES with 2.4.24, after using cryptoapi for a
number of years. My machine froze dead in the midst of copying 2.8GB of
data onto my file-backed reiserfs encrypted loopback mount.

Since the system didn't ever freeze on me before and since I've had zero
problems with cryptoapi, I attribute the freeze to loop-AES.

Yes, I know this isn't a good bugreport...

--J.

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQBALtr8Lth4/7/QhDoRAkbxAJ9X+/+4/dDPJwgEA795MfFSkwUqLgCgzsXX
kP5/je59BYfoky4/HC/au20=
=XDbn
-----END PGP SIGNATURE-----
--=-=-=--

