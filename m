Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261302AbSLCNfe>; Tue, 3 Dec 2002 08:35:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261310AbSLCNfd>; Tue, 3 Dec 2002 08:35:33 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:12549 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S261302AbSLCNfd>; Tue, 3 Dec 2002 08:35:33 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: [PATCH 2.5] Extract configuration from kernel
Date: 3 Dec 2002 13:41:43 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <asican$58p$1@gatekeeper.tmr.com>
References: <E18Ixu4-0007zZ-00@lyra.fc.hp.com>
X-Trace: gatekeeper.tmr.com 1038922903 5401 192.168.12.62 (3 Dec 2002 13:41:43 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <E18Ixu4-0007zZ-00@lyra.fc.hp.com>,
Khalid Aziz  <khalid@fc.hp.com> wrote:
| I am including a patch for 2.5.50 that allows a user to embed kernel
| configuration in the kernel and retrieve it later either from a running
| kernel or from the kernel image file. This is an enhancement to Randy's
| patch that was discussed on LKML before and is part of -ac series
| kernels. 
| 
| This patch provides three choices for embedding kernel configuration:
| 
| 1. Include configuration in running kernel image. This adds to the
| footprint of the running kernel but allows configuration to be retrieved
| using "cat /proc/ikconfig/config".
| 
| 2. Include configuration in kernel image file but not in the running
| kernel. This adds to the kernel image file size but not the footprint of
| running kernel. Configuration can be extracted from kernel image file
| using scripts/extract-ikconfig. This script is in principle the same as
| what Randy had written originally. I have made it little more robust and
| structured it to accomodate more than just x86 architecture.
| 
| 3. Not include kernel configuration in the running kernel or kernel
| image file. 

I would suggest that making (2) available as a module would be useful,
assuming that at some point 2.5 will have working module capability
again. With a bit of tweaking you could make the kernel loader pull it
in if a process accessed the file, I guess.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
