Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270082AbTGWLZI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 07:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270085AbTGWLZI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 07:25:08 -0400
Received: from dsl2.external.hp.com ([192.25.206.7]:62725 "EHLO
	dsl2.external.hp.com") by vger.kernel.org with ESMTP
	id S270082AbTGWLZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 07:25:02 -0400
Date: Wed, 23 Jul 2003 05:40:06 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: "David S. Miller" <davem@redhat.com>
Cc: grundler@parisc-linux.org, ak@suse.de, alan@lxorguk.ukuu.org.uk,
       James.Bottomley@SteelEye.com, axboe@suse.de, suparna@in.ibm.com,
       linux-kernel@vger.kernel.org, alex_williamson@hp.com,
       bjorn_helgaas@hp.com
Subject: Re: [RFC] block layer support for DMA IOMMU bypass mode II
Message-ID: <20030723114006.GA28688@dsl2.external.hp.com>
References: <20030708213427.39de0195.ak@suse.de> <20030708.150433.104048841.davem@redhat.com> <20030708222545.GC6787@dsl2.external.hp.com> <20030708.152314.115928676.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030708.152314.115928676.davem@redhat.com>
User-Agent: Mutt/1.3.28i
X-Home-Page: http://www.parisc-linux.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 08, 2003 at 03:23:14PM -0700, David S. Miller wrote:
>    From: Grant Grundler <grundler@parisc-linux.org>
>    Date: Tue, 8 Jul 2003 16:25:45 -0600
> 
>    On Tue, Jul 08, 2003 at 03:04:33PM -0700, David S. Miller wrote:
>    >    Do you know a common PCI block device that would benefit from this
>    >    (performs significantly better with short sg lists)? It would be
>    >    interesting to test.
>    >    
>    > %10 to %15 on sym53c8xx devices found on sparc64 boxes.
>    
>    Which workload?
> 
> dbench type stuff, 

Without more specific guidance, dbench looks like a load of crap.
"dbench 50" is claiming 850MB/s throughput on a system with 1 disk @
u320 and 2 disks on a seperate 40 MB/s (Ultra Wide SE SCSI). More details 
are appended below.  I'll try again with lmbench or bonnie.

Andi, if you could pass me details about the "reaim new dbase" (ie how
many devices I need, where to get it) I could make time to try that in
the next couple of weeks.

> but that's a hard thing to test these days with
> the block I/O schedulers changing so much.  Try to keep that part
> constant in the with/vs/without VIO_VMERGE!=0 testing :)

yes - James Bottomley was asking for the same info.

thanks,
grant
