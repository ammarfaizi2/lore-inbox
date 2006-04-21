Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932275AbWDUIxV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932275AbWDUIxV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 04:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932218AbWDUIxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 04:53:21 -0400
Received: from mail.goelsen.net ([195.202.170.130]:57043 "EHLO
	power2u.goelsen.net") by vger.kernel.org with ESMTP id S932275AbWDUIxU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 04:53:20 -0400
From: Michael Monnerie <michael.monnerie@it-management.at>
Organization: it-management http://it-management.at
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: rtc: lost some interrupts at 256Hz
Date: Fri, 21 Apr 2006 10:52:58 +0200
User-Agent: KMail/1.9.1
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       linux-kernel@vger.kernel.org
References: <200604202237.34134@zmi.at> <Pine.LNX.4.61.0604210012530.28841@yvahk01.tjqt.qr> <1145571721.5412.47.camel@mindpipe>
In-Reply-To: <1145571721.5412.47.camel@mindpipe>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3616459.QAYu5XdIhK";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200604211052.59498@zmi.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3616459.QAYu5XdIhK
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Freitag, 21. April 2006 00:22 Lee Revell wrote:
> I asked about the app because I was wondering whether he had a server
> or a desktop.

It's all servers. The Hz rate can change over time:

Mar  3 02:04:41 baum kernel: rtc: lost some interrupts at 256Hz.
Mar  3 02:04:53 baum kernel: rtc: lost some interrupts at 256Hz.
Mar  3 02:04:55 baum kernel: rtc: lost some interrupts at 256Hz.
Mar  3 02:38:19 baum kernel: rtc: lost some interrupts at 256Hz.
Mar  3 02:42:22 baum kernel: rtc: lost some interrupts at 256Hz.
Mar 16 15:53:50 baum kernel: rtc: lost some interrupts at 2048Hz.
Mar 16 15:54:01 baum kernel: rtc: lost some interrupts at 2048Hz.
Mar 16 16:29:33 baum kernel: rtc: lost some interrupts at 2048Hz.
Mar 29 23:01:36 baum kernel: warning: many lost ticks.

Interesting may be the fact that VMware runs on at least some hosts. I=20
didn't check if all servers have it, but I found a good article on=20
vmware support:

http://www.vmware.com/support/kb/enduser/std_adp.php?p_sid=3DtthOqz5i&p_lva=
=3D&p_faqid=3D1420&p_created=3D1093994398&p_sp=3DcF9zcmNoPTEmcF9ncmlkc29ydD=
0mcF9yb3dfY250PTE3JnBfc2VhcmNoX3RleHQ9bG9zdCBzb21lIGludGVycnJ1cHRzJnBfc2Vhc=
mNoX3R5cGU9NyZwX3Byb2RfbHZsMT1_YW55fiZwX3Byb2RfbHZsMj1_YW55fiZwX3NvcnRfYnk9=
ZGZsdCZwX3BhZ2U9MQ**&p_li=3D

So as a summary:
=2D Lee Revell said changing preemption model from server to voluntary or=20
preemption could help
=2D increasing HZ on the vm-host, decreasing in the vm-clients should=20
help, according to VMware support

It would be good if this information is spread on the support lists, I=20
saw that question a lot. Also, a short text under Documentation in the=20
kernel source could be nice, explaining why this happens and what to do=20
then.

I will try the suggestion from the vmware support link I posted above,=20
and will report back.

mfg zmi
=2D-=20
// Michael Monnerie, Ing.BSc    -----      http://it-management.at
// Tel: 0660/4156531                          .network.your.ideas.
// PGP Key:   "lynx -source http://zmi.at/zmi3.asc | gpg --import"
// Fingerprint: 44A3 C1EC B71E C71A B4C2  9AA6 C818 847C 55CB A4EE
// Keyserver: www.keyserver.net                 Key-ID: 0x55CBA4EE

--nextPart3616459.QAYu5XdIhK
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBESJ1ryBiEfFXLpO4RAmNtAJ4r5xw4+MbEKCsf8aGBcTDOnpH35QCgnun6
vM5iZmgmfP9qpbd6fTRvKCM=
=gsKo
-----END PGP SIGNATURE-----

--nextPart3616459.QAYu5XdIhK--
