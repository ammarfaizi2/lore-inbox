Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261382AbVEAXQ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261382AbVEAXQ4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 19:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbVEAXQ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 19:16:56 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:9882 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261382AbVEAXQy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 19:16:54 -0400
Date: Mon, 2 May 2005 01:16:35 +0200
From: Pavel Machek <pavel@suse.cz>
To: Adam Belay <ambx1@neo.rr.com>, Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] properly stop devices before poweroff
Message-ID: <20050501231635.GJ1909@elf.ucw.cz>
References: <20050421111346.GA21421@elf.ucw.cz> <20050501222403.GF3951@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050501222403.GF3951@neo.rr.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Without this patch, Linux provokes emergency disk shutdowns and
> > similar nastiness. It was in SuSE kernels for some time, IIRC.
> > 
> > Signed-off-by: Pavel Machek <pavel@suse.cz>
> 
> Hi Pavel,
> 
> Although I like using pm_message_t, I'm not sure if we want to commit to only
> PMSG_SUSPEND and PMSG_FREEZE for shutdown and reboot.  Would it be possible
> to create a PMSG_HALT and PMSG_REBOOT?  I think this would give drivers more
> control and flexability to make the right decision.  What is your opinion?
> 
> Of course, I'm still considering the posibility that we really want to do
> PMSG_SUSPEND on a shutdown.  This may work ok on X86, I'm not sure about other
> architectures.

Thats okay, nobody really knows yet. I believe that SUSPEND and HALT
are very similar, and flags best way to separate them. I believe that
FREEZE and REBOOT are very similar, too, and again would use flags to
tell between them.

> I know you mentioned previously adding more flags and data to pm_message_t,
> what exactly are your plans?

First I want type checking for pm_message_t. That's 2.6.12-early
material. Then, when it is *really clear* that flags are needed, I'll
add them. "really needed" as in "we have a driver where it matters".
									Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
