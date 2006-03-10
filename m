Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751914AbWCJIF7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751914AbWCJIF7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 03:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbWCJIF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 03:05:59 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:42218 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751914AbWCJIF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 03:05:58 -0500
Date: Fri, 10 Mar 2006 17:05:53 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH: 003/017](RFC) Memory hotplug for new nodes v.3.(get node id at probe memory)
Cc: tony.luck@intel.com, ak@suse.de, jschopp@austin.ibm.com,
       haveblue@us.ibm.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20060309040031.2be49ec2.akpm@osdl.org>
References: <20060308212646.0028.Y-GOTO@jp.fujitsu.com> <20060309040031.2be49ec2.akpm@osdl.org>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060310154600.CA73.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yasunori Goto <y-goto@jp.fujitsu.com> wrote:
> >
> > When CONFIG_NUMA && CONFIG_ARCH_MEMORY_PROBE, nid should be defined
> >  before calling add_memory_node(nid, start, size).
> > 
> >  Each arch , which supports CONFIG_NUMA && ARCH_MEMORY_PROBE, should
> >  define arch_nid_probe(paddr);
> > 
> >  Powerpc has nice function. X86_64 has not.....
> 
> This patch uses an odd mixture of __devinit and <nothing-at-all> in
> arch/x86_64/mm/init.c.  I guess it should be using __meminit
> throughout.

  Oh... I made mistake. I'll fix them.



-- 
Yasunori Goto 


