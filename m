Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267658AbTBKME3>; Tue, 11 Feb 2003 07:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267679AbTBKME3>; Tue, 11 Feb 2003 07:04:29 -0500
Received: from [195.39.17.254] ([195.39.17.254]:19972 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S267658AbTBKME3>;
	Tue, 11 Feb 2003 07:04:29 -0500
Date: Tue, 11 Feb 2003 12:53:11 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: levon@movementarian.org, linux-kernel@vger.kernel.org
Subject: Re: Switch APIC (+nmi, +oprofile) to driver model
Message-ID: <20030211115309.GA892@elf.ucw.cz>
References: <200302101905.UAA14874@kim.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302101905.UAA14874@kim.it.uu.se>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >So it seems to me it really is variable.
> 
> The original code has the property that apic_pm_state.active is
> true if and only if detect_init_APIC() was called and succeeded,
> which implies that apic_phys == mp_lapic_addr == APIC_DEFAULT_PHYS_BASE.
> You can also see that apic_pm_resume() writes APIC_DEFAULT_PHYS_BASE
> to MSR_IA32_APICBASE, which only makes sense in this situation.

Ahha, sorry about previous comment. Yep, you are right. I wonder if I
should BUG_ON() there, but I just cleaned it up for now.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
