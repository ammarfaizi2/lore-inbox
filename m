Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751765AbWJMSeY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751765AbWJMSeY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 14:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751783AbWJMSeY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 14:34:24 -0400
Received: from ns2.uludag.org.tr ([193.140.100.220]:21969 "EHLO uludag.org.tr")
	by vger.kernel.org with ESMTP id S1751765AbWJMSeX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 14:34:23 -0400
From: "=?iso-8859-9?q?S=2E=C7a=F0lar?= Onur" <caglar@pardus.org.tr>
Reply-To: caglar@pardus.org.tr
Organization: =?utf-8?q?T=C3=9CB=C4=B0TAK_/?= UEKAE
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: Re: Ondemand/Conservative not working with 2.6.18
Date: Fri, 13 Oct 2006 21:33:49 +0300
User-Agent: KMail/1.9.5
Cc: "Dave Jones" <davej@redhat.com>, linux-kernel@vger.kernel.org
References: <EB12A50964762B4D8111D55B764A8454B6C08C@scsmsx413.amr.corp.intel.com>
In-Reply-To: <EB12A50964762B4D8111D55B764A8454B6C08C@scsmsx413.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1645737.87p9QxIRDb";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200610132133.55486.caglar@pardus.org.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1645737.87p9QxIRDb
Content-Type: text/plain;
  charset="iso-8859-9"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

11 Eki 2006 =C7ar 22:00 tarihinde, Pallipadi, Venkatesh =FEunlar=FD yazm=FD=
=FEt=FD:=20
> I guess I misunderstood the original issue. You have available_frequencies
> showing all the values and after you load ondemand, frequency remains at
> the highest, even though CPUs are idle. Is this correct?
>
> And everything above used to work fine with 2.6.16?
>
> Can you configure with CPU_FREQ_DEBUG and do "echo 5 >
> /sys/module/cpufreq/parameter/debug" before switching the governor to
> ondemand and see whether you see any messages in dmesg?

I just found a workaround of my problem, if system boots with ac adapter=20
plugged then ondemand or conservative governors are not working, but=20
unplugging the adapter and waiting some seconds, plug it back solves this=20
issue and ondemand/conservative governors are starts to run as expected.

What should i do now? If im not wrong it seems like acpi subsystem problem=
=20
(and just to be sure, i disassembled my dsdt, iacl claims its error/warning=
=20
free)

=2D-=20
S.=C7a=F0lar Onur <caglar@pardus.org.tr>
http://cekirdek.pardus.org.tr/~caglar/

Linux is like living in a teepee. No Windows, no Gates and an Apache in hou=
se!

--nextPart1645737.87p9QxIRDb
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFL9wTy7E6i0LKo6YRAg61AJsHLN3PFqBlvrW3k02v2iVVdbt7aACgv3mP
yNSJlmGtMZGsrsW/8Z4n7+Y=
=iEAT
-----END PGP SIGNATURE-----

--nextPart1645737.87p9QxIRDb--
