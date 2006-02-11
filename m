Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932154AbWBKDDy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbWBKDDy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 22:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbWBKDDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 22:03:54 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:54486 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932134AbWBKDDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 22:03:53 -0500
Date: Sat, 11 Feb 2006 12:02:58 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [Lhms-devel] [RFC/PATCH: 001/010] Memory hotplug for new nodes with pgdat allocation. (pgdat allocation)
Cc: "Luck, Tony" <tony.luck@intel.com>, Andi Kleen <ak@suse.de>,
       "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>,
       linux-ia64@vger.kernel.org,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Linux Hotplug Memory Support 
	<lhms-devel@lists.sourceforge.net>,
       x86-64 Discuss <discuss@x86-64.org>
In-Reply-To: <1139588807.9209.71.camel@localhost.localdomain>
References: <20060210223757.C530.Y-GOTO@jp.fujitsu.com> <1139588807.9209.71.camel@localhost.localdomain>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060211120209.D354.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, 2006-02-10 at 23:20 +0900, Yasunori Goto wrote:
> > 
> > -extern unsigned long __initdata nr_kernel_pages;
> > -extern unsigned long __initdata nr_all_pages;
> > +extern unsigned long __meminitdata nr_kernel_pages;
> > +extern unsigned long __meminitdata nr_all_pages; 
> 
> Can you separate out these trivial changes into separate patches?

Ok.

> 
> > +extern int kswapd(void *);
> > +int new_pgdat_init(int nid, unsigned long start_pfn, unsigned long
> > nr_pages)
> > +{
> > +       unsigned long zones_size[MAX_NR_ZONES] = {0};
> > +       unsigned long zholes_size[MAX_NR_ZONES] = {0};
> > +        unsigned long size = arch_pernode_size(nid);
> > +       pg_data_t *pgdat;
> 
> Whitespace borkage?

Oops. Yeah. Thanks.

-- 
Yasunori Goto 


