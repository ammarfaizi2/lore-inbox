Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285451AbRLSUPK>; Wed, 19 Dec 2001 15:15:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285453AbRLSUPC>; Wed, 19 Dec 2001 15:15:02 -0500
Received: from smtp1.vol.cz ([195.250.128.73]:49672 "EHLO smtp1.vol.cz")
	by vger.kernel.org with ESMTP id <S285451AbRLSUOo>;
	Wed, 19 Dec 2001 15:14:44 -0500
Date: Thu, 13 Dec 2001 22:42:25 +0100
From: Pavel Machek <pavel@suse.cz>
To: Robert Love <rml@tech9.net>
Cc: Ton Hospel <linux-kernel@ton.iguana.be>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make highly niced processes run only when idle
Message-ID: <20011213224225.B129@elf.ucw.cz>
In-Reply-To: <75F30A52-ECF4-11D5-80FE-00039355CFA6@suespammers.org> <1007939114.878.1.camel@phantasy> <9v3nvj$a99$1@post.home.lunix> <1008035682.4287.3.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1008035682.4287.3.camel@phantasy>
User-Agent: Mutt/1.3.23i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Please don't. Whenever you think you priority inheritance, it's a sign your 
> > system has got too complicated. The simplest solution is to simply have no
> > priorities when a task is in-kernel (or at least non that can completely
> > exclude a task).
> 
> I agree, I said it was overkill.
> 
> My solution is going to be to schedule the task as a SCHED_OTHER task
> when in the kernel, and as SCHED_IDLE task otherwise.

Yep, and you can do it without making syscalls any slower, and patch
was already on l-k.

Use ptrace-hooks for branching into your priority-promoting code, and
you'll have 0 impact on fast path.

								Pavel
-- 
"I do not steal MS software. It is not worth it."
                                -- Pavel Kankovsky
