Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264047AbTEOOjk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 10:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264050AbTEOOjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 10:39:40 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:38152 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264047AbTEOOjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 10:39:37 -0400
Date: Thu, 15 May 2003 16:52:24 +0200
From: Pavel Machek <pavel@suse.cz>
To: mikpe@csd.uu.se
Cc: Adrian Bunk <bunk@fs.tum.de>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.69-mm5: CONFIG_ACPI_SLEEP compile error
Message-ID: <20030515145224.GA26649@atrey.karlin.mff.cuni.cz>
References: <20030514012947.46b011ff.akpm@digeo.com> <20030514214536.GK1346@fs.tum.de> <20030514225157.GA13427@elf.ucw.cz> <16067.25088.905125.474440@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16067.25088.905125.474440@gargle.gargle.HOWL>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>  > Mikpe, is this your diff? 
>  > 
>  > revision 1.16
>  > date: 2003/05/11 18:58:48;  author: mikpe;  state: Exp;  lines: +2 -4
>  > restore sysenter MSRs at APM resume
>  > 
>  > I do not know why you changed it (it has certainly nothing to do with
>  > APM resume)... Please revert it.
> 
> I've just posted a fix for the compile error.
> 
> APM suspend and resume now use the save and restore processor state
> procedures in suspend.c. The only alternative is to duplicate that
> functionality in apm.c or a new "suspend-but-not-tied-to-acpi.c" file.
> But suspend.c is fairly generic so it makes sense to share it with APM.
> 
> The suspend.c changes are cleanups. The variables are only used in acpi's
> suspend_asm.S and acpi/wakeup.S, so I moved them to suspend_asm.S since
> they aren't needed when suspend is done by APM. fix_processor_context()
> isn't used outside of suspend.c so I made it static.
> 
> Do you still have a problem with this?

No, it actually looks better than original. Just make sure it is in
for 2.5.70...
								Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
