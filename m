Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261945AbVBPIaw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261945AbVBPIaw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 03:30:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261960AbVBPIaw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 03:30:52 -0500
Received: from mail1.upco.es ([130.206.70.227]:38101 "EHLO mail1.upco.es")
	by vger.kernel.org with ESMTP id S261945AbVBPIan (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 03:30:43 -0500
Date: Wed, 16 Feb 2005 09:30:40 +0100
From: Romano Giannetti <romanol@upco.es>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [ACPI] Re: Call for help: list of machines with working S3
Message-ID: <20050216083040.GB22816@pern.dea.icai.upco.es>
Reply-To: romano@dea.icai.upco.es
Mail-Followup-To: Romano Giannetti <romanol@upco.es>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20050214211105.GA12808@elf.ucw.cz> <1108500194.12031.21.camel@elrond.flymine.org> <42126506.8020407@colitti.com> <200502160141.11633.alistair@devzero.co.uk> <20050216015418.GC13753@elf.ucw.cz> <1108522024.3712.44.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1108522024.3712.44.camel@desktop.cunningham.myip.net.au>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2005 at 01:47:04PM +1100, Nigel Cunningham wrote:
> Hi.
> 
> On Wed, 2005-02-16 at 12:54, Pavel Machek wrote:
> > > Also, is USB suspend/resume supposed to work? My brief trials involved 
> > > modprobing the USB HCD modules, which still allowed me to suspend/resume, but 
> > > my USB mouse was non-functional on resume.
> > 
> > Yes, it seems to work quite okay. You may need to unplug/replug
> > devices after resume, but it should be basically ok.
> 
> We still have plenty of people for whom the best option is to build as
> modules, unload prior to suspending and reload afterwards. It seems to
> depend on what type your controller is: I do this for uhci_hcd and get
> fully functional usb post resume (-rc4).
> 

I have no problem for USB "stateless" devices. The real problem is when you
do a suspend/resume cycle with a *mounted* usb stick or disk. Upon resume,
the device is found and associated with a diffent block device than before,
and the previous mount point is stuck forever (well, almost forever).
Sometime umount -f works, sometime no, but it is quite irritating that I
need to reboot to have the "good old /dev/sda1" which is in the fstab
working. 

Romano 

-- 
Romano Giannetti             -  Univ. Pontificia Comillas (Madrid, Spain)
Electronic Engineer - phone +34 915 422 800 ext 2416  fax +34 915 596 569
