Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932282AbVLUNUv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbVLUNUv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 08:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932402AbVLUNUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 08:20:51 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:10983 "EHLO
	keetweej.vanheusden.com") by vger.kernel.org with ESMTP
	id S932282AbVLUNUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 08:20:50 -0500
Date: Wed, 21 Dec 2005 14:20:48 +0100
From: Folkert van Heusden <folkert@vanheusden.com>
To: Ed Tomlinson <edt@aei.ca>
Cc: Eric Dumazet <dada1@cosmosbay.com>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>
Subject: Re: [POLL] SLAB : Are the 32 and 192 bytes caches really usefull on
	x86_64 machines ?
Message-ID: <20051221132046.GJ27831@vanheusden.com>
References: <7vbqzadgmt.fsf@assigned-by-dhcp.cox.net>
	<43A91C57.20102@cosmosbay.com> <200512210744.52559.edt@aei.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
Content-Disposition: inline
In-Reply-To: <200512210744.52559.edt@aei.ca>
Organization: www.unixexpert.nl
X-Chameleon-Return-To: folkert@vanheusden.com
X-Xfmail-Return-To: folkert@vanheusden.com
X-Phonenumber: +31-6-41278122
X-URL: http://www.vanheusden.com/
X-PGP-KeyID: 1F28D8AE
X-GPG-fingerprint: AC89 09CE 41F2 00B4 FCF2  B174 3019 0E8C 1F28 D8AE
X-Key: http://pgp.surfnet.nl:11371/pks/lookup?op=get&search=0x1F28D8AE
Read-Receipt-To: <folkert@vanheusden.com>
Reply-By: Thu Dec 22 11:22:45 CET 2005
X-Message-Flag: Want to extend your PGP web-of-trust? Coordinate a key-signing
	at www.biglumber.com
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

> > (x86_64 : PAGE_SIZE = 4096, L1_CACHE_BYTES = 64)
> > On my machines, I can say that the 32 and 192 sizes could be avoided in favor 
> > in spending less cpu cycles in __find_general_cachep()
> > Could some of you post the result of the following command on your machines :
> > # grep "size-" /proc/slabinfo |grep -v DMA|cut -c1-40
> size-131072            0      0 131072
> size-65536             3      3  65536
> size-32768             0      0  32768
> size-16384             3      3  16384
> size-8192             28     28   8192
> size-4096            184    184   4096
> size-2048            272    272   2048
> size-1024            300    300   1024
> size-512             275    376    512
> size-256             717    720    256
> size-192            1120   1220    192
> size-64             7720   8568     64
> size-128           45019  65830    128
> size-32             1627   3333     32

size-131072            0      0 131072
size-65536             0      0  65536
size-32768            20     20  32768
size-16384             8      9  16384
size-8192             37     38   8192
size-4096            269    269   4096
size-2048            793    910   2048
size-1024            564    608   1024
size-512             702    856    512
size-256            1485   4005    256
size-128            1209   1350    128
size-64             2858   3363     64
size-32             1538   2714     64
Intel(R) Xeon(TM) MP CPU 3.00GHz
address sizes   : 40 bits physical, 48 bits virtual


Folkert van Heusden

- -- 
Try MultiTail! Multiple windows with logfiles, filtered with regular
expressions, colored output, etc. etc. www.vanheusden.com/multitail/
- ----------------------------------------------------------------------
Get your PGP/GPG key signed at www.biglumber.com!
- ----------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iIMEARECAEMFAkOpVq48Gmh0dHA6Ly93d3cudmFuaGV1c2Rlbi5jb20vZGF0YS1z
aWduaW5nLXdpdGgtcGdwLXBvbGljeS5odG1sAAoJEDAZDowfKNiuUUEAnR9DJq5M
x+Bj1R+djzCli3bFrJXKAJ9OmCx9FKDaGl6PocRwCZSKURerPA==
=vQhF
-----END PGP SIGNATURE-----
