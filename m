Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751462AbWHRSKm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462AbWHRSKm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 14:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751463AbWHRSKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 14:10:42 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:8105 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751462AbWHRSKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 14:10:41 -0400
Date: Fri, 18 Aug 2006 11:09:19 -0700
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: haveblue@us.ibm.com, saw@sw.ru, dev@sw.ru, riel@redhat.com,
       ckrm-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       ak@suse.de, hch@infradead.org, devel@openvz.org, rohitseth@google.com,
       hugh@veritas.com, mingo@elte.hu, alan@lxorguk.ukuu.org.uk,
       xemul@openvz.org
Subject: Re: [ckrm-tech] [PATCH 4/7] UBC: syscalls (user interface)
Message-Id: <20060818110919.14424cf5.pj@sgi.com>
In-Reply-To: <20060818094248.cdca152d.akpm@osdl.org>
References: <44E33893.6020700@sw.ru>
	<44E33C3F.3010509@sw.ru>
	<1155752277.22595.70.camel@galaxy.corp.google.com>
	<1155755069.24077.392.camel@localhost.localdomain>
	<1155756170.22595.109.camel@galaxy.corp.google.com>
	<44E45D6A.8000003@sw.ru>
	<20060817084033.f199d4c7.akpm@osdl.org>
	<20060818120809.B11407@castle.nmd.msu.ru>
	<1155912348.9274.83.camel@localhost.localdomain>
	<20060818094248.cdca152d.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew wrote:
> "mems" (what are these called?)

I call them "Memory Nodes", or "nodes" for short when the qualifier
"memory" is clear from the context.

I was just reading up on FB-DIMM memory, and notice that each DIMM on
a channel has a different latency.  That sure looks like the defining
characteristic of NUMA memory to my way of thinking - non-uniform memory.

So for extra credit if your fake numa nodes pan out, it would be cute if
the fake nodes could be defined so as to respect these latency
differences - memory in different nodes if at different positions along
a memory channel.  Then a sysadmin could put their most latency
sensitive jobs on the DIMMs closest to the CPUs.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
