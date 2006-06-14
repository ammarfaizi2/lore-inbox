Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964868AbWFNB0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964868AbWFNB0h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 21:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964869AbWFNB0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 21:26:37 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:15511 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S964868AbWFNB0g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 21:26:36 -0400
Subject: Re: [Lse-tech] [PATCH 04/11] Task watchers: Make process events
	configurable as a module
From: Matt Helsley <matthltc@us.ibm.com>
To: Chase Venters <chase.venters@clientec.com>
Cc: Andrew Morton <akpm@osdl.org>, Shailabh Nagar <nagar@watson.ibm.com>,
       Chandra S Seetharaman <sekharan@us.ibm.com>,
       John T Kohl <jtk@us.ibm.com>, Balbir Singh <balbir@in.ibm.com>,
       Jes Sorensen <jes@sgi.com>, Linux-Kernel <linux-kernel@vger.kernel.org>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       Alan Stern <stern@rowland.harvard.edu>,
       LSE-Tech <lse-tech@lists.sourceforge.net>
In-Reply-To: <200606131955.04554.chase.venters@clientec.com>
References: <20060613235122.130021000@localhost.localdomain>
	 <1150242882.21787.144.camel@stark>
	 <200606131955.04554.chase.venters@clientec.com>
Content-Type: text/plain
Date: Tue, 13 Jun 2006 18:18:32 -0700
Message-Id: <1150247912.21787.215.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-13 at 19:54 -0500, Chase Venters wrote:
> On Tuesday 13 June 2006 18:54, Matt Helsley wrote:
> 
> > +static void cn_proc_fini(void)
> > +{
> > +	int err;
> > +
> > +	err = unregister_task_watcher(&cn_proc_nb);
> > +	if (err != 0)
> > +		printk(KERN_WARNING
> > +		       "cn_proc failed to unregister its task notify block\n");
> 
> How about if (err), or if (unregister_task_watcher(&cn_proc_nb))?

I don't see any worthwhile benefit to the former and I've seen feedback
that the latter is less readable.

> > +	cn_del_callback(&cn_proc_event_id);
> > +}
> > +
> >  module_init(cn_proc_init);
> > +module_exit(cn_proc_fini);
> 
> Thanks,
> Chase


