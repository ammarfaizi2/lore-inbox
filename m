Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422651AbWJaHti@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422651AbWJaHti (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 02:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161616AbWJaHth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 02:49:37 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:12192 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1161612AbWJaHtf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 02:49:35 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.19-rc3-mm1 - udev doesn't work (was: ATI SATA controller not detected)
Date: Tue, 31 Oct 2006 08:48:01 +0100
User-Agent: KMail/1.9.1
Cc: Greg KH <greg@kroah.com>, Dave Jones <davej@redhat.com>,
       linux-kernel@vger.kernel.org, Jeff Garzik <jeff@garzik.org>,
       Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org
References: <20061029160002.29bb2ea1.akpm@osdl.org> <200610310829.31554.rjw@sisk.pl> <20061030234008.51da7d9a.akpm@osdl.org>
In-Reply-To: <20061030234008.51da7d9a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610310848.02739.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 31 October 2006 08:40, Andrew Morton wrote:
> On Tue, 31 Oct 2006 08:29:28 +0100
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > [Resending due to a network problem on my side.]
> > 
> > On Monday, 30 October 2006 21:57, Greg KH wrote:
> > > On Mon, Oct 30, 2006 at 09:48:33PM +0100, Rafael J. Wysocki wrote:
> > > > On Monday, 30 October 2006 21:22, Greg KH wrote:
> > > > > On Mon, Oct 30, 2006 at 09:15:37PM +0100, Rafael J. Wysocki wrote:
> > > > > > Sorry, I was wrong.
> > > > > > 
> > > > > > The controller _is_ detected and handled properly, but udev is apparently
> > > > > > unable to create the special device files for SATA drives/partitions even
> > > > > > though CONFIG_SYSFS_DEPRECATED is set.
> > > > > 
> > > > > This config option should not affect the block device sysfs files at all
> > > > > at this point in time.
> > > > > 
> > > > > What does 'tree /sys/block/' show?
> > > > 
> > > > I can't run 'tree', but 'ls' works somehow (can't mount the root fs).  The
> > > > block device sysfs files seem to be present
> > > 
> > > If they are there, then udev should work just fine.
> > > 
> > > > > If the files show up there properly, udev should handle them just fine.
> > > > 
> > > > It doesn't.
> > > > 
> > > > Well, I can binary search for the offending patch if that helps.
> > > 
> > > That would be very helpful, thanks.
> > 
> > It's one of these:
> > 
> > git-acpi.patch
> > git-acpi-fixup.patch
> > git-acpi-more-build-fixes.patch
> > 
> 
> You might need to resend the original report so the acpi guys can see it.

Okay, I will.

> Meanwhile, I'll have to drop the acpi tree.

Well, I'd prefer to find the offending commit within the tree, as the majority
of changes look pretty innocent.  Are the commits available somewhere as
individual patches?
