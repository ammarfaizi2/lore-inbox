Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262992AbTCSLq4>; Wed, 19 Mar 2003 06:46:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262993AbTCSLq4>; Wed, 19 Mar 2003 06:46:56 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:48900 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S262992AbTCSLqz>; Wed, 19 Mar 2003 06:46:55 -0500
Date: Wed, 19 Mar 2003 12:57:42 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@digeo.com>
Cc: Pavel Machek <pavel@ucw.cz>, mikpe@csd.uu.se, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: apic-to-drivermodel conversion
Message-ID: <20030319115742.GA16122@atrey.karlin.mff.cuni.cz>
References: <20030318202858.GA154@elf.ucw.cz> <20030318161852.41a703a4.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030318161852.41a703a4.akpm@digeo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > This converts apic code to use driver model. It is neccessary for S3
> > when you are using apic. 
> 
> Seems to be missing something.

oops, apm.c needs to include <linux/device.h>. Will fix that.
										Pavel

> arch/i386/kernel/apm.c: In function `suspend':
> arch/i386/kernel/apm.c:1242: warning: implicit declaration of function `device_suspend'
> arch/i386/kernel/apm.c:1242: `SUSPEND_POWER_DOWN' undeclared (first use in this function)
> arch/i386/kernel/apm.c:1242: (Each undeclared identifier is reported only once
> arch/i386/kernel/apm.c:1242: for each function it appears in.)
> arch/i386/kernel/apm.c:1264: warning: implicit declaration of function `device_resume'
> arch/i386/kernel/apm.c:1264: `RESUME_POWER_ON' undeclared (first use in this function)
> arch/i386/kernel/apm.c: In function `check_events':
> arch/i386/kernel/apm.c:1378: `RESUME_POWER_ON' undeclared (first use in this function)

-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
