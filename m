Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbUBYTHv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 14:07:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261732AbUBYTGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 14:06:50 -0500
Received: from linux.us.dell.com ([143.166.224.162]:3301 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S262430AbUBYTEI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 14:04:08 -0500
Date: Wed, 25 Feb 2004 13:03:28 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: Matthew Wilcox <willy@debian.org>
Cc: "'Christoph Hellwig'" <hch@infradead.org>, "Mukker, Atul" <Atulm@lsil.com>,
       "'Arjan van de Ven'" <arjanv@redhat.com>,
       "'James Bottomley'" <James.Bottomley@SteelEye.com>,
       "'Paul Wagland'" <paul@wagland.net>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>
Subject: Re: [SUBJECT CHANGE]: megaraid unified driver version 2.20.0.0-alpha1
Message-ID: <20040225130328.B14838@lists.us.dell.com>
References: <0E3FA95632D6D047BA649F95DAB60E57033BC3E2@exa-atlanta.se.lsil.com> <20040225131640.A3966@infradead.org> <20040225112839.A14838@lists.us.dell.com> <20040225173540.GB25779@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040225173540.GB25779@parcelfarce.linux.theplanet.co.uk>; from willy@debian.org on Wed, Feb 25, 2004 at 05:35:40PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 25, 2004 at 05:35:40PM +0000, Matthew Wilcox wrote:
> On Wed, Feb 25, 2004 at 11:28:39AM -0600, Matt Domsch wrote:
> > The list of PCI devices should be ordered in two buckets: ROMBs first,
> > then add in cards; secondarily, oldest to newest.  We do this with
> > aacraid today.
> 
> In 2.4, you can do what you like.  The list of PCI devices is in PCI
> bus number order, and that's the order you get when you use the hotplug
> interfaces.

Ahh, yes, of course.  

> Yes, this is a painful customer-visible change, but if they use scsi
> discs, they must already be used to devices changing name at random.

Well, to be fair, most people count on it not changing, i.e. it is
deterministic at least, such that if you don't change hardware or add
logical drives, you won't see any changes between boots.  For most
users, file system labels serve quite well to keep things consistent.
For swap, raw devices, and the like, devlabel or udev are used, but at
least devlabel (sorry Greg, I haven't played with udev too much yet)
uses SCSI inquiry page 83 or 80 data if it's there, which megaraid
doesn't provide.

For the install scenario, EDD (which megaraid *does* provide) will
suffice, but I need to get distro installers to start using it. ;-)
Oh, and get it working on x86-64.  That should be easy, soon as I have
access to such a system for a few days.


-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
