Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269149AbUIHOvd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269149AbUIHOvd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 10:51:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269157AbUIHOr2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 10:47:28 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:57256 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S269106AbUIHOqn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 10:46:43 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: Fw: 2.6.9-rc1-mm4: swsusp + AMD64 = LOCKUP on CPU0
Date: Wed, 8 Sep 2004 16:47:11 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Patrick Mochel <mochel@digitalimplant.org>,
       Ingo Molnar <mingo@redhat.com>, Zwane Mwaikambo <zwane@linuxpower.ca>
References: <20040908021637.57525d43.akpm@osdl.org> <200409081419.15606.rjw@sisk.pl> <Pine.LNX.4.53.0409080855390.15087@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.53.0409080855390.15087@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200409081647.11458.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 of September 2004 14:55, Zwane Mwaikambo wrote:
> On Wed, 8 Sep 2004, Rafael J. Wysocki wrote:
> 
> > Eeek.  I can't disable the NMI watchdog on x86-64, can I?  According to 
> > Documentation/nmi_watchdog.txt:
> > 
> > "For x86-64, the needed APIC is always compiled in, and the NMI watchdog 
is
> > always enabled with I/O-APIC mode (nmi_watchdog=1)."
> 
> Try nmi_watchdog=0

It works, thanks.

Now, I'm able to suspend the box, seemingly, but there are some problems with 
resuming.  There is a crash related to USB (gets "fixed" if I unload usb_ohci 
etc. before suspending) and a preepmtion problem.  I'll send some traces as 
soon as I can get output from the serial console.  In the meantime, I'll try 
to compile out preemption.

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
