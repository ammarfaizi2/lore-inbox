Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261417AbVEBQpx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261417AbVEBQpx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 12:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261455AbVEBQoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 12:44:21 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:60387 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261417AbVEBQ2C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 12:28:02 -0400
Subject: RE: LSI Logic's Ultra320 320-4X RAID adapter
From: Kallol Biswas <kallol@nucleodyne.com>
Reply-To: kallol@nucleodyne.com
To: "Ju, Seokmann" <sju@lsil.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E5703662836@exa-atlanta>
References: <0E3FA95632D6D047BA649F95DAB60E5703662836@exa-atlanta>
Content-Type: text/plain
Organization: NucleoDyne Systems Inc.
Message-Id: <1115050656.31377.4.camel@driver>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 02 May 2005 09:17:37 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The system's PCI bridge is broken,  MEM Mapped IO does not work.

Only we can use IO mapped IO to access PCI devices(inb, outb) those are
behind the bridge.

I am looking for a LSI mega raid adapter (SCSI, SATA or SAS) that
supports IO mapped IO and has a  linux driver for it.



On Mon, 2005-05-02 at 05:56, Ju, Seokmann wrote:
> On Saturday, April 30, 2005 9:02 PM, Kallol wrote:
> > The memory space PCI register access can not be used.
> I'm not sure what this means. Can you please add more details on it?
> 
> > Question #1: Does 320-4X support IO Space device register access?
> No, the controller does not support IO mapped I/O.
> 
> > Question #2: Do we have a linux driver for it that supports 
> > IO ports also?
> Yes, to support LSI MegaRAID controllers (typically old controllers), driver
> on the 2.4 kernel supports I/O mapped I/O.
> 
> Thank you.
> 
> Seokmann
> LSI Logic Corporation.
> 
> > -----Original Message-----
> > From: kallol@nucleodyne.com [mailto:kallol@nucleodyne.com] 
> > Sent: Saturday, April 30, 2005 9:02 PM
> > To: linux-scsi@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: LSI Logic's Ultra320 320-4X RAID adapter
> > 
> > 
> > 
> > Hello,
> >       We have been evaluting different IO adapters for a 
> > storage system vendor.
> > 
> > LSI logic's 320-4X RAID controller seems to be a good choice.
> > 
> > There is an issue with the system on which we are measuring 
> > performance.
> > The memory space PCI register access can not be used.
> > 
> > Question #1: Does 320-4X support IO Space device register access?
> > Question #2: Do we have a linux driver for it that supports 
> > IO ports also?
> > 
> > The megaraid linux driver seems to check the BAR0, if it is 
> > memory bar then mem
> > space is used otherwise IO space.
> > 
> > May be the adapter supporting memory space also support IO 
> > space access.
> > 
> > 
> > Thanks,
> > Kallol
> > -
> > To unsubscribe from this list: send the line "unsubscribe 
> > linux-scsi" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

