Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312141AbSC2Vsh>; Fri, 29 Mar 2002 16:48:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312162AbSC2Vs2>; Fri, 29 Mar 2002 16:48:28 -0500
Received: from [195.39.17.254] ([195.39.17.254]:48775 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S312141AbSC2VsP>;
	Fri, 29 Mar 2002 16:48:15 -0500
Date: Fri, 29 Mar 2002 22:27:47 +0100
From: Pavel Machek <pavel@ucw.cz>
To: linux-kernel@vger.kernel.org, Patrick Mochel <mochel@osdl.org>
Cc: ACPI mailing list <acpi-devel@lists.sourceforge.net>
Subject: Re: [patch] Device model update (with power state transitions)
Message-ID: <20020329212745.GA4751@elf.ucw.cz>
In-Reply-To: <20020326190858.D324@toy.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> (The first is not necessarily related to the other two, but the other two 
> were created relative to the first, and it's otherwise innocuous).
> 
> 1. Implements notion of 'system' bus, so system level devices can be added 
> in a comon spot. This includes things like CPUs, PICs, timers, etc.

Good thing, but naming is pretty inconsistent.

You have device_register() but register_sys_device(). 

> Testing welcome also, though I wouldn't expect one to get very far, since 
> they're not actually used. ;) Which, brings up another question - what 
> would be the proper place to call device_shutdown()? (I haven't looked 
> very far into that part...)

Tested, seems to work.
									Pavel
PS: On toshiba 4030cdt, I can suspend once without no apparent ill
effects. On resume I get 

utmisc-0373 Ut_acquire_mutex : Invalid acquire order: Thread 5C owns
[ACPI_MTX_Hardware], wants [ACPI_MTX_Namespace].

followed by more warnings. Is there easy way to debug this?

-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
