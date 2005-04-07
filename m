Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262171AbVDGWWQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262171AbVDGWWQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 18:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262180AbVDGWWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 18:22:16 -0400
Received: from www.tuxrocks.com ([64.62.190.123]:36621 "EHLO tuxrocks.com")
	by vger.kernel.org with ESMTP id S262171AbVDGWWH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 18:22:07 -0400
Message-ID: <4255B247.4080906@tuxrocks.com>
Date: Thu, 07 Apr 2005 16:20:55 -0600
From: Frank Sorenson <frank@tuxrocks.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tony Lindgren <tony@atomide.com>
CC: linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Pavel Machek <pavel@suse.cz>, Arjan van de Ven <arjan@infradead.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Andrea Arcangeli <andrea@suse.de>, George Anzinger <george@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Lee Revell <rlrevell@joe-job.com>, Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] Dynamic Tick version 050406-1
References: <20050406083000.GA8658@atomide.com> <425451A0.7020000@tuxrocks.com> <20050407082136.GF13475@atomide.com> <4255A7AF.8050802@tuxrocks.com>
In-Reply-To: <4255A7AF.8050802@tuxrocks.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Frank Sorenson wrote:
> Tony Lindgren wrote:
> 
>>Thanks for trying it out. What kind of hardware do you have? Does it
>>have HPET? It looks like no suitable timer for dyn-tick is found...
>>Maybe the following patch helps?
>>
>>Tony
> 
> 
> Does 'different crash' qualify as "helping"?  :)

Update:
The patch does seem to fix the crash.  This "different crash" I
mentioned appears to be related to the netconsole I was using (serial
console produces stairstepping text, netconsole seems to duplicate
lines--go figure).  Without netconsole, dynamic tick appears to be
working, so I'm not sure whether this is a netconsole bug or a dynamic
tick bug.

While dynamic tick no longer panics, with dynamic tick, my system slows
to whatever is slower than a crawl.  It now takes 6 minutes 50 seconds
to boot all the way up, compared to 1 minute 35 seconds with my 2.6.12
kernel without the dynamic tick patch.  I'm not sure where this slowdown
is occurring yet.

Frank
- --
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCVbJHaI0dwg4A47wRAmijAKCRgg9MTxrrNWKanMmmSS010BTWdgCeNMnJ
4YJWhHAcizMgZNH/+643Hvk=
=w9Ii
-----END PGP SIGNATURE-----
