Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751556AbWF1V0d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751556AbWF1V0d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 17:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751553AbWF1V0d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 17:26:33 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:8129 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751543AbWF1V0c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 17:26:32 -0400
Date: Wed, 28 Jun 2006 23:26:16 +0200
From: Pavel Machek <pavel@suse.cz>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-acpi@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.17-mm3: swsusp fails when process is debugged by ptrace
Message-ID: <20060628212616.GB30373@elf.ucw.cz>
References: <44A2B9AF.50803@goop.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44A2B9AF.50803@goop.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> If I try to suspend the machine while a process debug-stopped by ptrace, 
> suspend fails:
> 
> PM: Preparing system for mem sleep
> Freezing cpus ...
> Breaking affinity for irq 0
> Breaking affinity for irq 1
> Breaking affinity for irq 12
> Breaking affinity for irq 23
> CPU 1 is now offline
> SMP alternatives: switching to UP code
> CPU1 is down
> Stopping tasks: 
> ==========================================================================================================================================================
> stopping tasks timed out after 20 seconds (13 tasks remaining):
>  khubd
>  kseriod
>  pdflush
>  pdflush
>  kswapd0
>  kprefetchd
>  pccardd
>  kirqd
>  kjournald
>  kauditd
>  knodemgrd_0
>  kjournald
>  test-vsnprintf
> Restarting tasks...<6> Strange, khubd not stopped
> Strange, kseriod not stopped
> Strange, pdflush not stopped
> Strange, pdflush not stopped
> Strange, kswapd0 not stopped
> Strange, kprefetchd not stopped
> Strange, pccardd not stopped
> Strange, kirqd not stopped
> Strange, kjournald not stopped
> Strange, kauditd not stopped
> Strange, knodemgrd_0 not stopped
> Strange, kjournald not stopped
> Strange, test-vsnprintf not stopped
> done
> Thawing cpus ...
> 
> In this case, test-vsnprintf is stopped in a breakpoint in gdb.  If I 
> quit it, then suspend works as expected.

Does it also happen when you do strace? ...I remember trying to solve
that, but 2.6.17-mm3 is very recent...?
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
