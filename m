Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751494AbWDYKc5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751494AbWDYKc5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 06:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751073AbWDYKc5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 06:32:57 -0400
Received: from mail.goelsen.net ([195.202.170.130]:63373 "EHLO
	power2u.goelsen.net") by vger.kernel.org with ESMTP
	id S1751493AbWDYKc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 06:32:56 -0400
From: Michael Monnerie <michael.monnerie@it-management.at>
Organization: it-management http://it-management.at
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: rtc: lost some interrupts at 256Hz
Date: Tue, 25 Apr 2006 12:32:37 +0200
User-Agent: KMail/1.9.1
Cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org
References: <200604202237.34134@zmi.at> <1145566983.5412.31.camel@mindpipe> <Pine.LNX.4.61.0604210012530.28841@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0604210012530.28841@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1304816.k8BvI8KEWy";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200604251232.37939@zmi.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1304816.k8BvI8KEWy
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Freitag, 21. April 2006 00:18 Jan Engelhardt wrote:
> Does not really matter what userspace app is running. If it's mplayer
> the message is "rtc: lost some interrupts at 1024Hz.", and if it's
> VMware it's whatever the Guest OS requires, mostly 2000 or 200 Hz.

The tipps from vmware support at
http://www.vmware.com/support/kb/enduser/std_adp.php?p_sid=3DtthOqz5i&p_lva=
=3D&p_faqid=3D1420&p_created=3D1093994398&p_sp=3DcF9zcmNoPTEmcF9ncmlkc29ydD=
0mcF9yb3dfY250PTE3JnBfc2VhcmNoX3RleHQ9bG9zdCBzb21lIGludGVycnJ1cHRzJnBfc2Vhc=
mNoX3R5cGU9NyZwX3Byb2RfbHZsMT1_YW55fiZwX3Byb2RfbHZsMj1_YW55fiZwX3NvcnRfYnk9=
ZGZsdCZwX3BhZ2U9MQ**&p_li=3D
seem to help, didn't get a "lost some interrupts" warning during the=20
last 2 days. But, I got one "many lost ticks" warning:

Apr 23 23:06:51 baum kernel: warning: many lost ticks.
Apr 23 23:06:51 baum kernel: Your time source seems to be instable or=20
some driver is hogging interupts
Apr 23 23:06:51 baum kernel: rip __do_softirq+0x4f/0xd0

What I did was
=2D setup VM host OS to 1000HZ, preemptible kernel
=2D VM clients use 100HZ, and kernel options "clock=3Dpit nosmp noapic=20
nolapic"
=2D VM client kernels are all non-SMP compiled now.

Still, some kind of documentation in the Linux source tree would be=20
nice, explaining what that message means and how to fix it.

mfg zmi
=2D-=20
// Michael Monnerie, Ing.BSc    -----      http://it-management.at
// Tel: 0660/4156531                          .network.your.ideas.
// PGP Key:   "lynx -source http://zmi.at/zmi3.asc | gpg --import"
// Fingerprint: 44A3 C1EC B71E C71A B4C2  9AA6 C818 847C 55CB A4EE
// Keyserver: www.keyserver.net                 Key-ID: 0x55CBA4EE

--nextPart1304816.k8BvI8KEWy
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBETfrFyBiEfFXLpO4RAjnTAJ9AbG/BooGnZf/CWaAhoQhctFxxTgCgg0qb
dpwoZJRrZVHIHugVZuFaDmI=
=Owaj
-----END PGP SIGNATURE-----

--nextPart1304816.k8BvI8KEWy--
