Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267687AbUHJUAU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267687AbUHJUAU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 16:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267689AbUHJUAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 16:00:20 -0400
Received: from fw.osdl.org ([65.172.181.6]:47773 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267687AbUHJUAO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 16:00:14 -0400
Date: Tue, 10 Aug 2004 13:00:09 -0700
From: Chris Wright <chrisw@osdl.org>
To: James Morris <jmorris@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Kurt Garloff <garloff@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       Greg KH <greg@kroah.com>
Subject: Re: [PATCH] [LSM] Rework LSM hooks
Message-ID: <20040810130009.P1924@build.pdx.osdl.net>
References: <1092150120.16939.25.camel@localhost.localdomain> <Xine.LNX.4.44.0408101512520.9121-100000@dhcp83-76.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Xine.LNX.4.44.0408101512520.9121-100000@dhcp83-76.boston.redhat.com>; from jmorris@redhat.com on Tue, Aug 10, 2004 at 03:22:19PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* James Morris (jmorris@redhat.com) wrote:
> On Tue, 10 Aug 2004, Alan Cox wrote:
> 
> > On Maw, 2004-08-10 at 15:16, James Morris wrote:
> > > On Tue, 10 Aug 2004, Kurt Garloff wrote:
> > > 
> > > > * Even with selinux=0 and capability loaded, the kernel takes a 
> > > >   few percents in networking benchmarks (measured by HP on ia64); 
> > > >   this is caused by the slowliness of indirect jumps on ia64.
> > > 
> > > Is this just an ia64 issue?  If so, then perhaps we should look at only
> > > penalising ia64?  Otherwise, loading an LSM module is going to cause
> > > expensive false unlikely() on _every_ LSM hook.
> > 
> > I see this on x86-32 to an extent. Its quite visible with gigabit as
> > you'd expect. ia64 ought to be less affected providing the compiler is
> > doing the right things with the unconditional jumps.
> 
> I did some benchmarking (full results below), and I'm not seeing anything
> significant on a P4 Xeon.

Is this new (i.e. you just did this)?  It's basically the same result we
had from a few years ago.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
