Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262279AbUIHMXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262279AbUIHMXI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 08:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbUIHMWb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 08:22:31 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:29347 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S262406AbUIHMSw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 08:18:52 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: Fw: 2.6.9-rc1-mm4: swsusp + AMD64 = LOCKUP on CPU0
Date: Wed, 8 Sep 2004 14:19:15 +0200
User-Agent: KMail/1.6.2
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Patrick Mochel <mochel@digitalimplant.org>,
       Ingo Molnar <mingo@redhat.com>
References: <20040908021637.57525d43.akpm@osdl.org> <20040908102652.GA2921@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20040908102652.GA2921@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200409081419.15606.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 of September 2004 12:26, Pavel Machek wrote:
> Hi!
> 
> > One for you guys on lkml ;)
> 
> It simply takes long to count pages (O(n^2) algorithm), so watchdog
> triggers. I have better algorithm locally, but would like merge to
> linus first. (I posted it to lkml some days ago, I can attach the
> bigdiff).
> 
> Just disable the watchdog. Suspend *is* going to take time with
> disabled interrupts.

Eeek.  I can't disable the NMI watchdog on x86-64, can I?  According to 
Documentation/nmi_watchdog.txt:

"For x86-64, the needed APIC is always compiled in, and the NMI watchdog is
always enabled with I/O-APIC mode (nmi_watchdog=1)."

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
