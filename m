Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932485AbWBGXkz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932485AbWBGXkz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 18:40:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932486AbWBGXky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 18:40:54 -0500
Received: from mx1.redhat.com ([66.187.233.31]:27809 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932485AbWBGXkx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 18:40:53 -0500
Date: Tue, 7 Feb 2006 18:40:43 -0500
From: Dave Jones <davej@redhat.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       Neal Becker <ndbecker2@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc1 panic on startup (acpi)
Message-ID: <20060207234043.GB17665@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"Randy.Dunlap" <rdunlap@xenotime.net>, Greg KH <greg@kroah.com>,
	Andrew Morton <akpm@osdl.org>, Neal Becker <ndbecker2@gmail.com>,
	linux-kernel@vger.kernel.org
References: <ds7cu3$9c0$1@sea.gmane.org> <ds7f17$gp7$1@sea.gmane.org> <20060207145913.714fec1c.akpm@osdl.org> <20060207231835.GA19648@kroah.com> <20060207233059.GA17665@redhat.com> <Pine.LNX.4.58.0602071534380.12589@shark.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0602071534380.12589@shark.he.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2006 at 03:35:31PM -0800, Randy.Dunlap wrote:
 > On Tue, 7 Feb 2006, Dave Jones wrote:
 > 
 > > On Tue, Feb 07, 2006 at 03:18:35PM -0800, Greg Kroah-Hartman wrote:
 > >  > On Tue, Feb 07, 2006 at 02:59:13PM -0800, Andrew Morton wrote:
 > >  > > Neal Becker <ndbecker2@gmail.com> wrote:
 > >  > > >
 > >  > > > Sorry, I meant 2.6.16-rc1 (not 2.6.12)
 > >  > > >
 > >  > > > Neal Becker wrote:
 > >  > > >
 > >  > > > > HP dv8000 notebook
 > >  > > > > 2.6.15 is fine, but 2.6.12-rc1 panics immediately on startup
 > >  > > > >
 > >  > > > > Here is a picture of some traceback
 > >  > > > > https://bugzilla.redhat.com/bugzilla/attachment.cgi?id=124152&action=view
 > >  > > >
 > >  > > >
 > >  > >
 > >  > > It died in pci_mmcfg_read().  Greg, didn't a crash in there get fixed recently?
 > >  >
 > >  > Yes.  Can you try 2.6.16-rc2?  Is this a x86-64 machine?
 > >
 > > I can hit this on my dv8000 too. It's still there in 2.6.12-rc2-git3
 > > I'm building a kernel with Randy's 'pause after printk' patch right now
 > > to catch the top of the oops.  It's enormous.  Even with a 50 line display,
 > > and x86-64s dual-line backtrace, it scrolls off the top.
 > 
 > Just be patient.  A boot can take a few minutes... ;)

It doesn't get that far.  What did bugger things up though was the NMI watchdog
kicking in.  I've thrown a touch_nmi_watchdog in the delay, and kicked off another build
hoping for a cleaner dump.

In the meantime, here's what I got..

http://people.redhat.com/davej/DSC00148.JPG


		Dave


