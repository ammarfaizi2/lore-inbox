Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261427AbTCJTLo>; Mon, 10 Mar 2003 14:11:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261429AbTCJTLo>; Mon, 10 Mar 2003 14:11:44 -0500
Received: from h-64-105-35-31.SNVACAID.covad.net ([64.105.35.31]:10900 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S261427AbTCJTLm>; Mon, 10 Mar 2003 14:11:42 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Mon, 10 Mar 2003 11:22:16 -0800
Message-Id: <200303101922.LAA05449@adam.yggdrasil.com>
To: mbligh@aracnet.com
Subject: Re: 2.5.64bk5: X86_PC + HIGHMEM boot failure
Cc: apw@shadowen.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Mar 2003,Martin J. Bligh wrote:
>> [...]  I guess there still is the minor issue that
>> either CONFIG_NUMA should work with X86_PC + HIGHMEM (even
>> on machines without high memory) or else CONFIG_NUMA
>> should not be selectable in this case, but that's obviously
>> a bug of much less importance.

>Right, it *should* work ... Andy wrote the patches to enable that so 
>that distros could use a common kernel. Maybe it ought to depend on 
>CONFIG_SMP + HIGHMEM_64GB as well, which would cut out most of the 
>confusion, but still make it useful for distros. 

	I just verified that the problem also occurs with NUMA +
HIGHMEM_64GB (i.e., it is not limited to HIGHMEM_4GB).

	By the way, HIGHMEM_64GB without NUMA gets a lot father, but
still experiences memory corruption, probably same bug that caused me
to downgrade to HIGHMEM_4G months ago (i.e., probably not related to
this NUMA problem).

>> 	Sorry for my misunderstanding of the CONFIG_NUMA configution
>> options.

>No prob ... should probably be made more obvious. Are you by any chance
>doing "yes | make oldconfig"? That's the obvious way to switch it on
>by chance ... if so, can I recommend doing "yes '' | make oldconfig"
>instead? That'll take the defaults, and work much better in general.

	I want a kernel that is as broadly hardware compatible as
possible and can take advantage of as much hardware as possible, in
that order.  So, I guess I hope to reactivate CONFIG_NUMA once this
problem is solved.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
