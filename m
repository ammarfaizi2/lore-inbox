Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262854AbTJaBAP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 20:00:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262813AbTJaBAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 20:00:15 -0500
Received: from mail.kroah.org ([65.200.24.183]:34205 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262802AbTJaBAK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 20:00:10 -0500
Date: Thu, 30 Oct 2003 16:58:54 -0800
From: Greg KH <greg@kroah.com>
To: David Dodge <dododge@smart.net>
Cc: "Guo, Min" <min.guo@intel.com>, Steven Dake <sdake@mvista.com>,
       Lars Marowsky-Bree <lmb@suse.de>, Mark Bellon <mbellon@mvista.com>,
       linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-hotplug-devel@lists.sourceforge.net, cgl_discussion@osdl.org,
       "Ling, Xiaofeng" <xiaofeng.ling@intel.com>
Subject: Re: ANNOUNCE: User-space System Device Enumation (uSDE)
Message-ID: <20031031005854.GC4906@kroah.com>
References: <200310310045.TAA04280@smarty.smart.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310310045.TAA04280@smarty.smart.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 30, 2003 at 07:45:08PM -0500, David Dodge wrote:
> Greg KH writes:
> > On Wed, Oct 29, 2003 at 01:12:26PM +0800, Guo, Min wrote:
> > > 2.For non-hotplug device
> [...]
> > >  uDEV:
> > >          not deal with it
> > 
> > See Robert Love's very simple script to populate stuff from sysfs.  It
> > can run from initscript just like SDE.  But in the end, udev will end up
> > in initramfs and we will not need to do this.
> 
> So the intent is to have compiled-in drivers for already-attached
> devices (framebuffer, system disks, loop, whatever) generate calls to
> /sbin/hotplug within initramfs?
> 
> Mainly I'm asking because I did try putting a hotplug script into an
> initramfs a few weeks ago (using -test7), and it didn't appear to be
> invoked for e.g. the VESA framebuffer. So I want to make sure this is a
> "future" capability and not something that should have worked :-)

This is something that should have worked for you today, /sbin/hotplug
does get called during early boot, before init is started up.

thanks,

greg k-h
