Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264772AbUEKRpI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264772AbUEKRpI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 13:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264805AbUEKRpI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 13:45:08 -0400
Received: from 209-166-240-202.cust.walrus.com ([209.166.240.202]:52179 "EHLO
	ti41.telemetry-investments.com") by vger.kernel.org with ESMTP
	id S264772AbUEKRoz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 13:44:55 -0400
Date: Tue, 11 May 2004 13:44:54 -0400
From: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
To: Len Brown <len.brown@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Long boot delay with 2.6 on Tyan S2464 Dual Athlon
Message-ID: <20040511174454.GD27033@ti64.telemetry-investments.com>
Mail-Followup-To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
	Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org
References: <A6974D8E5F98D511BB910002A50A6647615FB091@hdsmsx403.hd.intel.com> <1084294867.12359.109.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1084294867.12359.109.camel@dhcppc4>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2004 at 01:01:07PM -0400, Len Brown wrote:
> On Tue, 2004-05-11 at 10:35, Bill Rugolsky Jr. wrote:
> > When booting 2.6 on a Tyan S2464 dual Athlon, the kernel pauses
> > for about two minutes before the first boot message appears.
> > This does not occur with 2.4 kernels.
> 
> $0.05 says it is related to SCSI
 
> BTW. you got the latest BIOS on this box?
 
Yes, 2.14 from the Tyan site, released a a few weeks ago.

> >   Vendor: 3ware     Model: Logical Disk 3    Rev: 1.2 
> >   Type:   Direct-Access                      ANSI SCSI revision: 00
> > SCSI device sdd: 156301488 512-byte hdwr sectors (80026 MB)
> > SCSI device sdd: drive cache: write through
> >  sdd:
> > Attached scsi disk sdd at scsi2, channel 0, id 3, lun 0
> 
> if you slap an IDE drive on this box and disable the SCSI does the delay
> go away?

The box is all IDE; the above messages are from the 3ware controller,
which emulates a SCSI device.

There is nothing hanging on the on-board Adaptec SCSI controller.
The BIOS doesn't provide a setting to disable it, though I think
there is a jumper on the motherboard.

Unfortunately, I have to slap this box into production later today,
so I can't experiment much more.  But we have a half-dozen of these
motherboards in the office running Solaris 8 or FC1, and those are
slated for eventual upgrade to a 2.6 kernel, so I'll try to take one
out of production for a bit of experimentation.

Thanks.

	Bill Rugolsky
