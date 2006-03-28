Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750743AbWC1D5P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbWC1D5P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 22:57:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbWC1D5P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 22:57:15 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:59617 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1750743AbWC1D5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 22:57:14 -0500
From: "Peter T. Breuer" <ptb@inv.it.uc3m.es>
Message-Id: <200603280357.k2S3vBk14437@inv.it.uc3m.es>
Subject: Re: uptime increases during suspend
In-Reply-To: <44286783.9000709@tremplin-utc.net> from "Eric Piel" at "Mar 28,
 2006 00:30:27 am"
To: "Eric Piel" <Eric.Piel@tremplin-utc.net>
Date: Tue, 28 Mar 2006 05:57:11 +0200 (MET DST)
CC: "Peter T. Breuer" <ptb@inv.it.uc3m.es>,
       "john stultz" <johnstul@us.ibm.com>, linux-kernel@vger.kernel.org
X-Anonymously-To: 
Reply-To: ptb@inv.it.uc3m.es
X-message-flag: Had your Outlook virus, today?  http://www.counterpane.com/crypto-gram-0103.html#4
X-WebTV-Stationery: Standard\; BGColor=black\; TextColor=black
Reply-By: Sat, 1 Apr 2006 14:21:08 -0700
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Also sprach Eric Piel:"
> monotonic clock. Linux has such thing since few releases. Using 
> CLOCK_MONOTONIC (cf "man 3 clock_gettime") may look much less hacky than 
> using the uptime ;-)

Actually, the man page does not say anything about the behavior across
suspends, and ...

      CLOCK_REALTIME
              System-wide  realtime clock.  Setting this clock requires appro-
              priate privileges.

       CLOCK_MONOTONIC
              Clock that cannot be set and  represents  monotonic  time  since
              some unspecified starting point.

I'd understand both those wordings the same way!  Well, I suppose
"cannot be set" means that at least humans can't willingly interfere with
it, but maybe something else can.

> Now... concerning the suspend effect on this clock, I don't know. It's 
> probably the same problem as uptime: no official semantic has ever been 
> stated yet... Does anyone know?

"Monotonic" means "always goes in the same direction", not "never
skips".

Peter
