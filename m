Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266821AbUIQBUT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266821AbUIQBUT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 21:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268260AbUIQBUS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 21:20:18 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:43145 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S266821AbUIQBUN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 21:20:13 -0400
Date: Thu, 16 Sep 2004 22:03:39 -0400
From: Adam Kropelin <akropel1@rochester.rr.com>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Suspend2 Merge: Supress various actions/errors while suspending [1/5]
Message-ID: <20040916220339.A24267@mail.kroptech.com>
References: <1095378660.5897.98.camel@laptop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1095378660.5897.98.camel@laptop.cunninghams>; from ncunningham@linuxmail.org on Fri, Sep 17, 2004 at 09:51:03AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2004 at 09:51:03AM +1000, Nigel Cunningham wrote:
> +#ifdef CONFIG_SOFTWARE_SUSPEND2
> +	if (software_suspend_state & SOFTWARE_SUSPEND_RUNNING)
> +		return;
> +#endif
>  	spin_lock(&oom_lock);
>  	now = jiffies;
>  	since = now - last;

Any chance you could...

#ifdef CONFIG_SOFTWARE_SUSPEND2
<whatever-it-is-now>
#else
#define software_suspend_state 0
#endif

...and thereby eliminate all the #ifdefs in the main codepaths?

--Adam

