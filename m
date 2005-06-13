Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261356AbVFME4E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261356AbVFME4E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 00:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbVFME4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 00:56:04 -0400
Received: from h80ad2548.async.vt.edu ([128.173.37.72]:51210 "EHLO
	h80ad2548.async.vt.edu") by vger.kernel.org with ESMTP
	id S261356AbVFMEz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 00:55:59 -0400
Message-Id: <200506130454.j5D4suNY006032@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Jonathan Corbet <corbet@lwn.net>, Pavel Machek <pavel@ucw.cz>,
       Bernard Blackham <b-lkml@blackham.com.au>,
       Christian Hesse <mail@earthworm.de>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>
Subject: Re: [PATCH] Dynamic tick for x86 version 050609-2 
In-Reply-To: Your message of "Thu, 09 Jun 2005 21:30:18 PDT."
             <20050610043018.GE18103@atomide.com> 
From: Valdis.Kletnieks@vt.edu
References: <88056F38E9E48644A0F562A38C64FB6004EBD10C@scsmsx403.amr.corp.intel.com> <20050609014033.GA30827@atomide.com>
            <20050610043018.GE18103@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1118638495_4308P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 13 Jun 2005 00:54:55 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1118638495_4308P
Content-Type: text/plain; charset=us-ascii

On Thu, 09 Jun 2005 21:30:18 PDT, Tony Lindgren said:

> Thanks for all the comments. Here's an updated dyntick patch.

Patches with 3 minor rejects against -rc6-mm1, boots, and seems to work well on
my Dell Latitude C840 laptop - although running at full load with seti@home
causes the expected 250 timer ticks/sec, running a mostly-idle  X session only
gets about 117, and having xmms and a few other things running it hits about
170 tics/sec. I've had the CPU speed bounce between 1.2G and 1.6G a few times
and it didn't seem to blink either. Even NTP is happy with what it sees.. ;)

Need to rebuild with CONFIG_HZ=1000 and see what it does, and see what it does
to actual power consumption.

Minor nit:  The implementation of /sys/devices/system/timer/timer0/dyn_tick_state
violates the one-value-per-file rule for sysfs.  I suspect this needs to
become a directory with 3-4 files in it, each containing one value.

--==_Exmh_1118638495_4308P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCrRGfcC3lWbTT17ARAprnAKC8g0vC8TcoU3U1V0v5eT7CfNE9YgCg76kC
uhw25EDNQwH66YMYE0YPEJU=
=Y80w
-----END PGP SIGNATURE-----

--==_Exmh_1118638495_4308P--
