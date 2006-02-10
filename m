Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750877AbWBJAcu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750877AbWBJAcu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 19:32:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750880AbWBJAct
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 19:32:49 -0500
Received: from animx.eu.org ([216.98.75.249]:44431 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S1750877AbWBJAcs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 19:32:48 -0500
Date: Thu, 9 Feb 2006 19:36:14 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: Alex Davis <alex14641@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Let's get rid of  ide-scsi
Message-ID: <20060210003614.GA26114@animx.eu.org>
Mail-Followup-To: Alex Davis <alex14641@yahoo.com>,
	linux-kernel@vger.kernel.org
References: <20060210002148.37683.qmail@web50201.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060210002148.37683.qmail@web50201.mail.yahoo.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Davis wrote:
> I think we should get rid of ide-scsi.
> 
> Reasons:
> 1) It's broken.
> 2) It's unmaintained.
> 3) It's unneeded.
> 
> I'll submit a patch if people agree.
> 
> I code, therefore I am

I personally do not agree with this.  I worked on at boot disk(floppy) which
contained the kernel and modules to find a cdrom (or usb disk) and use it as
my 2nd stage.  If I had to use ide-cd, I would not beable to do my first
stage loader on a single floppy (I support ide and scsi cdroms via sr-mod).

ide-cd.ko is > than sr-mod.ko + ide-scsi.ko

I am aware that scsi_mod.ko is larger than those 3 combined and I still need
it regardless for usb.

My personal vote would be to drop the entire ide subsystem which would thus
drop ide-scsi.  The SCSI layer has been a general block device layer for
more than true scsi devices.  USB, Firewire, and SATA use the scsi layer. 
And as I understand it, libata is starting to handle PATA devices.  Once it
can handle PATA fine, the ide code would pretty much be useless.

I am also against the seperate USB block layer, I personally saw no use in
it.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
 Got Gas???
