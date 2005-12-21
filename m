Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932276AbVLUOJF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932276AbVLUOJF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 09:09:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932424AbVLUOJF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 09:09:05 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:40842 "EHLO
	keetweej.vanheusden.com") by vger.kernel.org with ESMTP
	id S932276AbVLUOJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 09:09:04 -0500
Date: Wed, 21 Dec 2005 15:09:02 +0100
From: Folkert van Heusden <folkert@vanheusden.com>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Ed Tomlinson <edt@aei.ca>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>
Subject: Re: [POLL] SLAB : Are the 32 and 192 bytes caches really usefull
	on	x86_64 machines ?
Message-ID: <20051221140901.GM27831@vanheusden.com>
References: <7vbqzadgmt.fsf@assigned-by-dhcp.cox.net>
	<43A91C57.20102@cosmosbay.com> <200512210744.52559.edt@aei.ca>
	<20051221132046.GJ27831@vanheusden.com>
	<43A95ABF.1030309@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
Content-Disposition: inline
In-Reply-To: <43A95ABF.1030309@cosmosbay.com>
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
X-Message-Flag: MultiTail - tail on steroids
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

> >size-131072            0      0 131072
> >size-65536             0      0  65536
> >size-32768            20     20  32768
> >size-16384             8      9  16384
> >size-8192             37     38   8192
> >size-4096            269    269   4096
> >size-2048            793    910   2048
> >size-1024            564    608   1024
> >size-512             702    856    512
> >size-256            1485   4005    256
> >size-128            1209   1350    128
> >size-64             2858   3363     64
> >size-32             1538   2714     64
> >Intel(R) Xeon(TM) MP CPU 3.00GHz
> >address sizes   : 40 bits physical, 48 bits virtual
> 
> Your results are interesting : size-32 seems to use objects of size 64 !
> > size-32             1538   2714     64 <<HERE>>
> So I guess that size-32 cache could be avoided at least for EMT (I take you 
> run a 64 bits kernel ?)

I think I do yes:
Linux xxxxx 2.4.21-37.EL #1 SMP Wed Sep 7 13:32:18 EDT 2005 x86_64 x86_64 x86_64 GNU/Linux
It is a redhat 4 x64 system.
Also from /proc/cpuinfo:
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

iIMEARECAEMFAkOpYf08Gmh0dHA6Ly93d3cudmFuaGV1c2Rlbi5jb20vZGF0YS1z
aWduaW5nLXdpdGgtcGdwLXBvbGljeS5odG1sAAoJEDAZDowfKNiugqYAoJWSoI9M
O1sYrhWfFCoyTWweGN29AKCfPy46A1XHYC598IN4TXRSV2u6QA==
=xMjS
-----END PGP SIGNATURE-----
