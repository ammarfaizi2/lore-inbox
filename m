Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129789AbQLNPMS>; Thu, 14 Dec 2000 10:12:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131404AbQLNPMI>; Thu, 14 Dec 2000 10:12:08 -0500
Received: from gherkin.sa.wlk.com ([192.158.254.49]:56068 "HELO
	gherkin.sa.wlk.com") by vger.kernel.org with SMTP
	id <S129789AbQLNPL4>; Thu, 14 Dec 2000 10:11:56 -0500
Message-Id: <m146ZZQ-0005keC@gherkin.sa.wlk.com>
From: rct@gherkin.sa.wlk.com (Bob_Tracy)
Subject: Re: test12 lockups -- need feedback
In-Reply-To: <3A38B9C8.B11C4ABC@haque.net> "from Mohammad A. Haque at Dec 14,
 2000 07:15:04 am"
To: "Mohammad A. Haque" <mhaque@haque.net>
Date: Thu, 14 Dec 2000 08:41:20 -0600 (CST)
CC: dep <dennispowell@earthlink.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mohammad A. Haque wrote:
> Were you connected to a network or receiving/sending anything?
> 
> dep wrote:
> > 
> > okay. got it here this morning, too. solid lock -- no dumping out of
> > x, no changing terminals, no mouse, no keyboard.
> > 
> > k6-2-550 @ 500; 256mb memory, fic 503a mb with via chipset.

This one is going to be fun to track down.  So far, with a personal
sample size of three machines, 2.4.0-test12 is stable on two, locks
up in a predictable and repeatable manner on one.  First, the stable
machines:

(1) P150 MMX Toshiba Tecra 730XCDT notebook, egcs-2.91.66, openwin
    with XFree86 3.3.6.

(2) Cyrix 6x86 MII 233, egcs-2.91.66, AfterStep with XFree86 4.0.1,
    NVIDIA-0.9-5 video driver.

The unstable machine:

Gateway PII 333, egcs-2.91.66, AfterStep with XFree86 3.3.6.
Running "startx" as "root" --> ok: no problem.
Running "startx" as normal user --> I get as far as the grey moire
pattern with the black "X" cursor in the center of the screen, and
the machine locks up solid.  Cannot switch consoles, machine doesn't
respond to pings (much less remote access attempts), no disk activity,
no "oops" messages in any of the logfiles.  Absolutely repeatable.
Machine works fine with earlier kernels.

Does anyone have a feeling one way or the other as far as this being
related to the CPU type?  I can try building a pre-PII CPU kernel on
the unstable machine and see if that makes any difference.

-- 
Bob Tracy                                            rct@frus.com
-----------------------------------------------------------------
 "We might not be in hell, but we can see the gates from here."
 --Phoenix resident, Summer of 2000
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
