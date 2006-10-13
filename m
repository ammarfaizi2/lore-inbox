Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750905AbWJMPCc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905AbWJMPCc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 11:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbWJMPCc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 11:02:32 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:29348 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750905AbWJMPCb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 11:02:31 -0400
Subject: Re: [linux-pm] Bug in PCI core
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Adam Belay <abelay@MIT.EDU>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Greg KH <greg@kroah.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.0610131024340.6460-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.0610131024340.6460-100000@iolanthe.rowland.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 13 Oct 2006 16:26:26 +0100
Message-Id: <1160753187.25218.52.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-10-13 am 10:29 -0400, ysgrifennodd Alan Stern:
> > I'd like to propose that we have the pci config sysfs interface return
> > -EIO  when it's blocked (e.g. active BIST or D3cold).  This accurately
> > reflects the state of the device to userspace, reduces complexity, and
> > could potentially save some memory per PCI device instance.
> 
> Could you resubmit your old patches and include a corresponding fix for 
> this access problem?

And then you can fix the applications it breaks, like the X server which
does actually want to know where all the devices are located in PCI
space.

Alan
