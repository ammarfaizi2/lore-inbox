Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261927AbVAYNGQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261927AbVAYNGQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 08:06:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbVAYNGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 08:06:15 -0500
Received: from mail01.syd.optusnet.com.au ([211.29.132.182]:46506 "EHLO
	mail01.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261927AbVAYNGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 08:06:10 -0500
Message-ID: <41F64410.4000702@kolivas.org>
Date: Wed, 26 Jan 2005 00:05:20 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Jack O'Quin" <joq@io.com>
Cc: Alexander Nyberg <alexn@dsv.su.se>, Ingo Molnar <mingo@elte.hu>,
       linux <linux-kernel@vger.kernel.org>, CK Kernel <ck@vds.kolivas.org>,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [PATCH]sched: Isochronous class v2 for unprivileged soft rt scheduling
References: <200501201542.j0KFgOwo019109@localhost.localdomain>	<87y8eo9hed.fsf@sulphur.joq.us> <20050120172506.GA20295@elte.hu>	<87wtu6fho8.fsf@sulphur.joq.us> <20050122165458.GA14426@elte.hu>	<87pszvlvma.fsf@sulphur.joq.us> <41F42BD2.4000709@kolivas.org>	<877jm3ljo9.fsf@sulphur.joq.us> <41F44AC2.1080609@kolivas.org>	<87hdl7v3ik.fsf@sulphur.joq.us> <87651nv356.fsf@sulphur.joq.us>	<87ekgbqr2a.fsf@sulphur.joq.us> <41F49735.5000400@kolivas.org> <873bwrpb4o.fsf@sulphur.joq.us> <41F57D94.4010500@kolivas.org> <41F5C347.4030605@kolivas.org>
In-Reply-To: <41F5C347.4030605@kolivas.org>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigFC557E1347A47A5183F829C3"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFC557E1347A47A5183F829C3
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

There were numerous bugs in the SCHED_ISO design prior to now, so it 
really was not performing as expected. What is most interesting is that 
the DSP load goes to much higher levels now if xruns are avoided and 
stay at those high levels. If I push the cpu load too much so that they 
get transiently throttled from SCHED_ISO, after the Xrun the dsp load 
drops to half. Is this expected behaviour?

Anyway the next patch works well in my environment. Jack, while I 
realise you're getting the results you want from Ingo's dropped 
privilege, dropped cpu limit patch I would appreciate you testing this 
patch. It is not clear yet what direction we will take, but even if we 
dont do this, it would be nice just because of the effort on my part.

This version of the patch has full priority support and both ISO_RR and 
ISO_FIFO.

This is the patch to apply to 2.6.11-rc2-mm1:
http://ck.kolivas.org/patches/SCHED_ISO/2.6.11-rc2-mm1/2.6.11-rc2-mm1-iso-prio-fifo.diff

Cheers,
Con


--------------enigFC557E1347A47A5183F829C3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB9kQQZUg7+tp6mRURAkB6AJ90SqfknXIAsa0zAFBMmxTmxk7stgCgjLKC
OPjLI1VkiS5XOnT/EsPHIVQ=
=tNFN
-----END PGP SIGNATURE-----

--------------enigFC557E1347A47A5183F829C3--
