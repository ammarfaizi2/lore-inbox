Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262352AbTJXQXD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 12:23:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262397AbTJXQXC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 12:23:02 -0400
Received: from mail0.lsil.com ([147.145.40.20]:22401 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S262352AbTJXQW6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 12:22:58 -0400
Message-Id: <0E3FA95632D6D047BA649F95DAB60E57035A9468@exa-atlanta.se.lsil.com>
From: "Moore, Eric Dean" <emoore@lsil.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH]  2.4.23-pre8 driver udpate for MPT Fusion (2.05.10)
Date: Fri, 24 Oct 2003 12:22:43 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James: I'm clear on the policy, however the 2.05.00.03
MPT driver in 2.6 kernel is *NOT* compatible with 
what is shipping in 2.4 kernel which is 2.05.05+ driver.  
The driver in 2.6 has had most of the backward compatibility
stripped out, such as Old Error Handling, and many other changes
to make it work with new kernel structures and functions, however
doesn't make it backward compatible to 2.4 kernel.

Our focus has been 2.4 kernel version of the driver as that is what
is shipping in all Linux distributions, and our customers have been
asking for RPM driver updates to the latest driver fix bugs and  
enhancements for their shipping systems out in the field.  One major
OEM player has requested we update Kernel.org as to reduce their
dependency on LSI for RPM driver updates. I wish that these updates
make their way into the 2.4 kernel.  I will begin porting these 
changes over the driver in 2.6 immediately.  Also one thing is 
that there have been change on Maintainership of this
driver from Pam Delaney to myself and Larry Stephens, so things
are about getting back to normal.

Eric


On Friday, October 24, 2003 9:21 AM, James Bottomley wrote:
> 
> On Fri, 2003-10-24 at 10:53, Moore, Eric Dean wrote:
> > Here's a patch for 2.4.23-pre8 kernel for MPT Fusion 
> driver, coming from LSI
> > Logic.
> > 
> > This patch is large, so I have placed it on the LSI ftp site at:
> > 
> ftp://ftp.lsil.com/HostAdapterDrivers/linux/Fusion-MPT/2.05.10
/mptlinux-2.05
> .10.patch
> 
> A new email address is setup for directing any MPT Fusion questions:
> mpt_linux_developer@lsil.com

The policy for driver updates into 2.4 is that they should be backports
from 2.6 (for things like mpt fusion that have similar drivers) so that
the newer driver gets into 2.6 first.  If you want to send the 2.6
patches, I can queue them up for when the "bugfix only" freeze is
relaxed.

James

