Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286311AbSCRPtK>; Mon, 18 Mar 2002 10:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286322AbSCRPtA>; Mon, 18 Mar 2002 10:49:00 -0500
Received: from pD9E53129.dip.t-dialin.net ([217.229.49.41]:51937 "EHLO
	sol.fo.et.local") by vger.kernel.org with ESMTP id <S286311AbSCRPss>;
	Mon, 18 Mar 2002 10:48:48 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.18 freezes on heavy IO; SysRq question
In-Reply-To: <3C95F129.7D9744B5@gmx.net>
From: Joachim Breuer <jmbreuer@gmx.net>
Date: Mon, 18 Mar 2002 16:48:42 +0100
Message-ID: <m3it7tg9lx.fsf@venus.fo.et.local>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) XEmacs/21.1 (Cuyahoga Valley,
 i386-redhat-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Ems <r.ems.mtg@gmx.net> writes:

> Hi all!
>
> I'm seeing my system freeze on heavy IO. Only the reset button brings it
> back to life again (ALT-SysRq-b also worked once). I'm running SuSE's
> 2.4.18-30 on a Pentium III (Coppermine) with 256 MB RAM (yes, I should
> try vanilla 2.4.18, I will ...)
> No SCSI, all IDE. LVM and ext3.
> I don't get any oopses, no entries in /var/log/messages, nothing. I
> mounted the ext3 partitions with the debug option but still no messages.
> What options can I turn on to search for the problem? Any kernel boot
> options? LVM/ext3 options?

Seconded; happened to me with 2.4.18 from kernel.org + LVM 2.0 beta
1.1 + Trond's NFS ('current' for 2.4.18). IO was to a local ext3 fs;
no LVM on that machine (modules not loaded).

Lock-up was complete for me; no panic message and no IP either so I
couldn't poke around. Alt+Sysrq seemed dead; but it might have been on
one of the boxen where Linux does not detect Alt+Sysrq properly.

BTW, what's the status of the Sysrq entry key "decoder"? I've about 4
different types of keyboards here, as far as I could determine only
one of them sends Linux-parseable Alt-Sysrq. All do send *something*
on Alt-Sysrq, though; but I couldn't get them to work with the
procedure described in the SysRq manual. That was around 2.4.12.


So long,
   Joe

-- 
"I use emacs, which might be thought of as a thermonuclear
 word processor."
-- Neal Stephenson, "In the beginning... was the command line"
