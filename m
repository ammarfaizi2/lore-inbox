Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265338AbUATLA2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 06:00:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265351AbUATLA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 06:00:28 -0500
Received: from jaguar.mkp.net ([192.139.46.146]:52173 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S265338AbUATLA0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 06:00:26 -0500
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Jack Steiner <steiner@sgi.com>, linux-kernel@vger.kernel.org,
       Jesse Barnes <jbarnes@sgi.com>
Subject: Re: [patch] increse MAX_NR_MEMBLKS to same as MAX_NUMNODES on NUMA
References: <E1AiZ5h-00043I-00@jaguar.mkp.net>
	<4990000.1074542883@[10.10.2.4]> <20040119224535.GA12728@sgi.com>
	<20040120022452.GA27294@sgi.com> <20040120031222.GA15435@sgi.com>
	<11450000.1074579922@[10.10.2.4]>
From: Jes Sorensen <jes@wildopensource.com>
Date: 20 Jan 2004 05:59:36 -0500
In-Reply-To: <11450000.1074579922@[10.10.2.4]>
Message-ID: <yq0d69erilj.fsf@wildopensource.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Martin" == Martin J Bligh <mbligh@aracnet.com> writes:

>> On Mon, Jan 19, 2004 at 06:24:52PM -0800, Jesse Barnes wrote:
>>> I think Martin is referring to the memblk_*line() functions and
>>> the fact that memblks are exported via sysfs to userspace.  That
>>> API hasn't proven very useful so far since it's really waiting for
>>> memory hot add/remove.  Of course, we'll still need structures to
>>> support that for the low level arch specific discontig code, so
>>> any patch that killed memblks in sysfs and elsewhere would have to
>>> take that into account...  (In particular, node_memblk[] is filled
>>> out by the ACPI SRAT parsing code and use for discontig init and
>>> physical->node id conversion.)
>>> 
>>> Jesse
>>  OK, that makes sense.

Martin> Could one of you test this patch for me? Probably just a build
Martin> would do fine.

Martin,

Tried it, no go! It conflicts with arch/ia64/mm/numa.c and
arch/ia64/mm,/discontig.c as Jack had suggested.

Cheers,
Jes
