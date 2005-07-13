Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262584AbVGMKWT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262584AbVGMKWT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 06:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262602AbVGMKVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 06:21:32 -0400
Received: from ws6-4.us4.outblaze.com ([205.158.62.107]:36805 "HELO
	ws6-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262584AbVGMKVa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 06:21:30 -0400
Message-ID: <42D4EB21.1060305@grimmer.com>
Date: Wed, 13 Jul 2005 12:21:21 +0200
From: Lenz Grimmer <lenz@grimmer.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: Gijs Hillenius <gijs@hillenius.net>, Frank Sorenson <frank@tuxrocks.com>,
       hdaps-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Hdaps-devel] Re: Updating hard disk firmware & parking hard
 disk
References: <20050707171434.90546.qmail@web32604.mail.mud.yahoo.com> <42CD7E0C.3060101@tuxrocks.com> <878y0bozf8.fsf@hillenius.net> <Pine.LNX.4.61.0507131208540.14635@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0507131208540.14635@yvahk01.tjqt.qr>
X-Enigmail-Version: 0.92.0.0
OpenPGP: id=B27291F2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jan Engelhardt wrote:

> Head parking while the system running is almost useless, since sooner or 
> later, someone's going to write/read something.

Correct, that's why we're discussing to freeze the request queue as well.

> If you want head parking at shutdown, I suggest using hdparm -y. This puts the 
> drive to sleep, which includes spindle spindown and, included, appropriate 
> head parking.

But it suffers from the same fate - as soon as the disk receives a new
request, it will spin up again. So there is no gain, except that just
parking the head without spinning down the spindle can be performed much
faster.

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

iD8DBQFC1OseSVDhKrJykfIRAnk3AJ9EqLIBprtaYikZCQaRdIpPOrOWiACeMXOC
pwjn2afI737DDzqOKDaEUCA=
=JtxS
-----END PGP SIGNATURE-----
