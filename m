Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267633AbTBQXEX>; Mon, 17 Feb 2003 18:04:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267635AbTBQXEX>; Mon, 17 Feb 2003 18:04:23 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:50956 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S267633AbTBQXEW>; Mon, 17 Feb 2003 18:04:22 -0500
Date: Mon, 17 Feb 2003 18:13:20 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: kai@tp1.ruhr-uni-bochum.de, linux-kernel@vger.kernel.org,
       rob@osinvestor.com
Subject: Re: Build problem in 2.5.61/sparc
Message-ID: <20030217181320.A31157@devserv.devel.redhat.com>
References: <20030217152328.A7540@devserv.devel.redhat.com> <20030217203336.GA30694@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030217203336.GA30694@mars.ravnborg.org>; from sam@ravnborg.org on Mon, Feb 17, 2003 at 09:33:36PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Mon, 17 Feb 2003 21:33:36 +0100
> From: Sam Ravnborg <sam@ravnborg.org>

> > [zaitcev@lebethron linux-2.5.61-sparc]$ make oldconfig
> > make -f scripts/Makefile.build obj=scripts
> > make[1]: *** No rule to make target `scripts/fixdep', needed by `__build'.  Stop.
> > make: *** [scripts] Error 2
> > [zaitcev@lebethron linux-2.5.61-sparc]$
> 
> Looks to me that you are missing scripts/fixdep.c
> fixdep.c got updated recently and somehow you may have lost that file in the process?

FYI, it turned out that my make(1) was out of date. I was using
make 3.76.1. I upgraded to make 3.80 and everything works so far.
This is actually documented in Documentation/Changes.
As an added bonus, I get working $(CURDIR), so I may stop
commenting out ACPI now.

-- Pete
