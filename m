Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263930AbUBPFqM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 00:46:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263937AbUBPFqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 00:46:12 -0500
Received: from ztxmail04.ztx.compaq.com ([161.114.1.208]:15877 "EHLO
	ztxmail04.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S263930AbUBPFqL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 00:46:11 -0500
Subject: system (not HW) clock advancing really fast
From: Bill Anderson <banderson@hp.com>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1076910368.25980.12.camel@perseus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sun, 15 Feb 2004 22:46:08 -0700
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Feb 2004 05:46:09.0869 (UTC) FILETIME=[2DC0FFD0:01C3F450]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel version: 
	2.4.24-xfs
	We've apaprently had this problem for a while

Ok, I've got an HP LPr machine, dual 700MHz intel machine that has it's
system clock gaining seconds very quickly. This, I am told, has been
happening for several kernels.

At first, others on the team insisted it was the hardware clock at
fault, as rebooting the system gives the appearance of fixing it.
However, the system is currently having this issue, and the HW clock is
actually keeping accurate time, as I expected.

The time gain is no consistent. It can gain 3 seconds in one, or 12 in
11, but it always runs fast. This time speedup is to much for ntp to
keep up with. If I sync from hwclock or ntpdate every second, I'm
correcting about 1-3 seconds each time. This is a mail server, so I am
sure you can appreciate the need for accurate timestamps. ;)

I've seen many messages in the archives about *losing* time, but only a
few about gaining it. Personally, I am opposed to the "just reboot it"
mentality; one reason I run Linux.

Given that we are talking about system clock, not HW, and that this
happens with or w/o ntpd/ntpdate, I am suspecting something in the
kernel. Also, this thread leads me there too:
http://marc.theaimsgroup.com/?l=linux-kernel&m=105465355622844&w=2


Am I off base here? I can probably keep the hwclock sync method running
for a day or so before I'm forced to reboot it, so if there is anything
you need to know or want me to try while it is in this state, let me
know.

This address is not subscribed, so please cc me on responses.

Thanks,

Bill




-- 
Bill Anderson <banderson@hp.com>
Red Hat Certified Engineer

