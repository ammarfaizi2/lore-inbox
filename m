Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261717AbVAYImq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261717AbVAYImq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 03:42:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261751AbVAYImq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 03:42:46 -0500
Received: from gprs212-236.eurotel.cz ([160.218.212.236]:6529 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261717AbVAYImn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 03:42:43 -0500
Date: Tue, 25 Jan 2005 09:42:31 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Enable swsusp on SMP machines
Message-ID: <20050125084231.GC1369@elf.ucw.cz>
References: <20050124171943.GA2499@elf.ucw.cz> <E1Ct8zE-0002TK-00@chiark.greenend.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1Ct8zE-0002TK-00@chiark.greenend.org.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > -	/* Suspend is hard to get right on SMP. */
> > -	if (num_online_cpus() != 1) {
> > -		error = -EPERM;
> > +	if (state == PM_SUSPEND_DISK) {
> > +		error = pm_suspend_disk();
> >  		goto Unlock;
> >  	}
> >  
> > -	if (state == PM_SUSPEND_DISK) {
> > -		error = pm_suspend_disk();
> > +	/* Suspend is hard to get right on SMP. */
> > +	if (num_online_cpus() != 1) {
> > +		error = -EPERM;
> >  		goto Unlock;
> >  	}
> 
> Are you sure about this?

Yes, as we already agreed on in private mails ;-). The diff really is
confusing.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
