Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269139AbUIHMJH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269139AbUIHMJH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 08:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269152AbUIHMJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 08:09:06 -0400
Received: from cantor.suse.de ([195.135.220.2]:42119 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S269139AbUIHMEp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 08:04:45 -0400
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fw: 2.6.9-rc1-mm4: swsusp + AMD64 = LOCKUP on CPU0
References: <20040908021637.57525d43.akpm@osdl.org.suse.lists.linux.kernel>
	<20040908102652.GA2921@atrey.karlin.mff.cuni.cz.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 08 Sep 2004 14:01:08 +0200
In-Reply-To: <20040908102652.GA2921@atrey.karlin.mff.cuni.cz.suse.lists.linux.kernel>
Message-ID: <p73acw1hsvv.fsf@brahms.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> writes:

> Hi!
> 
> > One for you guys on lkml ;)
> 
> It simply takes long to count pages (O(n^2) algorithm), so watchdog
> triggers. I have better algorithm locally, but would like merge to
> linus first. (I posted it to lkml some days ago, I can attach the
> bigdiff).
> 
> Just disable the watchdog. Suspend *is* going to take time with
> disabled interrupts.


As a short term workaround you could also add touch_nmi_watchdog()s
in that loop.

-Andi
