Return-Path: <linux-kernel-owner+w=401wt.eu-S1754617AbWLRWgV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754617AbWLRWgV (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 17:36:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754707AbWLRWgV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 17:36:21 -0500
Received: from frodo.hserus.net ([204.74.68.40]:33737 "EHLO frodo.hserus.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754617AbWLRWgU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 17:36:20 -0500
X-Greylist: delayed 1510 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Dec 2006 17:36:20 EST
From: Dan Jacobson <jidanni@jidanni.org>
To: linux-kernel@vger.kernel.org
Subject: Re: kernel-parameters.txt: expand APIC
References: <Pine.LNX.4.61.0612182053260.29144@yvahk01.tjqt.qr>
Date: Tue, 19 Dec 2006 05:58:46 +0800
Message-ID: <87d56ghnmx.fsf@jidanni.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> kernel-parameters.txt says what ACPI and APM stand for, but not APIC.

J> Advanced PIC, most likely.
Also say what PIC means.
J> http://en.wikipedia.org/wiki/APIC will tell more.
Not when one is having booting problems and can't connect their modem.
>> Also there give some basic apm related parameters, instead of just
>> saying see apm.c, which the user is less likely to have handy than
>> kernel-parameters.txt.
J> As always, patches welcome :)
apm.c is in a Debian package that is too big for me to download before
my next trip to town. So for now I will just put
append="apm=off" as a guess in lilo, as there is no basic mention of
how to turn it off in kernel-parameters.txt, as an attempt to stop the
total power off that happens on my first boot of the day after 10 or
15 minutes.

What I'm saying is that your files should be more self-contained.

	apic=		[APIC,i386] Change the output verbosity whilst booting
			Format: { quiet (default) | verbose | debug }
			Change the amount of debugging information output
			when initialising the APIC and IO-APIC components.

	apm=		[APM] Advanced Power Management
			See header of arch/i386/kernel/apm.c.

Drat. All they had to do was add one little
			Format: { ... }
line with the answers. Instead one needs to have the source code to
find the answer. Multi megabyte download just for one line of
information. And the user might be at a remote site with no net
connection too.
