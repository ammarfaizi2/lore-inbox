Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270111AbTGSRI2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 13:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270197AbTGSRI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 13:08:28 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:46295 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S270111AbTGSRI1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 13:08:27 -0400
Date: Sat, 19 Jul 2003 10:23:11 -0700
From: Larry McVoy <lm@bitmover.com>
To: Ga?l Le Mignot <kilobug@freesurf.fr>
Cc: Christian Reichert <c.reichert@resolution.de>,
       John Bradford <john@grabjohn.com>, lkml@lrsehosting.com,
       linux-kernel@vger.kernel.org, lm@bitmover.com, rms@gnu.org,
       Valdis.Kletnieks@vt.edu
Subject: Re: [OT] HURD vs Linux/HURD
Message-ID: <20030719172311.GA23246@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Ga?l Le Mignot <kilobug@freesurf.fr>,
	Christian Reichert <c.reichert@resolution.de>,
	John Bradford <john@grabjohn.com>, lkml@lrsehosting.com,
	linux-kernel@vger.kernel.org, lm@bitmover.com, rms@gnu.org,
	Valdis.Kletnieks@vt.edu
References: <200307191503.h6JF3tac002376@81-2-122-30.bradfords.org.uk> <1058626962.30424.6.camel@stargate> <plopm3lluu8mv0.fsf@drizzt.kilobug.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <plopm3lluu8mv0.fsf@drizzt.kilobug.org>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0,
	required 7)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> - GNU/Hurd, the  whole systems, is  actually GNU tools  (libc, linker,
>   ...)  on top  of the  GNU Hurd  (set of  servers) and  the  GNU Mach
>   microkernel.

Mach wasn't written by GNU, it's a BSD based kernel pried apart into chunks
by people at CMU.

> - GNU Mach 1.x uses drivers from Linux 2.0.36 (IIRC)
> 
> - GNU  Mach 2.0  (actually 1.9,  as a  beta version),  uses  the OSKit
>   framework, and such drivers from Linux 2.2.12 
> 
> - pfinet (our  TCP/IP server)  comes from Linux  2.0 IP stack
> 
> I'm not aware  of other use of Linux code inside  the Hurd project, or
> even inside the GNU project, but there may be.

Drivers and networking account for about 50% of the total lines of code.
The bulk of the work in any operating system is typically drivers.  The
generic part of Linux (non-driver, non-file system) is tiny compared to 
the rest.

If the Hurd gets its drivers from Linux then it should rightfully be called
Linux/HURD (or Linux/HURD/GNU).

work /tmp/linux-2.5$ bk -rnet cat | wc -l
326411
work /tmp/linux-2.5$ bk -rdrivers cat | wc -l
2605850
work /tmp/linux-2.5$ bk -r cat | wc -l
6618524
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
