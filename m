Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751785AbWCNLld@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751785AbWCNLld (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 06:41:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751806AbWCNLld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 06:41:33 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:18664 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751785AbWCNLlc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 06:41:32 -0500
Date: Tue, 14 Mar 2006 20:40:25 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: jschopp@austin.ibm.com, haveblue@us.ibm.com
Subject: Re: [PATCH: 003/017](RFC) Memory hotplug for new nodes v.3.(get node id at probe memory)
Cc: Andrew Morton <akpm@osdl.org>, ak@suse.de, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
In-Reply-To: <20060310154600.CA73.Y-GOTO@jp.fujitsu.com>
References: <20060309040031.2be49ec2.akpm@osdl.org> <20060310154600.CA73.Y-GOTO@jp.fujitsu.com>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060314201603.9159.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Yasunori Goto <y-goto@jp.fujitsu.com> wrote:
> > >
> > > When CONFIG_NUMA && CONFIG_ARCH_MEMORY_PROBE, nid should be defined
> > >  before calling add_memory_node(nid, start, size).
> > > 
> > >  Each arch , which supports CONFIG_NUMA && ARCH_MEMORY_PROBE, should
> > >  define arch_nid_probe(paddr);
> > > 
> > >  Powerpc has nice function. X86_64 has not.....
> > 
> > This patch uses an odd mixture of __devinit and <nothing-at-all> in
> > arch/x86_64/mm/init.c.  I guess it should be using __meminit
> > throughout.
> 
>   Oh... I made mistake. I'll fix them.

Hmmm. I'm confusing again about this. :-(

Dave-san, Joel-san.

Why does Powerpc use __devinit for add_memory()?
Usually, add_memory() is never called at boottime.
So, I suppose __meminit nor __devinit is not needed at all around here.

But, does it have a plan that add_memory() is called only boottime on 
Powerpc?


-- 
Yasunori Goto 


