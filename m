Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261622AbTCTTNI>; Thu, 20 Mar 2003 14:13:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261635AbTCTTNI>; Thu, 20 Mar 2003 14:13:08 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:3458 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261622AbTCTTNH>;
	Thu, 20 Mar 2003 14:13:07 -0500
Date: Thu, 20 Mar 2003 11:13:43 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Greg KH <greg@kroah.com>
cc: Christoph Hellwig <hch@infradead.org>,
       Jes Sorensen <jes@wildopensource.com>, Jeff Garzik <garzik@pobox.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fixup warning for acenic
Message-ID: <413920000.1048187623@flay>
In-Reply-To: <20030320192020.GB3315@kroah.com>
References: <14240000.1048146629@[10.10.2.4]> <m365qenioq.fsf@trained-monkey.org> <20030320160440.A14435@infradead.org> <9590000.1048176717@[10.10.2.4]> <20030320192020.GB3315@kroah.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > 2.4.9 of course has the newstyle pci interface! And actual hotplug
>> > PCI support also is in all today singnificant 2.4.9 forks (RH..).
>> > 
>> > There's even some shim to emulate the pci_driver style interface on
>> > 2.2.
>> > 
>> > Anyway, this table has another use, it's used by userland ools like
>> > installers for selecting the right driver for a given pci device.  So
>> > even if it seems unused from kernelspace it has a use.
>> 
>> Are they kmem diving? Or parsing source code? 
> 
> They are looking at the modules.pcimap files which are generated from
> depmod, which pull it from the object files.

Hmmm ... so we're going to get a compiler warning for every hotpluggable
driver? or is this just an error in the way acenic does it? Seems like
the latter, but it's not clear to me how to fix it up properly ...
If it's the former, we need a better solution ;-)

M.
