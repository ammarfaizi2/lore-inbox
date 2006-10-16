Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161026AbWJPUaX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161026AbWJPUaX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 16:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161052AbWJPUaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 16:30:22 -0400
Received: from ns2.uludag.org.tr ([193.140.100.220]:51927 "EHLO uludag.org.tr")
	by vger.kernel.org with ESMTP id S1161026AbWJPUaV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 16:30:21 -0400
From: "=?iso-8859-9?q?S=2E=C7a=F0lar?= Onur" <caglar@pardus.org.tr>
Reply-To: caglar@pardus.org.tr
Organization: =?utf-8?q?T=C3=9CB=C4=B0TAK_/?= UEKAE
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: Re: Ondemand/Conservative not working with 2.6.18
Date: Mon, 16 Oct 2006 23:29:17 +0300
User-Agent: KMail/1.9.5
Cc: "Dave Jones" <davej@redhat.com>, linux-kernel@vger.kernel.org
References: <EB12A50964762B4D8111D55B764A8454BA3D91@scsmsx413.amr.corp.intel.com>
In-Reply-To: <EB12A50964762B4D8111D55B764A8454BA3D91@scsmsx413.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2432754.jDyiO4d1Dj";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200610162329.17482.caglar@pardus.org.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2432754.jDyiO4d1Dj
Content-Type: text/plain;
  charset="iso-8859-9"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

16 Eki 2006 Pts 16:08 tarihinde, Pallipadi, Venkatesh =FEunlar=FD yazm=FD=
=FEt=FD:=20
> Sorry for the delayed response. This is still very mysterious to me..
>
> Do you see anything interesting in dmesg after you try this ac adapter
> unplug and plug back routine? Can you send me the dmesg. Better still open
> a bugzilla at bugme.osdl.org and stick the dmesg and acpidump there.

No, nothing interested and i filled a bug [1] with all related info

> One possible reason for this is, somehow idle statistics is getting all
> wrong and ondemand thinks CPU is busy, even though it is idle. I have seen
> this happening earlier when there are issues with local APIC interrupts in
> deep C-states on dual core systems. But, here it is a single core CPU.
> Right? Can you also get the output of #cat /proc/interrupts; sleep 10; cat
> /proc/interrupts
> On your system when ondemand is not working and when it is working (After
> your unplug-plug workaround.

Hmm top show something weird;

Tasks:  39 total,   1 running,  38 sleeping,   0 stopped,   0 zombie
Cpu(s): 32.4%us, 12.4%sy,  0.0%ni, 41.1%id, 13.0%wa,  0.4%hi,  0.6%si,  0.0=
%st

There were nothing runs right that time but top reports only ~%40 idle [ful=
l=20
log attached to bug]

[1] http://bugme.osdl.org/show_bug.cgi?id=3D7376
=2D-=20
S.=C7a=F0lar Onur <caglar@pardus.org.tr>
http://cekirdek.pardus.org.tr/~caglar/

Linux is like living in a teepee. No Windows, no Gates and an Apache in hou=
se!

--nextPart2432754.jDyiO4d1Dj
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFM+udy7E6i0LKo6YRAty4AKCQ3D5eRt5zDAZLI4UsqEZEiDWGPgCglHyr
aprZijYdEt46gsiy23q1jRk=
=kOvY
-----END PGP SIGNATURE-----

--nextPart2432754.jDyiO4d1Dj--
