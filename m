Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261599AbVGYCt1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261599AbVGYCt1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 22:49:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261601AbVGYCt1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 22:49:27 -0400
Received: from wproxy.gmail.com ([64.233.184.193]:51745 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261599AbVGYCtZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 22:49:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZuDtIr/cRTXxJo7HX1weY3ft6iwmcI4qmhFrCyAJORKlk9m85ICV2gqIsf0sn4yGbhZjGdKfxyHXFUGzdrxfePRnTAUSRPA/MoY3vCQ0lU27uXK7AyrlSY4HIZRkLBdaVoIrZP85HRhojdk7Rl25nu1MADItM+Z4fpiBQnHxxSo=
Message-ID: <b115cb5f0507241949da02aa7@mail.gmail.com>
Date: Mon, 25 Jul 2005 11:49:22 +0900
From: Rajat Jain <rajat.noida.india@gmail.com>
Reply-To: Rajat Jain <rajat.noida.india@gmail.com>
To: rajat.noida.india@gmail.com, greg@kroah.com, linux-kernel@vger.kernel.org,
       linux-newbie@vger.kernel.org
Subject: Re: Re: Problem while inserting pciehp (PCI Express Hot-plug) driver
Cc: acpi-devel@lists.sourceforge.net,
       linux-hotplug-devel@lists.sourceforge.net, dkumar@noida.hcltech.com
In-Reply-To: <20050725021747.67869.qmail@web34405.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050725021747.67869.qmail@web34405.mail.mud.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Jul 12, 2005 at 06:01:22PM +0900, Rajat Jain
> wrote:
>
> > Hi,
> > 
> > I'm trying to use the PCI Express Hot-Plug Controller driver
> > (pciehp.ko) with Kernel 2.6 so that I can get hot-plug events 
> > whenever I add a card to my PCI Express slot.
> > 
> > I built the driver as a module, and am trying to load it 
> > manually using modprobe. However, when trying to insert,
> > I'm getting the following error:
> >
> > pciehp: acpi_pciehprm:\_SB.PCI0 _OSC fails=0x5
> > pciehp: Both _OSC and OSHP methods do not exist
> > FATAL: Error inserting pciehp
> >
> > (/lib/modules/2.6.9-5.18AXcustom-hotplug/kernel/drivers/pci/hotplug/pciehp.ko):
> > No such device
> >

> --- Greg KH <greg@kroah.com> wrote:
> Your bios does not support pci express hotplug.  Are
> you sure you have pci express hotplug hardware in your
> system?  If so, contact your bios vendor to get an 
> updated version.
> 
> Good luck,
> 
>  greg k-h

Thanks for replying Greg. I checked again, I have the hardware in my
system. I asked the vendor for bios update, but he says mine is the
latest version.

I downloaded the Intel "iasl" compiler
(http://developer.intel.com/technology/iapc/acpi/downloads.htm),  and
used it to decompile "/proc/acpi/dsdt" file (in AML) to its equivalent
ACPI source code. I could not find the _OSC and OSHP control methods
there. Is this information sufficient enough to deduce that I need a
BIOS update? And the hardware is OK but the problem is with the bios?

Just out of curosity, I would appreciate if you could provide me
pointers to OSHP and _OSC methods. What exactly do they mean? Does
every hardware containing a hot-plug controller necessarily has to
implement them both? I checked with ACPI Specs but it contains no
refrence to "OSHP" method.

Any pointers are more than appreciated,

TIA,

Rajat
