Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423433AbWBBJyf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423433AbWBBJyf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 04:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423435AbWBBJyf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 04:54:35 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:177 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1423429AbWBBJyT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 04:54:19 -0500
Date: Thu, 2 Feb 2006 10:54:07 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, linux-kernel@vger.kernel.org
Subject: Re: [ 02/10] [Suspend2] Module (de)registration.
Message-ID: <20060202095407.GA1981@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <20060201113713.6320.99223.stgit@localhost.localdomain> <84144f020602010437n1d738b94m2d08ddfb21fdb300@mail.gmail.com> <200602012247.45286.nigel@suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602012247.45286.nigel@suspend2.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On St 01-02-06 22:47:41, Nigel Cunningham wrote:
> Hi.
> 
> On Wednesday 01 February 2006 22:37, Pekka Enberg wrote:
> > Hi,
> >
> > On 2/1/06, Nigel Cunningham <nigel@suspend2.net> wrote:
> > > +++ b/kernel/power/modules.c
> > > @@ -0,0 +1,87 @@
> >
> > [snip]
> >
> > > +
> > > +struct list_head suspend_filters, suspend_writers, suspend_modules;
> > > +struct suspend_module_ops *active_writer = NULL;
> > > +static int num_filters = 0, num_ui = 0;
> > > +int num_writers = 0, num_modules = 0;
> >
> > Unneeded assignments, they're already guaranteed to be zeroed.
> 
> Good point. Will fix.
> 
> > > +       list_add_tail(&module->module_list, &suspend_modules);
> > > +       num_modules++;
> >
> > No locking, why?
> 
> Not needed - the callers are _init routines only.

And insmod?
								Pavel



-- 
Thanks, Sharp!
