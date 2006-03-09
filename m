Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751795AbWCIMCk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751795AbWCIMCk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 07:02:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751880AbWCIMCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 07:02:40 -0500
Received: from smtp.osdl.org ([65.172.181.4]:53449 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751876AbWCIMCi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 07:02:38 -0500
Date: Thu, 9 Mar 2006 04:00:31 -0800
From: Andrew Morton <akpm@osdl.org>
To: Yasunori Goto <y-goto@jp.fujitsu.com>
Cc: tony.luck@intel.com, ak@suse.de, jschopp@austin.ibm.com,
       haveblue@us.ibm.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH: 003/017](RFC) Memory hotplug for new nodes v.3.(get
 node id at probe memory)
Message-Id: <20060309040031.2be49ec2.akpm@osdl.org>
In-Reply-To: <20060308212646.0028.Y-GOTO@jp.fujitsu.com>
References: <20060308212646.0028.Y-GOTO@jp.fujitsu.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yasunori Goto <y-goto@jp.fujitsu.com> wrote:
>
> When CONFIG_NUMA && CONFIG_ARCH_MEMORY_PROBE, nid should be defined
>  before calling add_memory_node(nid, start, size).
> 
>  Each arch , which supports CONFIG_NUMA && ARCH_MEMORY_PROBE, should
>  define arch_nid_probe(paddr);
> 
>  Powerpc has nice function. X86_64 has not.....

This patch uses an odd mixture of __devinit and <nothing-at-all> in
arch/x86_64/mm/init.c.  I guess it should be using __meminit
throughout.
