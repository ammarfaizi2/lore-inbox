Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264405AbUATFWh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 00:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264540AbUATFWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 00:22:37 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:8114 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S264405AbUATFWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 00:22:36 -0500
Date: Mon, 19 Jan 2004 21:21:46 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Jesse Barnes <jbarnes@sgi.com>, Jack Steiner <steiner@sgi.com>
cc: jes@trained-monkey.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] increse MAX_NR_MEMBLKS to same as MAX_NUMNODES on NUMA
Message-ID: <3370000.1074576105@[10.10.2.4]>
In-Reply-To: <20040120022452.GA27294@sgi.com>
References: <E1AiZ5h-00043I-00@jaguar.mkp.net> <4990000.1074542883@[10.10.2.4]> <20040119224535.GA12728@sgi.com> <20040120022452.GA27294@sgi.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Jesse Barnes <jbarnes@sgi.com> wrote (on Monday, January 19, 2004 18:24:52 -0800):

> On Mon, Jan 19, 2004 at 04:45:35PM -0600, Jack Steiner wrote:
>> On Mon, Jan 19, 2004 at 12:08:04PM -0800, Martin J. Bligh wrote:
>> > > Since we now support # of CPUs > BITS_PER_LONG with cpumask_t it would
>> > > be nice to be able to support more than BITS_PER_LONG memory blocks.
>> > 
>> > Nothing uses them. We're probably better off just removing them altogether.
>> 
>> I dont understand.
>> node_memblk[] is used on IA64 in arch/ia64/mm/discontig.c (& other places too).
> 
> I think Martin is referring to the memblk_*line() functions and the fact
> that memblks are exported via sysfs to userspace.  That API hasn't
> proven very useful so far since it's really waiting for memory hot
> add/remove.  Of course, we'll still need structures to support that for
> the low level arch specific discontig code, so any patch that killed
> memblks in sysfs and elsewhere would have to take that into account...
> (In particular, node_memblk[] is filled out by the ACPI SRAT parsing
> code and use for discontig init and physical->node id conversion.)

Phew ;-) 
Maybe I'll go ahead and delete it quickly ... ;-)

M.

