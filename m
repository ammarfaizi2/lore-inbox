Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751041AbWG3DZO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751041AbWG3DZO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 23:25:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751057AbWG3DZO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 23:25:14 -0400
Received: from wasp.net.au ([203.190.192.17]:27081 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S1751041AbWG3DZM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 23:25:12 -0400
Message-ID: <44CC268D.80104@wasp.net.au>
Date: Sun, 30 Jul 2006 07:25:01 +0400
From: Brad Campbell <brad@wasp.net.au>
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
MIME-Version: 1.0
To: Jason Lunz <lunz@falooley.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, B.Zolnierkiewicz@elka.pw.edu.pl,
       "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>,
       Vojtech Pavlik <vojtech@suse.cz>, David Brownell <david-b@pacbell.net>
Subject: Re: [patch, rft] ide: reprogram disk pio timings on resume
References: <200607281646.31207.rjw@sisk.pl> <1154105517.13509.153.camel@localhost.localdomain> <20060729233416.GA6346@opus.vpn-dev.reflex>
In-Reply-To: <20060729233416.GA6346@opus.vpn-dev.reflex>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jason Lunz wrote:
> Add a step to the IDE PM state machine that reprograms disk PIO timings
> as the first step on resume. This prevents ide deadlock on
> resume-from-ram on my nforce3-based laptop.
> 
<snip>
> 
> Brad: thanks for volunteering to test! You'll be the lucky first person
> to try this on a non-nforce ide chipset. good luck.

No change to the behaviour here.. It does not hurt, but it does not help either.
I have not been able to get logs out of this machine yet while it's resuming. (no serial port and 
don't have another machine handy to test with netconsole)

Hard disk locks up for 30 secs and then resumes with a dropped interrupt message and I get a console 
back but all hard disk access result in timeouts. (I'm testing from a complete system initramfs)

As I said, with 2.6.18-rc2 and the libata patches from -mm1 it takes about 10 seconds to come back, 
but resumes reliably.


Brad
-- 
"Human beings, who are almost unique in having the ability
to learn from the experience of others, are also remarkable
for their apparent disinclination to do so." -- Douglas Adams
