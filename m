Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262180AbVAYXmZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262180AbVAYXmZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 18:42:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262219AbVAYXlO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 18:41:14 -0500
Received: from mail0.lsil.com ([147.145.40.20]:7350 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S262180AbVAYXiJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 18:38:09 -0500
Message-ID: <0E3FA95632D6D047BA649F95DAB60E5705B837C3@exa-atlanta>
From: "Mukker, Atul" <Atulm@lsil.com>
To: "'Patrick Mansfield'" <patmans@us.ibm.com>,
       "Mukker, Atul" <Atulm@lsil.com>
Cc: "'James Bottomley'" <James.Bottomley@SteelEye.com>,
       "'Linux Kernel'" <linux-kernel@vger.kernel.org>,
       "'SCSI Mailing List'" <linux-scsi@vger.kernel.org>
Subject: RE: How to add/drop SCSI drives from within the driver?
Date: Tue, 25 Jan 2005 18:37:49 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the suggestion. After more exploration, looks like different
distribution have different implementations for /sbin/hotplug. This may
aggravate the issue for applications. For now, we will stick with a wait and
watch after bus scan :-(

Will probe the linux-hotplug-devel@lists.sourceforge.net list for more
pointers

Thanks

===========================
Atul Mukker
Architect, Drivers and BIOS
LSI Logic Corporation


> -----Original Message-----
> From: Patrick Mansfield [mailto:patmans@us.ibm.com] 
> Sent: Tuesday, January 25, 2005 11:52 AM
> To: Mukker, Atul
> Cc: 'James Bottomley'; Linux Kernel; SCSI Mailing List
> Subject: Re: How to add/drop SCSI drives from within the driver?
> 
> Atul -
> 
> On Tue, Jan 25, 2005 at 11:27:36AM -0500, Mukker, Atul wrote:
> > After writing the "- - -" to the scan attribute, the management 
> > applications assume the udev has created the relevant 
> entries in the 
> > /dev directly and try to use the devices _immediately_ and 
> fail to see 
> > the devices
> > 
> > Is there a hotplug event which would tell the management 
> applications 
> > that the device nodes have actually been created now and 
> ready to be used?
> 
> Read the udev man page section, the part right before 
> "FILES". Try putting a script under /etc/dev.d/default/*.dev. 
> Then you can get more specific with an /etc/dev.d/scsi/*.dev 
> script or something else.
> 
> I just tried something simple but did not get it working.
> 
> Try linux-hotplug-devel@lists.sourceforge.net list for help.
> 
> -- Patrick Mansfield
> 
