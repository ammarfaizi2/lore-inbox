Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263118AbTIAAYo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 20:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263121AbTIAAYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 20:24:44 -0400
Received: from newsmtp.golden.net ([199.166.210.106]:6411 "EHLO
	newsmtp.golden.net") by vger.kernel.org with ESMTP id S263118AbTIAAYj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 20:24:39 -0400
Date: Sun, 31 Aug 2003 20:24:12 -0400
From: Paul Mundt <lethal@linux-sh.org>
To: Jamie Lokier <jamie@shareable.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
Message-ID: <20030901002412.GA16537@linux-sh.org>
Mail-Followup-To: Jamie Lokier <jamie@shareable.org>,
	linux-kernel@vger.kernel.org
References: <20030829053510.GA12663@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
In-Reply-To: <20030829053510.GA12663@mail.jlokier.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 29, 2003 at 06:35:10AM +0100, Jamie Lokier wrote:
> I'd appreciate if folks would run the program below on various
> machines, especially those whose caches aren't automatically coherent
> at the hardware level.
>
sh (VIPT cache):

Test separation: 4096 bytes: FAIL - cache not coherent
Test separation: 8192 bytes: FAIL - cache not coherent
Test separation: 16384 bytes: pass
Test separation: 32768 bytes: pass
Test separation: 65536 bytes: pass
Test separation: 131072 bytes: pass
Test separation: 262144 bytes: pass
Test separation: 524288 bytes: pass
Test separation: 1048576 bytes: pass
Test separation: 2097152 bytes: pass
Test separation: 4194304 bytes: pass
Test separation: 8388608 bytes: pass
Test separation: 16777216 bytes: pass
VM page alias coherency test: minimum fast spacing: 16384 (4 pages)

$ cat /proc/cpuinfo
machine         : Sega Dreamcast
processor       : 0
cpu family      : sh4
cpu type        : SH7750
cache size      : 8K-bytes/16K-bytes
bogomips        : 199.06
cpu clock       : 199.49MHz
bus clock       : 99.74MHz
module clock    : 49.87MHz

and on sh64 (which is sort of VIPT/VIVT, as it looks at physical tags if
there's no match on virtual):

Test separation: 4096 bytes: FAIL - cache not coherent
Test separation: 8192 bytes: pass
Test separation: 16384 bytes: pass
Test separation: 32768 bytes: pass
Test separation: 65536 bytes: pass
Test separation: 131072 bytes: pass
Test separation: 262144 bytes: pass
Test separation: 524288 bytes: pass
Test separation: 1048576 bytes: pass
Test separation: 2097152 bytes: pass
Test separation: 4194304 bytes: pass
Test separation: 8388608 bytes: pass
Test separation: 16777216 bytes: pass
VM page alias coherency test: minimum fast spacing: 8192 (2 pages)

-sh-2.05b$ cat /proc/cpuinfo
machine         : Hitachi Cayman
processor       : 0
cpu family      : SH-5
cpu type        : SH5-101
icache size     : 32K-bytes
dcache size     : 32K-bytes
itlb entries    : 64
dtlb entries    : 64
cpu clock       : 314.73MHz
bus clock       : 157.36MHz
module clock    : 26.22MHz
bogomips        : 313.75


--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/UpGs1K+teJFxZ9wRAhdwAJ0RQw0PxDTttMmC2auTc4WDKGJWeQCfR4ip
yU6b6U1UYYtXNWpM0VG1Yds=
=Mftm
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
