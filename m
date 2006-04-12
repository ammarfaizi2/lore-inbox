Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932085AbWDLHEs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbWDLHEs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 03:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932090AbWDLHEs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 03:04:48 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:34974 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932085AbWDLHEr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 03:04:47 -0400
Date: Wed, 12 Apr 2006 16:06:19 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, clameter@engr.sgi.com,
       riel@redhat.com, dgc@sgi.com
Subject: Re: [PATCH] support for panic at OOM
Message-Id: <20060412160619.31a3c027.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060411235907.6a59ecba.akpm@osdl.org>
References: <20060412155301.10d611ca.kamezawa.hiroyu@jp.fujitsu.com>
	<20060411235907.6a59ecba.akpm@osdl.org>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 11 Apr 2006 23:59:07 -0700
Andrew Morton <akpm@osdl.org> wrote:

> KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:
> >
> > This patch adds a feature to panic at OOM, oom_die.
> 
> Makes sense I guess.
> 
Thanks,

> > @@ -718,6 +719,14 @@ static ctl_table vm_table[] = {
> >  		.proc_handler	= &proc_dointvec,
> >  	},
> >  	{
> > +		.ctl_name	= VM_OOM_DIE,
> > +		.procname	= "oom_die",
> 
> I'd suggest it be called "panic_on_oom".  Like the current panic_on_oops.
> 
I'll chage.

> > +int sysctl_oom_die = 0;
> 
> The initialisation is unneeded.
> 
Okay,


> > +		if (sysctl_oom_die)
> > +			oom_die();
> 
> I don't think we need a separate function for this?
> 
Hmm.. okay. I'll put panic("Panic: out of memory: panic_on_oom is 1.") directly.

> Please document the new sysctl in Documentation/sysctl/.
> 
I'll do.


Thanks,
-Kame

