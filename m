Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262203AbTIGD2E (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 23:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262260AbTIGD2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 23:28:04 -0400
Received: from h80ad253e.async.vt.edu ([128.173.37.62]:17547 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262203AbTIGD2A (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 23:28:00 -0400
Message-Id: <200309070327.h873RsJe003211@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Nick's scheduler policy v12 
In-Reply-To: Your message of "Sat, 06 Sep 2003 19:34:58 PDT."
             <146640000.1062902095@[10.10.2.4]> 
From: Valdis.Kletnieks@vt.edu
References: <3F58CE6D.2040000@cyberone.com.au> <195560000.1062788044@flay> <20030905202232.GD19041@matchmail.com> <207340000.1062793164@flay> <3F5935EB.4000005@cyberone.com.au> <6470000.1062819391@[10.10.2.4]> <3F5980CD.2040600@cyberone.com.au> <139550000.1062861227@[10.10.2.4]> <3F59C956.5050200@wmich.edu>
            <146640000.1062902095@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1293883590P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 06 Sep 2003 23:27:54 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1293883590P
Content-Type: text/plain; charset=us-ascii

On Sat, 06 Sep 2003 19:34:58 PDT, "Martin J. Bligh" said:

> Some people have observed that ALSA drivers seem worse than the older
> ones ... I haven't done enough comparisons to be sure that's true, but
> maybe they have less buffering or something. More buffering in the kernel
> side might get rid of the sound skips.

At the expense of additional latency.  It really weirds you out when the volume,
tone, and mute buttons have a full second lag ;)

> People should gague performance by how well we do on the apps they want
> to run. If people want to run xmms, they'll be interested in how well
> it works. My main objection to benchmarking like this is (and window
> wiggle tests) are that they're pretty much subjective, and hard to 
> measure.

I have to admit on my laptop, I've failed to see much subjective improvement
since O7 or so, as  VM and IO issues have predominated since then. The
scheduler is basically powerless and the VM manager only slightly more so when
the *proper* fix is probably stick another 256M in. ;)

Either that, or put the XFree86 4.3.0 server on a severe diet - 'ps aux' is reporting
that as I type, mine has VSZ=384852 and RSS=64724.  Thrown in a mozilla
with VSZ=122900 and RSS=47316, and you're just waiting for things to
degrade into thrashing.

At least for my laptop, any future performance wins are going to come from
elsewhere than the CPU scheduler - I'll pick reiser4, VM manager, and I/O
manager as top contenders, with "being able to recompile the CPU hogs with xlc"
as a long-shot.. ;)

> Personally, I just use xmms because I've found nothing better, but the 
> the UI does suck. Mostly that's because I'm too idle to look hard (or
> I have better things to do) and it's good enough.

Amen to that.  I point xmms at a bunch of .ogg's, it plays them, and it does so
well enough that I've not gotten peeved enough to go find a replacement.

--==_Exmh_1293883590P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/WqW6cC3lWbTT17ARAonqAJ0QelGqTA31hRImZmWGhItfJdbTRwCfamOo
86zant1guDnbADPupGTjlzk=
=gp5S
-----END PGP SIGNATURE-----

--==_Exmh_1293883590P--
