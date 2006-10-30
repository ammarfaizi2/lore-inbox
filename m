Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422628AbWJ3URM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422628AbWJ3URM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 15:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422626AbWJ3URM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 15:17:12 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:46234 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1030591AbWJ3URL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 15:17:11 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Greg KH <greg@kroah.com>
Subject: Re: 2.6.19-rc3-mm1 - udev doesn't work (was: ATI SATA controller not detected)
Date: Mon, 30 Oct 2006 21:15:37 +0100
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, Dave Jones <davej@redhat.com>,
       linux-kernel@vger.kernel.org, Jeff Garzik <jeff@garzik.org>
References: <20061029160002.29bb2ea1.akpm@osdl.org> <200610302055.21305.rjw@sisk.pl> <20061030200414.GA938@kroah.com>
In-Reply-To: <20061030200414.GA938@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610302115.37688.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 30 October 2006 21:04, Greg KH wrote:
> On Mon, Oct 30, 2006 at 08:55:18PM +0100, Rafael J. Wysocki wrote:
> > Hi,
> > 
> > On Monday, 30 October 2006 06:16, Andrew Morton wrote:
> > > On Sun, 29 Oct 2006 19:54:30 -0800
> > > Greg KH <greg@kroah.com> wrote:
> > > 
> > > > On Sun, Oct 29, 2006 at 09:50:00PM -0500, Dave Jones wrote:
> > > > > On Sun, Oct 29, 2006 at 04:00:02PM -0800, Andrew Morton wrote:
> > > > > 
> > > > >  > - For some reason Greg has resurrected the patches which detect whether
> > > > >  >   you're using old versions of udev and if so, punish you for it.
> > > > >  > 
> > > > >  >   If weird stuff happens, try upgrading udev.
> > > > > 
> > > > > Where "old" is how old exactly ?
> > > > 
> > > > As per the Kconfig help entry, any version of udev released before 2006
> > > > will probably have problems with the new config option.  So follow the
> > > > text and enable the option if you are running an old version of udev and
> > > > you should be fine.
> > > 
> > > <hunts>
> > > 
> > > Greg is referring to CONFIG_SYSFS_DEPRECATED.  I didn't know it existed. 
> > > If I had known I'd have saved maybe an hour and I perhaps wouldn't have had
> > > to revert gregkh-driver-tty-device.patch
> > > 
> > > What mailing list was this discussed and reviewed on?
> > > 
> > > The option should default to "y".
> > 
> > I have this one set, but the kernel apparently fails to find the ATI SATA
> > controller:
[--snip--]
> 
> This has nothing to do with the CONFIG_SYSFS_DEPRECATED configuration
> option.  Do you have CONFIG_PCI_MULTITHREAD_PROBE also enabled?  If so,
> please disable it, some SATA drivers do not like it very much just yet.

Sorry, I was wrong.

The controller _is_ detected and handled properly, but udev is apparently
unable to create the special device files for SATA drives/partitions even
though CONFIG_SYSFS_DEPRECATED is set.

The system is SUSE 10.1 (udev-085-30.15).

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
