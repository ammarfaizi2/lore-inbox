Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268504AbTBWPz7>; Sun, 23 Feb 2003 10:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268505AbTBWPz7>; Sun, 23 Feb 2003 10:55:59 -0500
Received: from ns0.cobite.com ([208.222.80.10]:47115 "EHLO ns0.cobite.com")
	by vger.kernel.org with ESMTP id <S268504AbTBWPz6>;
	Sun, 23 Feb 2003 10:55:58 -0500
Date: Sun, 23 Feb 2003 11:06:09 -0500 (EST)
From: David Mansfield <lkml@dm.cobite.com>
X-X-Sender: david@admin
To: linux-kernel@vger.kernel.org, Rik van Riel <riel@imladris.surriel.com>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>
Subject: oom killer and its superior braindamage in 2.4
Message-ID: <Pine.LNX.4.44.0302231058070.23778-100000@admin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Marc, Rik,

> - Feb 21 10:04:57 codeman kernel: Out of Memory: Killed process 2657 
> (apache).
>
> The above log entry (apache) appeared for about 4 hours every some 
> seconds (same PID) until I thought about sysrq-b to get out of this 
> braindead behaviour. The machine was somewhat dead for me because I was 
> not able to do anything but sysrq. The system itself was _not_ dead, 
> there was massive disk i/o. This is 2.4.20 vanilla.

This exact thing happened to me as well, on a 2.4.20-pre that hasn't been 
upgraded to 2.4.20 yet.  The thing that concerns me most is:

Why won't the system kill the process it claims to be killing?

If, in Marc's case, the system wants to kill PID 2657, a lowly sleeping 
apache process, why can't it?  This is a bug for sure.

For me, there was some python process chosen as the one for killing and it 
repeated the 'Out of Memory: Killed process xxxxx (python)' for hours 
while making no progress.  The machine was still routing packets but I 
couldn't log in.  Sys-rq was disabled, so I was forced to use the big red 
button.

Rik, any ideas?

David

-- 
/==============================\
| David Mansfield              |
| lkml@dm.cobite.com           |
\==============================/

