Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266964AbSKLVbD>; Tue, 12 Nov 2002 16:31:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266971AbSKLVbD>; Tue, 12 Nov 2002 16:31:03 -0500
Received: from holomorphy.com ([66.224.33.161]:61372 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S266964AbSKLVbC>;
	Tue, 12 Nov 2002 16:31:02 -0500
Date: Tue, 12 Nov 2002 13:35:04 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Matthew Dobson <colpatch@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Martin.Bligh@us.ibm.com, hohnbaum@us.ibm.com
Subject: Re: [0/4] NUMA-Q: remove PCI bus number mangling
Message-ID: <20021112213504.GV23425@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Matthew Dobson <colpatch@us.ibm.com>, linux-kernel@vger.kernel.org,
	Martin.Bligh@us.ibm.com, hohnbaum@us.ibm.com
References: <E18BaIc-0006Zs-00@holomorphy> <20021112205241.GS23425@holomorphy.com> <3DD172B8.8040802@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DD172B8.8040802@us.ibm.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2002 at 01:29:28PM -0800, Matthew Dobson wrote:
> 	I know I just sent this to you, but I've been meaning to repost this 
> 	to lkml anyway.  Here's something I wanted to add to the generic topology 
> infrastructure for a while.  pcibus_to_node()
> Have a look at this patch, and see if it might be useful to you, ok?
> Cheers!
> -Matt

I'll remove the bus number mangling from it so it uses ->sysdata
instead, make it an additional stage of the patch series and convert 
arch/i386/pci/numa.c to use it instead.

Bus number mangling has been vetoed numerous times; the agreed-upon
method of dealing with this is stuffing arch-private information in
->sysdata and dispatching on that within PCI config access routines.


Bill
