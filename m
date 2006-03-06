Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751933AbWCFQfr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751933AbWCFQfr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 11:35:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751914AbWCFQfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 11:35:43 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:14311 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751867AbWCFQfX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 11:35:23 -0500
Date: Mon, 6 Mar 2006 12:56:07 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: Andrew Morton <akpm@osdl.org>, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
Subject: Re: [patch] fix hardcoded values in collie frontlight
Message-ID: <20060306115607.GA28908@elf.ucw.cz>
References: <20060305142859.GA21173@elf.ucw.cz> <1141587964.6521.55.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141587964.6521.55.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > @@ -93,11 +94,13 @@ void locomolcd_power(int on)
> >  	}
> >  
> >  	/* read comadj */
> > +	if (comadj == -1) {
> >  #ifdef CONFIG_MACH_POODLE
> > -	comadj = 118;
> > +		comadj = 118;
> >  #else
> > -	comadj = 128;
> > +		comadj = 128;
> >  #endif
> > +	}
> 
> Perhaps use machine_is_poodle() and machine_is_collie() here?

Yep, and unneccesssary includes can be killed. Thanks.
								Pavel

-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
