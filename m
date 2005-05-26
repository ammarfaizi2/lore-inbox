Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261469AbVEZN4C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261469AbVEZN4C (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 09:56:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261471AbVEZN4C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 09:56:02 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:1427 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261469AbVEZNzz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 09:55:55 -0400
Date: Thu, 26 May 2005 15:55:33 +0200
From: Pavel Machek <pavel@suse.cz>
To: romano@dea.icai.upco.es, Olaf Hering <olh@suse.de>,
       Pavel Machek <pavel@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] show swsuspend only on .config where it can compile
Message-ID: <20050526135533.GA15727@elf.ucw.cz>
References: <20050526111614.GA25685@suse.de> <20050526124911.GA19822@pern.dea.icai.upco.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050526124911.GA19822@pern.dea.icai.upco.es>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > kernel/power/smp.c:24: error: storage size of `ctxt' isn't known
> > 
> > Signed-off-by: Olaf Hering <olh@suse.de>
> > 
> > Index: linux-2.6.12-rc5-olh/kernel/power/Kconfig
> > ===================================================================
> > --- linux-2.6.12-rc5-olh.orig/kernel/power/Kconfig
> > +++ linux-2.6.12-rc5-olh/kernel/power/Kconfig
> > @@ -28,7 +28,7 @@ config PM_DEBUG
> >  
> >  config SOFTWARE_SUSPEND
> >  	bool "Software Suspend (EXPERIMENTAL)"
> > -	depends on EXPERIMENTAL && PM && SWAP
> > +	depends on EXPERIMENTAL && PM && SWAP && (X86 && SMP) || ((FVR || PPC32 || X86) && !SMP)
> 
> Shouldn't be ...&& ( (X86 && SMP) || (FVR || PPC32 || X86) && !SMP )
> > ?

Missing parenthesis added, thanks.
								Pavel
