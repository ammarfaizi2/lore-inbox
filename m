Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261449AbTIFP6x (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 11:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261465AbTIFP6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 11:58:53 -0400
Received: from law12-f92.law12.hotmail.com ([64.4.19.92]:14864 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S261449AbTIFP6v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 11:58:51 -0400
X-Originating-IP: [208.48.228.132]
X-Originating-Email: [jyau_kernel_dev@hotmail.com]
From: "John Yau" <jyau_kernel_dev@hotmail.com>
To: mbuesch@freenet.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Minor scheduler fix to get rid of skipping in xmms
Date: Sat, 06 Sep 2003 11:58:50 -0400
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <LAW12-F92KGb2nHutfS00032a92@hotmail.com>
X-OriginalArrivalTime: 06 Sep 2003 15:58:50.0722 (UTC) FILETIME=[C398C420:01C3748F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

I don't know if really a bug due to xmms, I suspect that's the case.  I'm 
not familiar with xmms internals, but when I gdb'ed the process after it 
froze, all the threads either stopped at poll(), write(), select(), or 
nanosleep().  Some combination of the blocking calls among those is probably 
causing the stall.  I highly doubt it's due to the kernel since I haven't 
been experiencing hangs in any other applications.  It could be the socket 
code though if extensive modifications to it have been made, since I've 
never experienced hangs like this in the 2.4.18 kernel used by RedHat 8.0.


John Yau

>From: Michael Buesch <mbuesch@freenet.de>
>To: "John Yau" <jyau_kernel_dev@hotmail.com>
>CC: linux kernel mailing list <linux-kernel@vger.kernel.org>
>Subject: Re: [PATCH] Minor scheduler fix to get rid of skipping in xmms
>Date: Sat, 6 Sep 2003 12:03:35 +0200
>
>-----BEGIN PGP SIGNED MESSAGE-----
>Hash: SHA1
>
>On Saturday 06 September 2003 11:46, John Yau wrote:
> > Hi folks,
>
>Hi John,
>
> > xmms still completely hangs every once in a while for me.  However I
> > suspect it's due to a bug in xmms that deadlocks.  Anyone else 
>experiencing
> > hangs with xmms while tuning into Shoutcast???
>
>Yes, that's (was?) a bug of xmms.
>
>- --
>Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]
>Animals on this machine: some GNUs and Penguin 2.6.0-test4-bk2
>
>-----BEGIN PGP SIGNATURE-----
>Version: GnuPG v1.2.2 (GNU/Linux)
>
>iD8DBQE/WbD/oxoigfggmSgRAs5qAJ99vZeNeMEXhl72VvVlGFMWh55HVgCeLK0R
>MgWcMSUSdEYL+OeehfDNBCc=
>=TdCG
>-----END PGP SIGNATURE-----
>

_________________________________________________________________
Get 10MB of e-mail storage! Sign up for Hotmail Extra Storage.  
http://join.msn.com/?PAGE=features/es

