Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262747AbVDHIuU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262747AbVDHIuU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 04:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262753AbVDHIuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 04:50:20 -0400
Received: from www.tuxrocks.com ([64.62.190.123]:785 "EHLO tuxrocks.com")
	by vger.kernel.org with ESMTP id S262747AbVDHIuG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 04:50:06 -0400
Message-ID: <42564584.4080606@tuxrocks.com>
Date: Fri, 08 Apr 2005 02:49:08 -0600
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
Subject: Re: [PATCH] Updated: Dynamic Tick version 050408-1
References: <20050406083000.GA8658@atomide.com> <425451A0.7020000@tuxrocks.com> <20050407082136.GF13475@atomide.com> <4255A7AF.8050802@tuxrocks.com> <4255B247.4080906@tuxrocks.com> <20050408062537.GB4477@atomide.com> <20050408075001.GC4477@atomide.com>
In-Reply-To: <20050408075001.GC4477@atomide.com>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Tony Lindgren wrote:
| * Tony Lindgren <tony@atomide.com> [050407 23:28]:
|
|>I think I have an idea on what's going on; Your system does not wake to
|>APIC interrupt, and the system timer updates time only on other
interrupts.
|>I'm experiencing the same on a loaner ThinkPad T30.
|>
|>I'll try to do another patch today. Meanwhile it now should work
|>without lapic in cmdline.
|
|
| Following is an updated patch. Anybody having trouble, please try
| disabling CONFIG_DYN_TICK_USE_APIC Kconfig option.
|
| I'm hoping this might work on Pavel's machine too?
|
| Tony

This updated patch seems to work just fine on my machine with lapic on
the cmdline and CONFIG_DYN_TICK_USE_APIC disabled.

Also, you were correct that removing lapic from the cmdline allowed the
previous version to run at full speed.

Now, how can I tell if the patch is doing its thing?  What should I be
seeing? :)

Functionally, it looks like it's working.  There were a number of
compiler warnings you might wish to fix before calling it good.  Such as
"initialization from incompatible pointer type" several times in
dyn-tick-timer.c and a "too many arguments for format" in
dyn_tick_late_init.

Frank
- --
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCVkWDaI0dwg4A47wRAgzOAKCHcx8p59ZbihYtZJ84p62v2rMauQCfUuzz
D7O98hHvjtTa/CvFHHtJe4c=
=G2I/
-----END PGP SIGNATURE-----
