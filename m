Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751394AbWFZCLT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394AbWFZCLT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 22:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751381AbWFZCLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 22:11:19 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:5067 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751374AbWFZCLR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 22:11:17 -0400
Date: Mon, 26 Jun 2006 07:41:00 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: vgoyal@in.ibm.com, Andrew Morton <akpm@osdl.org>, Neela.Kolli@engenio.com,
       linux-scsi@vger.kernel.org, mike.miller@hp.com, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [RFC] [PATCH 2/2] kdump: cciss driver initialization issue fix
Message-ID: <20060626021100.GA12824@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20060623210121.GA18384@in.ibm.com> <20060623210424.GB18384@in.ibm.com> <20060623235553.2892f21a.akpm@osdl.org> <20060624111954.GA7313@in.ibm.com> <20060624043046.4e4985be.akpm@osdl.org> <20060624120836.GB7313@in.ibm.com> <m1veqqxyrb.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1veqqxyrb.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 24, 2006 at 11:13:44AM -0600, Eric W. Biederman wrote:
> Vivek Goyal <vgoyal@in.ibm.com> writes:
> 
> > On Sat, Jun 24, 2006 at 04:30:46AM -0700, Andrew Morton wrote:
> >
> >> > Or is there a generic way to handle these situations? Fixing them driver
> >> > by driver is a long painful process. 
> >> 
> >> Some generic way of whacking a PCI device via the standard PCI registers? 
> >> Not that I know of.
> >
> > Somebody hinted that think of PCI bus reset. But I think PCI bus reset will
> > require firware/BIOS to export a hook to software to so initiate PCI bus
> > reset and I don't think many platforms do that. Infact I am not even aware
> > of one platform who does that.
> 
> Not all pci busses support it but there is a standard pci bus reset bit
> in pci bridges.
> 
> I don't know if it would help but it might make sense to have a config
> option that can be used to mark drivers that are known to have problems,
> in these scenarios.
> 
> CONFIG_BRITTLE_INIT perhaps?
> 
> It would at least make it easier for people to see which drivers
> they don't want to use, and give people some incentive to fix things.
> 

Vivek, 

I think having something as Eric suggested instead of crashboot= is better.
We can hve this config option set for kernel like dump capture
kernel. (CONFIG_CRASH_DUMP=y). This should save some bytes on already longish
kdump kernel boot paramenters.

Thanks
Maneesh
