Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263031AbTCSNLd>; Wed, 19 Mar 2003 08:11:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263032AbTCSNLd>; Wed, 19 Mar 2003 08:11:33 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:14857 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S263031AbTCSNLc>; Wed, 19 Mar 2003 08:11:32 -0500
Date: Wed, 19 Mar 2003 14:22:15 +0100
From: Pavel Machek <pavel@ucw.cz>
To: mikpe@csd.uu.se
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: apic-to-drivermodel conversion
Message-ID: <20030319132214.GA24278@atrey.karlin.mff.cuni.cz>
References: <20030318202858.GA154@elf.ucw.cz> <20030318161852.41a703a4.akpm@digeo.com> <15992.18243.605716.244572@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15992.18243.605716.244572@gargle.gargle.HOWL>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>  > > This converts apic code to use driver model. It is neccessary for S3
>  > > when you are using apic. 
>  > 
>  > Seems to be missing something.
>  > 
>  > arch/i386/kernel/apm.c: In function `suspend':
>  > arch/i386/kernel/apm.c:1242: warning: implicit declaration of function `device_suspend'
>  > arch/i386/kernel/apm.c:1242: `SUSPEND_POWER_DOWN' undeclared (first use in this function)
>  > arch/i386/kernel/apm.c:1242: (Each undeclared identifier is reported only once
>  > arch/i386/kernel/apm.c:1242: for each function it appears in.)
>  > arch/i386/kernel/apm.c:1264: warning: implicit declaration of function `device_resume'
>  > arch/i386/kernel/apm.c:1264: `RESUME_POWER_ON' undeclared (first use in this function)
>  > arch/i386/kernel/apm.c: In function `check_events':
>  > arch/i386/kernel/apm.c:1378: `RESUME_POWER_ON' undeclared (first use in this function)
> 
> Try this patch instead. This is my merge of my and Pavel's earlier
> patches, so it differs from Pavel's in some details.
> My patch works with APM -- I can do repeated synchronous and
> asynchronous suspends with it.
> I haven't tested oprofile. There are some issues wrt oprofile's
> interface with the local-APIC NMI watchdog. Pavel suggested one
> (IMHO ugly) workaround, I and John suggested another (viz, an
> enable/disable API with one bit of history). My patch implements
> that API.

Yes this looks nice, too. Linus please apply one of them, probably
Mikael's since he has worked on this code before.
								Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
