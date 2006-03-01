Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751105AbWCAWuS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbWCAWuS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 17:50:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751929AbWCAWuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 17:50:18 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:37850
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1751105AbWCAWuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 17:50:16 -0500
Date: Wed, 1 Mar 2006 14:50:13 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: pj@sgi.com, ebiederm@xmission.com, linux-kernel@vger.kernel.org,
       "Zhang, Yanmin" <yanmin.zhang@intel.com>
Subject: Re: + proc-dont-lock-task_structs-indefinitely-cpuset-fix-2.patch added to -mm tree
Message-ID: <20060301225013.GA20834@kroah.com>
References: <20060228201040.34a1e8f5.pj@sgi.com> <m1irqypxf5.fsf@ebiederm.dsl.xmission.com> <20060228212501.25464659.pj@sgi.com> <20060228234807.55f1b25f.pj@sgi.com> <20060301002631.48e3800e.akpm@osdl.org> <20060301015338.b296b7ad.pj@sgi.com> <20060301192103.GA14320@kroah.com> <20060301125802.cce9ef51.pj@sgi.com> <20060301213048.GA17251@kroah.com> <20060301142631.22738f2d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060301142631.22738f2d.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2006 at 02:26:31PM -0800, Andrew Morton wrote:
> Greg KH <greg@kroah.com> wrote:
> >
> > On Wed, Mar 01, 2006 at 12:58:02PM -0800, Paul Jackson wrote:
> > > Greg wrote:
> > > > As reported this is expected, and can be ignored safely.  It's just scsi
> > > > being bad :)
> > > 
> > > Yeah - so I eventually realized.
> > > 
> > > > >  [<a0000001001eac90>] sysfs_create_group+0x30/0x2a0
> > > > >                                 sp=e00002343bd97d50 bsp=e00002343bd91120
> > > > >  [<a000000100809190>] topology_cpu_callback+0x70/0xc0
> > > > >                                 sp=e00002343bd97d60 bsp=e00002343bd910f0
> > > > >  [<a000000100809260>] topology_sysfs_init+0x80/0x120
> > > > >                                 sp=e00002343bd97d60 bsp=e00002343bd910d0
> > > > 
> > > > This points at the sysfs cpu patches that are in -mm, which are not in
> > > > my tree...
> > > 
> > > So ... what does that mean for who should be looking at this?
> > 
> > Hm, looks like that stuff went into mainline already, sorry I thought it
> > was still in -mm.
> > 
> > Look at changeset 69dcc99199fe29b0a29471a3488d39d9d33b25fc for details.
> 
> But Paul bisected it down to a particular not-merged patch,
> gregkh-driver-allow-sysfs-attribute-files-to-be-pollable.patch, which I'll
> admit doesn't look like it'll cause this.

Yeah, I realize that, it just really seems odd that this code dies, and
I thought it was still in your tree at the time, sorry.

Oh, and Paul, this all works just fine with no -mm, right?

thanks,

greg k-h
