Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272244AbRIKB0r>; Mon, 10 Sep 2001 21:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272247AbRIKB0h>; Mon, 10 Sep 2001 21:26:37 -0400
Received: from hermes.domdv.de ([193.102.202.1]:17674 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S272244AbRIKB0d>;
	Mon, 10 Sep 2001 21:26:33 -0400
Message-ID: <XFMail.20010911032626.ast@domdv.de>
X-Mailer: XFMail 1.4.6-3 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <15261.26206.601070.598763@notabene.cse.unsw.edu.au>
Date: Tue, 11 Sep 2001 03:26:26 +0200 (CEST)
Organization: D.O.M. Datenverarbeitung GmbH
From: Andreas Steinmetz <ast@domdv.de>
To: Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: reboot notifier priority definitions
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> I think this misses the point of reboot notifiers (as I understand
> it).
> 
> There are *only* meant for "physical" sorts of things.
> The comment in the code says:
>  *    Notifier list for kernel code which wants to be called
>  *    at shutdown. This is used to stop any idling DMA operations
>  *    and the like. 
> 
> md, lvm, knfsd and tux have no business registering a reboot notifier.
> If they have something to shut down, it should be shut down in a
> higher-level way, such as when a process gets a signal. 
> 
Even then: My servers do have watchdog cards. Unfortunately without the
priority definitions the watchdog card was shut down prior to the oops. Thus,
due to missing priority, the system did require hitting the reboot button.
So some well defined priorization is still required.


Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH
