Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269364AbUIYQsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269364AbUIYQsN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 12:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269362AbUIYQsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 12:48:13 -0400
Received: from mail.kroah.org ([69.55.234.183]:36552 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269217AbUIYQsK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 12:48:10 -0400
Date: Sat, 25 Sep 2004 09:46:21 -0700
From: Greg KH <greg@kroah.com>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [RFC] put symbolic links between drivers and modules in the sysfs tree
Message-ID: <20040925164621.GA9098@kroah.com>
References: <1095701390.2016.34.camel@mulgrave> <20040925073819.GT23987@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040925073819.GT23987@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 25, 2004 at 08:38:19AM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Mon, Sep 20, 2004 at 01:29:44PM -0400, James Bottomley wrote:
> > This functionality is essential for us to work out which drivers are
> > supplied by which modules.  We use this in turn to work out which
> > modules are necessary to find the root device (and hence what
> > initrd/initramfs needs to insert).
> 
> So what will your userland code do when you run it on a system with
> non-modular kernel currently running?
> 
> IOW, that's a fundamentally broken interface - you really want the same
> information regardless of modular vs. built-in.

I agree, and Rusty has some pending patches that provide that
information for all drivers built into the system.  When they are
merged, this symlink will be created for those also (with a bit of
tweaking, but it will happen.)

thanks,

greg k-h
