Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265383AbUGDEUD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265383AbUGDEUD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 00:20:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265387AbUGDEUD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 00:20:03 -0400
Received: from colo.khms.westfalen.de ([213.239.196.208]:62134 "EHLO
	colo.khms.westfalen.de") by vger.kernel.org with ESMTP
	id S265383AbUGDET7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 00:19:59 -0400
Date: 03 Jul 2004 15:54:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: froese@gmx.de
cc: linux-kernel@vger.kernel.org
Message-ID: <9C8lzYXmw-B@khms.westfalen.de>
In-Reply-To: <2cfBL-6uJ-9@gated-at.bofh.it>
Subject: Re: [patch] signal handler defaulting fix ...
X-Mailer: CrossPoint v3.12d.kh13 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
References: <2cfBL-6uJ-9@gated-at.bofh.it>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

froese@gmx.de (Edgar Toernig)  wrote on 29.06.04 in <2cfBL-6uJ-9@gated-at.bofh.it>:

> Not the signal part.  It was written for libc5.  There, signals set
> with signal(2) were reset when raised (SysV-style).  Leaving such a
> signal handler with longjmp was perfectly valid.
>
> Glibc2 changed the rules: signals set with signal(2) are not reset
> but blocked during delivery (BSD-style).  It worked for a while
> because the kernel ignored the sigmask for some signals.
>
> So, if one is to blame then glibc2 by breaking compatibility.

You might want to study /usr/include/signal.h and /usr/include/feature.h.

And then you might try stuff like -D_SVID_SOURCE or -Dsignal=sysv_signal,  
for example.

And stop blaming glibc for your failures.

MfG Kai
