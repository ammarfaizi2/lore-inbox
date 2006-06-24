Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750924AbWFXROf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750924AbWFXROf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 13:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750918AbWFXROf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 13:14:35 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:35734 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750908AbWFXROe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 13:14:34 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: vgoyal@in.ibm.com
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       fastboot@lists.osdl.org, linux-scsi@vger.kernel.org, mike.miller@hp.com,
       Neela.Kolli@engenio.com
Subject: Re: [RFC] [PATCH 2/2] kdump: cciss driver initialization issue fix
References: <20060623210121.GA18384@in.ibm.com>
	<20060623210424.GB18384@in.ibm.com>
	<20060623235553.2892f21a.akpm@osdl.org>
	<20060624111954.GA7313@in.ibm.com>
	<20060624043046.4e4985be.akpm@osdl.org>
	<20060624120836.GB7313@in.ibm.com>
Date: Sat, 24 Jun 2006 11:13:44 -0600
In-Reply-To: <20060624120836.GB7313@in.ibm.com> (Vivek Goyal's message of
	"Sat, 24 Jun 2006 08:08:36 -0400")
Message-ID: <m1veqqxyrb.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal <vgoyal@in.ibm.com> writes:

> On Sat, Jun 24, 2006 at 04:30:46AM -0700, Andrew Morton wrote:
>
>> > Or is there a generic way to handle these situations? Fixing them driver
>> > by driver is a long painful process. 
>> 
>> Some generic way of whacking a PCI device via the standard PCI registers? 
>> Not that I know of.
>
> Somebody hinted that think of PCI bus reset. But I think PCI bus reset will
> require firware/BIOS to export a hook to software to so initiate PCI bus
> reset and I don't think many platforms do that. Infact I am not even aware
> of one platform who does that.

Not all pci busses support it but there is a standard pci bus reset bit
in pci bridges.

I don't know if it would help but it might make sense to have a config
option that can be used to mark drivers that are known to have problems,
in these scenarios.

CONFIG_BRITTLE_INIT perhaps?

It would at least make it easier for people to see which drivers
they don't want to use, and give people some incentive to fix things.

Eric
