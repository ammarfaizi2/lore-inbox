Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbTDEBWT (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 20:22:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261659AbTDEBWT (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 20:22:19 -0500
Received: from smtp.net4india.com ([202.71.128.33]:32268 "EHLO
	smtp.net4india.com") by vger.kernel.org with ESMTP id S261631AbTDEBWQ (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 20:22:16 -0500
Message-ID: <002301c2fb13$fc3afd70$0101a8c0@simple.com>
From: "Robins Tharakan" <robins.t@kutumb.org.in>
To: <mikpe@csd.uu.se>
Cc: <linux-kernel@vger.kernel.org>, <mbligh@aracnet.com>,
       <bugme-daemon@osdl.org>, "Randy.Dunlap" <rddunlap@osdl.org>
References: <200304042229.h34MTdTp008601@harpo.it.uu.se>
Subject: Re: [Bug 538] New: Rebooting of pentium-I during initial booting phase.
Date: Sat, 5 Apr 2003 07:07:51 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
> >| >           Summary: Rebooting of pentium-I during initial booting
phase.
> >| >    Kernel Version: 2.5.65 (probably most versions of 2.5.x)
> >| >            Status: NEW
> >| >          Severity: normal
> >| >             Owner: mbligh@aracnet.com
> >| >         Submitter: robins.t@kutumb.org.in
> >| >
> >| >
> >| >Distribution: linus kernel 2.5.65 (probably 2.5.x)
> >| >
> >| >Hardware Environment:
> >| >Pentium - I (120 MHz) with FO-OF Bug
> >| >Motherboard Via - With DMA Problem ("nodma" option required in 2.4.x
kernels)
> >| >32mb RAM (EDO)
> >| >
> >| >Software Environment:
> >| >Linus kernel 2.5.65
> >| >
> >| >Problem Description:
> >| >The new kernel 2.5.65 reboots while booting process (in the very
initial phase) making even noting the progress very difficult.
> >| >The system is running fine with 2.4.21-pre5, with the option "nodma".
> >|
> >| Most probably a configuration error, viz. choosing a CPU type
> >| higher than generic 586. My Socket7 ASUS T2P4 with a Pentium
> >| Classic (pre-MMX) 133MHz boots 2.5.66 just fine.
> >
> >Yes, I agree with that suggestion, but I don't see a problem.
> >Did you look at his .config file?  It's here:
> >  http://bugme.osdl.org/attachment.cgi?id=261&action=view
> >
> >I'm comparing it to the .config on my Pentium-with-f00f-bug, which does
> >boot 2.5.65 successfully, and I don't see CPU option differences.
> >I see lots that don't matter and I see PIIX vs. VIA option differences.
>
> I've re-tested with the exakt same .config and gcc (RH8 stock)
> that Robins used, and I still can't reproduce the problem.
> According to his 2.4.21-pre5 dmesg output, his CPU is even the
> same stepping as mine (CPUID 52C).

I think that rather than blaming the cpu, the motherboard could be the
culprit.
the "nodma" option actually had me running around for about 4-5 months
earlier last year just because i was furious with the simple issue that
win9x worked flawlessly and my simple 2.4.x kernels just wouldnt work.
note: the 2.4.x kernels also used to show similar (but not exact)
symptoms... the system used to reboot automatically while the kernel bootup
was in progress (albeit, the automatic reboot used to take place while
initializing the hard disks... precisely speaking it used to reboot while
checking for partitions, or sometimes simply while checking for any ides
available..))

the "ide=nodma" option helped there, and have been working in all later
2.4.x kernels...
but a similar option for 2.5.x kernels dont seem to be doing the trick..

as far as the suggestions from dave are concerned, i have tried setting
1. cpu to 386 compatible
2. removing mce option
but the problem still remains..

at the moment i am trying to remove *all* options which are not required for
a simple kernel to function (eg. networking/ ). and trying it all over
again...
i'll send the new .config file over, if it works...

affly
robins

