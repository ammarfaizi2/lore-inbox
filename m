Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964873AbWFZNfh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964873AbWFZNfh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 09:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964847AbWFZNfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 09:35:37 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:23008 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S964817AbWFZNfg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 09:35:36 -0400
Date: Mon, 26 Jun 2006 09:35:04 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Maneesh Soni <maneesh@in.ibm.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@osdl.org>,
       Neela.Kolli@engenio.com, linux-scsi@vger.kernel.org, mike.miller@hp.com,
       fastboot@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [RFC] [PATCH 2/2] kdump: cciss driver initialization issue fix
Message-ID: <20060626133504.GA8985@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20060623210121.GA18384@in.ibm.com> <20060623210424.GB18384@in.ibm.com> <20060623235553.2892f21a.akpm@osdl.org> <20060624111954.GA7313@in.ibm.com> <20060624043046.4e4985be.akpm@osdl.org> <20060624120836.GB7313@in.ibm.com> <m1veqqxyrb.fsf@ebiederm.dsl.xmission.com> <20060626021100.GA12824@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060626021100.GA12824@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2006 at 07:41:00AM +0530, Maneesh Soni wrote:
> On Sat, Jun 24, 2006 at 11:13:44AM -0600, Eric W. Biederman wrote:
> > Vivek Goyal <vgoyal@in.ibm.com> writes:
> > 
> > > On Sat, Jun 24, 2006 at 04:30:46AM -0700, Andrew Morton wrote:
> > >
> > >> > Or is there a generic way to handle these situations? Fixing them driver
> > >> > by driver is a long painful process. 
> > >> 
> > >> Some generic way of whacking a PCI device via the standard PCI registers? 
> > >> Not that I know of.
> > >
> > > Somebody hinted that think of PCI bus reset. But I think PCI bus reset will
> > > require firware/BIOS to export a hook to software to so initiate PCI bus
> > > reset and I don't think many platforms do that. Infact I am not even aware
> > > of one platform who does that.
> > 
> > Not all pci busses support it but there is a standard pci bus reset bit
> > in pci bridges.
> > 
> > I don't know if it would help but it might make sense to have a config
> > option that can be used to mark drivers that are known to have problems,
> > in these scenarios.
> > 
> > CONFIG_BRITTLE_INIT perhaps?
> > 
> > It would at least make it easier for people to see which drivers
> > they don't want to use, and give people some incentive to fix things.
> > 
> 
> Vivek, 
> 
> I think having something as Eric suggested instead of crashboot= is better.
> We can hve this config option set for kernel like dump capture
> kernel. (CONFIG_CRASH_DUMP=y). This should save some bytes on already longish
> kdump kernel boot paramenters.
> 

Maneesh, Keeping this code under a config option becomes a problem when we
will have a relocatable kernel. At some point of time we got to have
relocatable kernel so that people don't have to build two kernels. In fact
this is becoming a pain area for distros. That's the reason I thought
of making it a command line parameter.

I remember few months back, Eric had mentioned that he has got patches for
relocatable kernel ready for review for i386 and x86_64. Eric, do you have
any plans to post the patches for review?

Thanks
Vivek 
