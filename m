Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030181AbWBHAHb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030181AbWBHAHb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 19:07:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030303AbWBHAHb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 19:07:31 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:7357 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S1030181AbWBHAHb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 19:07:31 -0500
Date: Tue, 7 Feb 2006 16:07:15 -0800
From: Greg KH <greg@kroah.com>
To: ak@suse.de
Cc: Dave Jones <davej@redhat.com>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       Andrew Morton <akpm@osdl.org>, Neal Becker <ndbecker2@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc1 panic on startup (acpi)
Message-ID: <20060208000715.GA19233@kroah.com>
References: <ds7cu3$9c0$1@sea.gmane.org> <ds7f17$gp7$1@sea.gmane.org> <20060207145913.714fec1c.akpm@osdl.org> <20060207231835.GA19648@kroah.com> <20060207233059.GA17665@redhat.com> <Pine.LNX.4.58.0602071534380.12589@shark.he.net> <20060207234043.GB17665@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060207234043.GB17665@redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2006 at 06:40:43PM -0500, Dave Jones wrote:
> On Tue, Feb 07, 2006 at 03:35:31PM -0800, Randy.Dunlap wrote:
>  > On Tue, 7 Feb 2006, Dave Jones wrote:
>  > 
>  > > On Tue, Feb 07, 2006 at 03:18:35PM -0800, Greg Kroah-Hartman wrote:
>  > >  > On Tue, Feb 07, 2006 at 02:59:13PM -0800, Andrew Morton wrote:
>  > >  > > Neal Becker <ndbecker2@gmail.com> wrote:
>  > >  > > >
>  > >  > > > Sorry, I meant 2.6.16-rc1 (not 2.6.12)
>  > >  > > >
>  > >  > > > Neal Becker wrote:
>  > >  > > >
>  > >  > > > > HP dv8000 notebook
>  > >  > > > > 2.6.15 is fine, but 2.6.12-rc1 panics immediately on startup
>  > >  > > > >
>  > >  > > > > Here is a picture of some traceback
>  > >  > > > > https://bugzilla.redhat.com/bugzilla/attachment.cgi?id=124152&action=view
>  > >  > > >
>  > >  > > >
>  > >  > >
>  > >  > > It died in pci_mmcfg_read().  Greg, didn't a crash in there get fixed recently?
>  > >  >
>  > >  > Yes.  Can you try 2.6.16-rc2?  Is this a x86-64 machine?
>  > >
>  > > I can hit this on my dv8000 too. It's still there in 2.6.12-rc2-git3
>  > > I'm building a kernel with Randy's 'pause after printk' patch right now
>  > > to catch the top of the oops.  It's enormous.  Even with a 50 line display,
>  > > and x86-64s dual-line backtrace, it scrolls off the top.
>  > 
>  > Just be patient.  A boot can take a few minutes... ;)
> 
> It doesn't get that far.  What did bugger things up though was the NMI watchdog
> kicking in.  I've thrown a touch_nmi_watchdog in the delay, and kicked off another build
> hoping for a cleaner dump.
> 
> In the meantime, here's what I got..
> 
> http://people.redhat.com/davej/DSC00148.JPG

Andi, didn't your change for this function make it into Linus's tree?

thanks,

greg k-h
