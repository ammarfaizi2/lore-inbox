Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261669AbTEYJM7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 05:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261566AbTEYJM7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 05:12:59 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:38528 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S261564AbTEYJM5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 05:12:57 -0400
Date: Sun, 25 May 2003 11:32:09 +0100
From: john@grabjohn.com
Message-Id: <200305251032.h4PAW9hK000616@81-2-122-30.bradfords.org.uk>
To: john@grabjohn.com, zwane@linuxpower.ca
Subject: Re: [RFR] a new SCSI driver
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Thinking ahead, by the 2.8 timescale, PATA could well be legacy hardware 
> > which could be supported only by an 'old' IDE driver, much like we already
> > have at the moment - I.E. we could remove the current 'old' IDE driver
> > sometime during the 2.7 timescale, and support SATA only via the SCSI layer.
> >
> > This would save having any more than the minimum SATA code going in to the
> > existing IDE driver, and consolidate work in the future.        

> PATA is in _way_ too many current boxes, those computers will continue to 
> run for a very long time from now.

That would be the reason for the old IDE driver.  PATA will still be in use, but
it won't be mainstream.                   

> In 10 years what is technologically obselete will still be very capable.

Of course it will - the same is true today.  That doesn't mean it will be in      
mainstream use.  The systems that do use PATA will benefit from having it
supported in a smaller footprint driver.  It will be analogous to using the 
current 'old' IDE driver on a 4 MB 386 today.  

> > The bloat of the SCSI layer in embedded machines might be a concern, but
> > then again, maybe it won't - how many embedded machines are going to be
> > using SATA, anyway?  Once we move away from spinning disks towards solid
> > state storage, (which is going to happen first in the embedded market),
> > will we want to use *ATA or SCSI at all?

> You're confusing media and transport.

No, I'm not.       

20-40 GB of RAM will be very cheap in a few years time.  A lot of the devices
using disks today will be using direct memory mapped RAM as their main storage
in the near future.  You don't need *ATA for that...

John.
