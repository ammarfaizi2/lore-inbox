Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269325AbUIYNP2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269325AbUIYNP2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 09:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269323AbUIYNP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 09:15:28 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:40926 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S269322AbUIYNPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 09:15:12 -0400
Subject: Re: [RFC] put symbolic links between drivers and modules in the
	sysfs tree
From: James Bottomley <James.Bottomley@SteelEye.com>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: greg@kroah.com, Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <20040925073819.GT23987@parcelfarce.linux.theplanet.co.uk>
References: <1095701390.2016.34.camel@mulgrave> 
	<20040925073819.GT23987@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 25 Sep 2004 09:14:34 -0400
Message-Id: <1096118081.1715.3.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-09-25 at 03:38, viro@parcelfarce.linux.theplanet.co.uk
wrote:
> On Mon, Sep 20, 2004 at 01:29:44PM -0400, James Bottomley wrote:
> > This functionality is essential for us to work out which drivers are
> > supplied by which modules.  We use this in turn to work out which
> > modules are necessary to find the root device (and hence what
> > initrd/initramfs needs to insert).
> 
> So what will your userland code do when you run it on a system with
> non-modular kernel currently running?

Not put a module in the initial ramdisk, since it would be unnecessary. 
The only information the patch seeks to add is the linkage between
driver and module.  So you can work back from sysfs to know which
devices have which modules

> IOW, that's a fundamentally broken interface - you really want the same
> information regardless of modular vs. built-in.

Not really.  It you argue this about module *parameters*, I might agree,
but not about what driver goes with what module...if the driver is build
in, then the answer is a simple "none" and the link doesn't exist.

James


