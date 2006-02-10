Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751106AbWBJMEi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbWBJMEi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 07:04:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbWBJMEh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 07:04:37 -0500
Received: from animx.eu.org ([216.98.75.249]:47784 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S1751106AbWBJMEh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 07:04:37 -0500
Date: Fri, 10 Feb 2006 07:08:02 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: Alex Davis <alex14641@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Let's get rid of  ide-scsi
Message-ID: <20060210120801.GB27814@animx.eu.org>
Mail-Followup-To: Alex Davis <alex14641@yahoo.com>,
	linux-kernel@vger.kernel.org
References: <20060210003614.GA26114@animx.eu.org> <20060210060333.8628.qmail@web50212.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060210060333.8628.qmail@web50212.mail.yahoo.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Davis wrote:
> --- Wakko Warner <wakko@animx.eu.org> wrote:
> > I personally do not agree with this.  I worked on at boot disk(floppy) which
> > contained the kernel and modules to find a cdrom (or usb disk) and use it as
> > my 2nd stage.  If I had to use ide-cd, I would not beable to do my first
> > stage loader on a single floppy (I support ide and scsi cdroms via sr-mod).
> > 
> > ide-cd.ko is > than sr-mod.ko + ide-scsi.ko
> > 
> > I am aware that scsi_mod.ko is larger than those 3 combined and I still need
> > it regardless for usb.
> > 
> > My personal vote would be to drop the entire ide subsystem which would thus
> > drop ide-scsi.  The SCSI layer has been a general block device layer for
> > more than true scsi devices.  USB, Firewire, and SATA use the scsi layer. 
> > And as I understand it, libata is starting to handle PATA devices.  Once it
> > can handle PATA fine, the ide code would pretty much be useless.
> > 
> > I am also against the seperate USB block layer, I personally saw no use in
> > it.
> > 
> > -- 
> >  Lab tests show that use of micro$oft causes cancer in lab animals
> >  Got Gas???
> > 
> 
> Wakko:
> 
> Modules can be compressed: On a 2.6.15 kernel doing a 'gzip -9 idecd.ko' reduced its size
> from 43616 bytes to 19234 bytes. The only additional step is modifying 'modules.dep' and
> changing idecd.ko to idecd.ko.gz. You now have a fully functional ide cdrom driver.

This I did not know.  I'm not sure if it will really matter or not.  The
initramfs is already gzip -9'd.  I have a list of modules that are required
for stage 1 which pulls in the dependancies for those modules.  It does
currently fit on a single floppy.  I'm using a upx compressed kernel, a gzip
-9'd initramfs, kernel is compiled with -Os and I'm using a -Os compiled
busybox statically compiled with uclibc.  When it's all said and done, I
have less than 10kb available on a floppy.  I thought it was quite an
acomplishment getting all that one 1 floppy.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
 Got Gas???
