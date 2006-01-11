Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161085AbWAKBua@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161085AbWAKBua (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 20:50:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161089AbWAKBu3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 20:50:29 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:46312 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1161085AbWAKBu1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 20:50:27 -0500
Date: Wed, 11 Jan 2006 10:49:11 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Andi Kleen <ak@suse.de>
Subject: Re: [patch 2/2] add x86-64 support for memory hot-add
Cc: keith <kmannth@us.ibm.com>,
       "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>,
       Matt Tolentino <metolent@cs.vt.edu>, akpm@osdl.org, discuss@x86-64.org,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <200601101348.17322.ak@suse.de>
References: <20060110214140.38B2.Y-GOTO@jp.fujitsu.com> <200601101348.17322.ak@suse.de>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.057
Message-Id: <20060111103557.BCA6.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.21.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tuesday 10 January 2006 13:43, Yasunori Goto wrote:
> > > IIRC, SRAT is just for booting time. So, when hotplug occured,
> > > it is not reliable. DSDT should be used for it in order to SRAT
> > > like following 2 patches.
> > > First is to get pxm from physical address.
> > > I'll post the second patch after this post.
> >
> > Second one is here.
> > This is map/unmap between pxm to nid. This is just for ia64.
> > But I guess for x86-64 is not so difference.
> 
> It probably is. The x86-64 NUMA setup is quite different from IA64.

Ah... Ok.
I wish my patch would be good example for x86-64.

But, hmm. I feel it is a bit strange.
Why there is a difference among x86-64 and ia64 about mapping
pxm to nid? (in addition i386.)
PXM is defined by ACPI. ACPI is used on all of them.
Node id is used on Linux generically.

So, ia64 and i386 has pxm_to_nid_map[], and x86-64 has pxm2node[] too.

Why are these arrays and codes are defined on each arch?
Does anyone know it?
Its code might be able to be common on driver/acpi/numa.c...

-- 
Yasunori Goto 


