Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267433AbTBITkR>; Sun, 9 Feb 2003 14:40:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267434AbTBITkR>; Sun, 9 Feb 2003 14:40:17 -0500
Received: from smtp1.clear.net.nz ([203.97.33.27]:47054 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP
	id <S267433AbTBITkQ>; Sun, 9 Feb 2003 14:40:16 -0500
Date: Mon, 10 Feb 2003 08:42:13 +1300
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: [ACPI] Re: [PATCH] s4bios for 2.5.59 + apci-20030123
In-reply-to: <20030207160055.GA485@elf.ucw.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: Ducrot Bruno <ducrot@poupinou.org>,
       "Grover, Andrew" <andrew.grover@intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI List <acpi-devel@lists.sourceforge.net>,
       Swsusp <swsusp@lister.fornax.hu>
Message-id: <1044819732.1815.25.camel@laptop-linux.cunninghams>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.1
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <F760B14C9561B941B89469F59BA3A847137FFE@orsmsx401.jf.intel.com>
 <20030204221003.GA250@elf.ucw.cz>
 <1044477704.1648.19.camel@laptop-linux.cunninghams>
 <20030206101645.GO1205@poup.poupinou.org>
 <1044560486.1700.13.camel@laptop-linux.cunninghams>
 <20030206210542.GW1205@poup.poupinou.org>
 <1044590241.1649.41.camel@laptop-linux.cunninghams>
 <20030207160055.GA485@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Sat, 2003-02-08 at 05:00, Pavel Machek wrote: 
> > 1  2  3           4     5
> > --
> > 1  1  25655/30592  1562 0:07
> > 1  2  26246/30592  4302 0:05
> 
> You can suspend and resume your notebook within 5 seconds? Wow!

As requested, these were just the times for suspending.

> Well, if all the memory is in disk-backed clean pages, it should be
> faster to discard then write out...

Yes, I would think so too. Perhaps the differences would probably
disappear if I made the algorithm more like your original (ie simplifed
eat_memory back to the original), but I do remember lots of disk
activity when using the original code as well - perhaps the cause might
be worth further investigation? (Not that I'm volunteering)

> Anyway... So your method is faster. Good. Now, how much more
> complicated is it?

As I've said above, I'm not sure it is right to say it is faster - I
didn't compare your current method with the new one, but rather mine
with parameters making the algorithm as close to yours as possible. My
point was more that if the new method is slower, its not significantly
slower.

Nevertheless, you do have a good point - it is more complicated. But I
think it's worth it and its not a lot more complicated. People who are
using the new method at the moment appreciate the changes. Don't think
for a moment that I don't value your work, Pavel. I couldn't have done
any of my additions without it and consider mine tweaking. This has
simply been a quest to get a more responsive system on resume.

Regards,

Nigel

