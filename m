Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932156AbWBJQ1F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156AbWBJQ1F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 11:27:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932140AbWBJQ1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 11:27:04 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:17597 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932152AbWBJQ1A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 11:27:00 -0500
Subject: Re: [Lhms-devel] [RFC/PATCH: 001/010] Memory hotplug for new nodes
	with pgdat allocation. (pgdat allocation)
From: Dave Hansen <haveblue@us.ibm.com>
To: Yasunori Goto <y-goto@jp.fujitsu.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, Andi Kleen <ak@suse.de>,
       "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>,
       linux-ia64@vger.kernel.org,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Linux Hotplug Memory Support 
	<lhms-devel@lists.sourceforge.net>,
       x86-64 Discuss <discuss@x86-64.org>
In-Reply-To: <20060210223757.C530.Y-GOTO@jp.fujitsu.com>
References: <20060210223757.C530.Y-GOTO@jp.fujitsu.com>
Content-Type: text/plain
Date: Fri, 10 Feb 2006 08:26:47 -0800
Message-Id: <1139588807.9209.71.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-02-10 at 23:20 +0900, Yasunori Goto wrote:
> 
> -extern unsigned long __initdata nr_kernel_pages;
> -extern unsigned long __initdata nr_all_pages;
> +extern unsigned long __meminitdata nr_kernel_pages;
> +extern unsigned long __meminitdata nr_all_pages; 

Can you separate out these trivial changes into separate patches?

> +extern int kswapd(void *);
> +int new_pgdat_init(int nid, unsigned long start_pfn, unsigned long
> nr_pages)
> +{
> +       unsigned long zones_size[MAX_NR_ZONES] = {0};
> +       unsigned long zholes_size[MAX_NR_ZONES] = {0};
> +        unsigned long size = arch_pernode_size(nid);
> +       pg_data_t *pgdat;

Whitespace borkage?

-- Dave

