Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261323AbVGDKbw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261323AbVGDKbw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 06:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261240AbVGDK3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 06:29:52 -0400
Received: from ws6-4.us4.outblaze.com ([205.158.62.107]:4505 "HELO
	ws6-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S261619AbVGDK2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 06:28:47 -0400
Message-ID: <42C90F58.9090205@grimmer.com>
Date: Mon, 04 Jul 2005 12:28:40 +0200
From: Lenz Grimmer <lenz@grimmer.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Jesper Juhl <jesper.juhl@gmail.com>,
       Alejandro Bonilla <abonilla@linuxwireless.org>,
       Dave Hansen <dave@sr71.net>, Henrik Brix Andersen <brix@gentoo.org>,
       hdaps-devel@lists.sourceforge.net,
       LKML List <linux-kernel@vger.kernel.org>
Subject: Re: IBM HDAPS things are looking up (was: Re: [Hdaps-devel] Re: [ltp]
 IBM HDAPS Someone interested? (Accelerometer))
References: <9a8748490507031832546f383a@mail.gmail.com> <42C8D06C.2020608@grimmer.com> <20050704061713.GA1444@suse.de>
In-Reply-To: <20050704061713.GA1444@suse.de>
X-Enigmail-Version: 0.91.0.0
OpenPGP: id=B27291F2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Jens,

thanks for your quick reply!

Jens Axboe wrote:

> Dunno if there's something that explicitly only parks the head, the
> best option is probably to issue a STANDBY_NOW command. You can test
> this with hdparm -y.

Thanks for the hint! As others already mentioned, STANDBY_NOW may not be
the best option in this case - we shall investigate what the IBM Windows
driver is using here.

> Generel observation on this driver - why isn't it just contained in
> user space? You need to do the monitoring and sending of ide commands
> from there anyways, I don't see the point of putting it in the
> kernel.

Sorry, my comments may have been misleading - I agree that this should
be better done in userspace.

The kernel module just reads out the accelerometer, a user space app
could then interpret the values and take appropriate action (e.g.
parking the hdd head). This allows other apps to make use of these
acceleratometer values as well (think SDL for games).

Bye,
	LenZ
- --
- ------------------------------------------------------------------
 Lenz Grimmer <lenz@grimmer.com>                             -o)
 [ICQ: 160767607 | Jabber: LenZGr@jabber.org]                /\\
 http://www.lenzg.org/                                       V_V
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCyQ9XSVDhKrJykfIRAktdAJ9eltvz0sjTfKT7oVgqikGFEYJwHQCfdr7n
b7M02yR0n2UrUFLL03xA804=
=MHtj
-----END PGP SIGNATURE-----
