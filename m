Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261326AbTCJPEm>; Mon, 10 Mar 2003 10:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261328AbTCJPEm>; Mon, 10 Mar 2003 10:04:42 -0500
Received: from franka.aracnet.com ([216.99.193.44]:47565 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S261326AbTCJPEl>; Mon, 10 Mar 2003 10:04:41 -0500
Date: Mon, 10 Mar 2003 07:14:33 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: Andy Whitcroft <apw@shadowen.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.64bk5: X86_PC + HIGHMEM boot failure
Message-ID: <1090000.1047309272@[10.10.2.4]>
In-Reply-To: <200303100846.AAA09348@baldur.yggdrasil.com>
References: <200303100846.AAA09348@baldur.yggdrasil.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Err, I meant 2.5.64bk4. 
> 
>> Hmmm ... well I don't see bk4 on ftp.kernel.org,
> 
> 	I meant ftp://ftp.kernel.org/pub/liux/kernel/v2.5/linux-2.5.64.tar.gz
> patched with
> ftp://ftp.kernel.org/pub/liux/kernel/v2.5/snapshots/patch-2.5.64-bk4.gz.

Yeah, I know ... hadn't seemed to have mirrored across when I looked,
but I grabbed it from somewhere else.
 
> 	Oops.  You're right it is possible to deactivate
> CONFIG_NUMA in this kernel under X86_PC, and that avoids
> the problem.  I guess there still is the minor issue that
> either CONFIG_NUMA should work with X86_PC + HIGHMEM (even
> on machines without high memory) or else CONFIG_NUMA
> should not be selectable in this case, but that's obviously
> a bug of much less importance.

Right, it *should* work ... Andy wrote the patches to enable that so 
that distros could use a common kernel. Maybe it ought to depend on 
CONFIG_SMP + HIGHMEM_64GB as well, which would cut out most of the 
confusion, but still make it useful for distros. 

> 	Sorry for my misunderstanding of the CONFIG_NUMA configution
> options.

No prob ... should probably be made more obvious. Are you by any chance
doing "yes | make oldconfig"? That's the obvious way to switch it on
by chance ... if so, can I recommend doing "yes '' | make oldconfig"
instead? That'll take the defaults, and work much better in general.

M.

