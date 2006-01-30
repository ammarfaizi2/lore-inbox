Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964946AbWA3USl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964946AbWA3USl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 15:18:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964945AbWA3USl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 15:18:41 -0500
Received: from ccerelbas02.cce.hp.com ([161.114.21.105]:16824 "EHLO
	ccerelbas02.cce.hp.com") by vger.kernel.org with ESMTP
	id S964943AbWA3USk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 15:18:40 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: FW: MSI-X on 2.6.15
Date: Mon, 30 Jan 2006 14:18:37 -0600
Message-ID: <D4CFB69C345C394284E4B78B876C1CF10B8AC292@cceexc23.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: FW: MSI-X on 2.6.15
Thread-Index: AcYl0L+Hwx9khCr/SyuEGiHXMJZoLQABvhJg
From: "Miller, Mike (OS Dev)" <Mike.Miller@hp.com>
To: "Mark Maule" <maule@sgi.com>, "Greg KH" <greg@kroah.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
       "Patterson, Andrew D (Linux R&D)" <andrew.patterson@hp.com>
X-OriginalArrivalTime: 30 Jan 2006 20:18:38.0190 (UTC) FILETIME=[5ABA60E0:01C625DA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Mark Maule [mailto:maule@sgi.com] 
> Sent: Monday, January 30, 2006 1:10 PM
> To: Greg KH
> Cc: Miller, Mike (OS Dev); linux-kernel@vger.kernel.org; 
> linux-scsi@vger.kernel.org; Patterson, Andrew D (Linux R&D)
> Subject: Re: FW: MSI-X on 2.6.15
> 
> As Ashok Raj has already responded, there was support for 
> APIC-based MSI[-X] on ia64 before my patches.  I personally 
> do not know if it worked or not, my suspicion is that it 
> didn't get much airtime due to MSI being off by default until 
> somewhat recently.
> 
> I believe MSI was working on zx1 after my patch, so I suspect 
> it worked there before my patch as well.  I can't speak to MSI-X.
> 
> Mike, is your driver capable of MSI (vs. MSI-X)?  As a 
> datapoint, could you try that?

The ASIC on this particular board is broken for MSI. I have a different
board that I can ship out along with a patch for MSI only. Also just
found out that this chipset is the follow on to the zx1.
I've had MSI work on zx1 based systems and PCI-X controllers. This is
the first time trying it with PCI-E and the new chipset.
The trace we captured looks normal though all the init stuff. The host
and controller talk to each other until we try to send the interrupt
message data. It goes to address 0 (so it says) and never returns.

mikem

> 
> Mark
> 
> On Mon, Jan 30, 2006 at 09:38:52AM -0800, Greg KH wrote:
> > On Mon, Jan 30, 2006 at 10:33:50AM -0600, Miller, Mike (OS 
> Dev) wrote:
> > > Greg KH,
> > > We have the same results on 2.6.15, the MSI-X table is 
> all zeroes. 
> > > See below. Any ideas of what to do do next? The driver works on 
> > > x86_64. Is there any thing extra I need to do on ia64?
> > 
> > ia64 didn't really have msi support before the latest -mm kernel, 
> > right Mark?
> > 
> > > Andrew, can you try 2.6.16-rc1 and/or the rc1-git4 kernels?
> > 
> > How about the -mm kernel?
> > 
> > thanks,
> > 
> > greg k-h
> 
