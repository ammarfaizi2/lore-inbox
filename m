Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264647AbUFLGAv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264647AbUFLGAv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 02:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264649AbUFLGAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 02:00:51 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:35738 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264647AbUFLGAu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 02:00:50 -0400
Date: Fri, 11 Jun 2004 23:00:40 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andi Kleen <ak@muc.de>
cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       Andy Whitcroft <apw@shadowen.org>, akpm@osdl.org
Subject: Re: [PATCH] Permit inode & dentry hash tables to be allocated > MAX_ORDER size
Message-ID: <111690000.1087020039@[10.10.2.4]>
In-Reply-To: <m3d645fwxj.fsf@averell.firstfloor.org>
References: <263jX-5RZ-19@gated-at.bofh.it> <262nZ-56Z-5@gated-at.bofh.it><263jX-5RZ-17@gated-at.bofh.it> <m3d645fwxj.fsf@averell.firstfloor.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Allocating the big-assed hashes out of bootmem seems much cleaner to me,
>> at least ...
> 
> Machines big enough that such big hashes make sense are probably NUMA.
> And on NUMA systems you imho should rather use node interleaving vmalloc(),
> not a bit physical allocation on a specific node for these hashes. 
> This will avoid memory controller hot spots and avoid the problem completely.
> Likely it will perform better too.

I thought Manfred already fixed all that up, didn't he?

M.

