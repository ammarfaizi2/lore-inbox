Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965146AbVHPI5I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965146AbVHPI5I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 04:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965149AbVHPI5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 04:57:08 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:962 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S965146AbVHPI5H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 04:57:07 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel 2.6.5 - Compaq Fibre Channel 64-bit/66Mhz HBA [PATCH]
Date: Tue, 16 Aug 2005 10:58:38 +0200
User-Agent: KMail/1.8.2
References: <42FB72DE.8000703@aub.nl> <200508160955.49133@bilbo.math.uni-mannheim.de> <4301A6BB.3020403@aub.nl>
In-Reply-To: <4301A6BB.3020403@aub.nl>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart33078628.jx2S3u4AR8";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200508161058.44174@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart33078628.jx2S3u4AR8
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Bolke de Bruin wrote:
>Rolf Eike Beer wrote:

>>If I can still help you then depends on
>>your scheduling of this job. I'll try to do some hacking at the weekends.
>
>Does this mean you will not have time until October 5th or just time in
>the weekend until that time?

=46or the moment my weekends are more or less "free time to hack". My thesi=
s is=20
some hardware design, I don't have the tools at home so there is little I c=
an=20
do at the weekend. This will change in september I think, then I will TeX a=
ll=20
day ;)

>>Nevertheless without access to the hardware it will be a bit difficult.
>> Much more than compile-testing is not possible for me.
>
>Access to hardware can be arranged

Testing will very likely include crashing the machine more than once and do=
ing=20
some nasty things with the attached storage. Someone will have to plug the=
=20
wire out of it while accessing the storage, reboot the switch and such stuf=
f.=20
This can really hurt in a production environment.

>>I'll send some more cleanups to this driver in a few minutes (I'll CC you=
).
>>What has to be done from my point of view is:
>>
>>-split up the interrupt handler in one small interrupt handler and one
>> tasklet that does the actual work. I have a patch that would do this but
>> I'm not familiar with this stuff. There are probably some bugs.
>>-fix the stack abuse. I already sent a patch, this has to be made a bit
>> nicer and better.
>>-change the probe/remove stuff to use Linux 2.6 API. This is optional, but
>> I think it will make this piece of dirt a bit cleaner ;)
>>-the stopping of the kernel thread for every controller is a bit messy.
>> There is a cleaner (and simpler) API in Linux 2.6 so this should also be
>> adjusted. Not really critical, but it makes a lot of sense IMHO.
>>-there is not much error checking. From my point of view there is to much
>>trust in that everything is ok which can lead to serious trouble if the
>> link sends you crap.
>
>For us everything more or less comes down to:is this feasible?

I'm sure it is.

>Currently we have three options:
>
>- Keep the current windows platform and not use 'full strength' of the
>hardware (sunv20z), though controller and array will be EOL'd pretty
>shortly by HP

Before you throw it away send it to me ;) I like to have some obscure hardw=
are=20
around.

>- Use a different controller (fyi HP's FCA2214) which needs a converter
>for the GBIC's (2gb --> 1gb). And will be unsupported by HP

Ugly.

>- Sponsor someone (you) to update the driver to support 2.6 / amd64 in a
>trusted fashion

*g*

>So for us it is little bit of risk management (jug :-) ) and we are
>trying to find out our best option.

I think the main stuff could be done in a week or two. My problem is that I=
=20
can't test it on my own (and it's likely to do some bad things with data=20
behind it) and that I would like to have someone experienced to review what=
 I=20
do. I'll keep sending this stuff to linux-scsi, but I have no reaction from=
=20
anyone there. I hope they will wake up when the interesting stuff comes ;)

Eike

--nextPart33078628.jx2S3u4AR8
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBDAarEXKSJPmm5/E4RAuF7AJ9oMQbmagwRxg1FaDPhHpeAofCunACcDMr4
yD28BneaeWXXXESJp3RIbhs=
=q4de
-----END PGP SIGNATURE-----

--nextPart33078628.jx2S3u4AR8--
