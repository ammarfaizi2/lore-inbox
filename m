Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265437AbUATQMi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 11:12:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265463AbUATQMi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 11:12:38 -0500
Received: from citrine.spiritone.com ([216.99.193.133]:1459 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S265437AbUATQMg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 11:12:36 -0500
Date: Tue, 20 Jan 2004 08:11:49 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Jes Sorensen <jes@wildopensource.com>
cc: Jack Steiner <steiner@sgi.com>, linux-kernel@vger.kernel.org,
       Jesse Barnes <jbarnes@sgi.com>
Subject: Re: [patch] increse MAX_NR_MEMBLKS to same as MAX_NUMNODES on NUMA
Message-ID: <18520000.1074615108@[10.10.2.4]>
In-Reply-To: <yq0d69erilj.fsf@wildopensource.com>
References: <E1AiZ5h-00043I-00@jaguar.mkp.net><4990000.1074542883@[10.10.2.4]> <20040119224535.GA12728@sgi.com><20040120022452.GA27294@sgi.com> <20040120031222.GA15435@sgi.com><11450000.1074579922@[10.10.2.4]> <yq0d69erilj.fsf@wildopensource.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>>> "Martin" == Martin J Bligh <mbligh@aracnet.com> writes:
> 
>>> On Mon, Jan 19, 2004 at 06:24:52PM -0800, Jesse Barnes wrote:
>>>> I think Martin is referring to the memblk_*line() functions and
>>>> the fact that memblks are exported via sysfs to userspace.  That
>>>> API hasn't proven very useful so far since it's really waiting for
>>>> memory hot add/remove.  Of course, we'll still need structures to
>>>> support that for the low level arch specific discontig code, so
>>>> any patch that killed memblks in sysfs and elsewhere would have to
>>>> take that into account...  (In particular, node_memblk[] is filled
>>>> out by the ACPI SRAT parsing code and use for discontig init and
>>>> physical->node id conversion.)
>>>> 
>>>> Jesse
>>>  OK, that makes sense.
> 
> Martin> Could one of you test this patch for me? Probably just a build
> Martin> would do fine.
> 
> Martin,
> 
> Tried it, no go! It conflicts with arch/ia64/mm/numa.c and
> arch/ia64/mm,/discontig.c as Jack had suggested.

Can you send me the build output? It shouldn't conflict ... there are two
separate uses of the term "memblk" by the looks of it.

M.

