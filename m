Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268392AbUIQGOR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268392AbUIQGOR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 02:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268335AbUIQGOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 02:14:17 -0400
Received: from 147.32.220.203.comindico.com.au ([203.220.32.147]:22693 "EHLO
	relay01.mail-hub.kbs.net.au") by vger.kernel.org with ESMTP
	id S268392AbUIQGOM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 02:14:12 -0400
Subject: Re: [PATCH] Suspend2 Merge: Supress various actions/errors while
	suspending [1/5]
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Adam Kropelin <akropel1@rochester.rr.com>
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040916220339.A24267@mail.kroptech.com>
References: <1095378660.5897.98.camel@laptop.cunninghams>
	 <20040916220339.A24267@mail.kroptech.com>
Content-Type: text/plain
Message-Id: <1095401738.5902.131.camel@laptop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 17 Sep 2004 16:15:38 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Fri, 2004-09-17 at 12:03, Adam Kropelin wrote:
> On Fri, Sep 17, 2004 at 09:51:03AM +1000, Nigel Cunningham wrote:
> > +#ifdef CONFIG_SOFTWARE_SUSPEND2
> > +	if (software_suspend_state & SOFTWARE_SUSPEND_RUNNING)
> > +		return;
> > +#endif
> >  	spin_lock(&oom_lock);
> >  	now = jiffies;
> >  	since = now - last;
> 
> Any chance you could...
> 
> #ifdef CONFIG_SOFTWARE_SUSPEND2
> <whatever-it-is-now>
> #else
> #define software_suspend_state 0
> #endif
> 
> ...and thereby eliminate all the #ifdefs in the main codepaths?

Will do.

Thanks for the suggestion.

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Many today claim to be tolerant. True tolerance, however, can cope with others
being intolerant.

