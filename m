Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261416AbUBYQq0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 11:46:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbUBYQq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 11:46:26 -0500
Received: from mail0.lsil.com ([147.145.40.20]:26790 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S261406AbUBYQqS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 11:46:18 -0500
Message-ID: <0E3FA95632D6D047BA649F95DAB60E5703EF97F9@exa-atlanta.se.lsil.com>
From: "Moore, Eric Dean" <Emoore@lsil.com>
To: joe.korty@ccur.com
Cc: James Bottomley <James.Bottomley@steeleye.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: RE: [BK PATCH] SCSI update for 2.6.3
Date: Wed, 25 Feb 2004 11:46:00 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't see the banner displayed by the driver
which would contain the FwRev, Ports, MaxQ, IRQ.
I suspect hw/fw issues with the card itself.

What happens when you attach drives to the card;
e.g. does the driver load then?

Can you upgrade your firmware to the latest.
http://www.lsilogic.com/downloads/selectDownload.do

Eric


On Wednesday, February 25, 2004 7:29 AM, Joe Korty wrote:
> 
> On Tue, Feb 24, 2004 at 07:23:32PM -0500, Moore, Eric Dean wrote:
> > Please try the attached patch.
> > Apply against the 2.6.3 kernel, which
> > comes with mpt fusion 3.00.02 driver.
> > 
> > I expect the same results from mptbase, however
> > mptscsih driver should load without the panic
> > in mptscsih_init.  Please send dmesg if there
> > still are issues.
> 
> Hi Eric,
>  My failing Opteron system (IDE disk, no SCSI disk) now boots 
> with your
> 2.6.3 Fusion patch in place.  My good Opteron system (SCSI 
> disk, no IDE
> disk) also continues to boot with this patch in place.
> 
> Thanks!
> Joe
> 
> PS: Although booting, the boot messages from the once-failing system
> indicate some rather unnerving failures.  Should I be concerned?
> 
> 
> Fusion MPT base driver 3.00.04
> Copyright (c) 1999-2003 LSI Logic Corporation
> mptbase: Initiating ioc0 bringup
> mptbase: ioc0: ERROR - Doorbell ACK timeout(2)!
> mptbase: ioc0: ERROR - Diagnostic reset FAILED! (102h)
> mptbase: ioc0 NOT READY WARNING!
> mptbase: WARNING - ioc0 did not initialize properly! (-1)
> mptbase: probe of 0000:02:0a.0 failed with error -1
> mptbase: Initiating ioc0 bringup
> mptbase: ioc0: ERROR - Doorbell ACK timeout(2)!
> mptbase: ioc0: ERROR - Diagnostic reset FAILED! (102h)
> mptbase: ioc0 NOT READY WARNING!
> mptbase: WARNING - ioc0 did not initialize properly! (-1)
> mptbase: probe of 0000:02:0a.1 failed with error -1
> Fusion MPT SCSI Host driver 3.00.04
> 
