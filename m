Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262447AbUBXUe1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 15:34:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262446AbUBXUeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 15:34:17 -0500
Received: from lists.us.dell.com ([143.166.224.162]:50344 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S262443AbUBXUeE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 15:34:04 -0500
Date: Tue, 24 Feb 2004 14:33:58 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: "Mukker, Atul" <Atulm@lsil.com>, "'Paul Wagland'" <paul@wagland.net>,
       Matthew Wilcox <willy@debian.org>,
       "Bagalkote, Sreenivas" <sreenib@lsil.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH][BUGFIX] : megaraid patch for 2.10.1 (irq disable bug fix)
Message-ID: <20040224143358.A18783@lists.us.dell.com>
References: <0E3FA95632D6D047BA649F95DAB60E57033BC3D9@exa-atlanta.se.lsil.com> <1077635204.2152.16.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1077635204.2152.16.camel@mulgrave>; from James.Bottomley@steeleye.com on Tue, Feb 24, 2004 at 09:06:43AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 24, 2004 at 09:06:43AM -0600, James Bottomley wrote:
> On Tue, 2004-02-24 at 08:47, Mukker, Atul wrote:
> > We are in process of releasing a unified driver, which will natively support
> > the 2.4.x and 2.6.x kernels. 
> 
> I really don't think this will be such a good idea since you don't
> currently have a unified driver.  2.4 is approaching end of life as far
> as major driver updates go and the 2.6 APIs are quite a bit different. 
> You'll find it's a lot of work for a driver that will carry you at most
> six months before the distributions all switch to 2.6 and you find the
> 2.4 compatibility layer to be more of a hindrance than a help.

Distributions with 2.4 kernels will continue to live on for quite a
while. Red Hat Enterprise Linux has a 5-year support life, during
which we would expect LSI to release new hardware, and we would want
to be able to have that hardware work on that OS somehow.  The driver
source for 2.4 and 2.6 need not be identical, but there *will* be
ongoing maintenance for drivers on 2.4 kernels for the next several
years.  We're <6 months into the RHEL3 supported lifetime.

While I understand the concerns with keeping 2.4 and 2.6 drivers
separate, we can't ignore the maintenance for 2.4 drivers.  If that's
done on a 2.4-only stream, or cleanly with a joint 2.4/2.6 driver, I
don't care, but agree it's difficult to do a clean joint driver,
especially with all the SCSI subsystem changes.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
