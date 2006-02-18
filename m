Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751038AbWBRJQK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbWBRJQK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 04:16:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751060AbWBRJQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 04:16:09 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:15830 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751038AbWBRJQI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 04:16:08 -0500
Date: Sat, 18 Feb 2006 14:45:08 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, paulmck@us.ibm.com
Subject: Re: [PATCH 1/2] rcu batch tuning
Message-ID: <20060218091508.GO29846@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20060217154147.GL29846@in.ibm.com> <20060217154337.GM29846@in.ibm.com> <20060218004551.19358b6d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060218004551.19358b6d.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 18, 2006 at 12:45:51AM -0800, Andrew Morton wrote:
> Dipankar Sarma <dipankar@in.ibm.com> wrote:
> >
> > -module_param(maxbatch, int, 0);
> >  +module_param(blimit, int, 0);
> >  +module_param(qhimark, int, 0);
> >  +module_param(qlowmark, int, 0);
> >  +#ifdef CONFIG_SMP
> >  +module_param(rsinterval, int, 0);
> >  +#endif
> 
> It's a bit unusual to add boot-time tunables via module_param, but there's
> no law against it.
> 
> But you do get arrested for not adding them to
> Documentation/kernel-parameters.txt.  That's if you think they're permanent
> (I hope they aren't).  If they are, they'll probably need a more extensive
> description than kernel-parameters.txt entries normally provide.

I hope that we will not need that many tunables eventually. But my
theory has been that with widespread use and experiments with
the tunables in the event of OOM and latency problems will allow
us to figure out what kind of automatic tuning really works.

Regardless, I think there should be documentation. I will send
a documentation patch.

Thanks
Dipankar

