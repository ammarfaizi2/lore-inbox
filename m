Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932121AbWHGSjo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121AbWHGSjo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 14:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932301AbWHGSjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 14:39:44 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:39054 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932121AbWHGSjn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 14:39:43 -0400
Subject: Re: [PATCH 1/10] hot-add-mem x86_64: acpi motherboard fix
From: keith mannthey <kmannth@us.ibm.com>
Reply-To: kmannth@us.ibm.com
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: lkml <linux-kernel@vger.kernel.org>, andrew <akpm@osdl.org>,
       discuss <discuss@x86-64.org>, Andi Kleen <ak@suse.de>,
       lhms-devel <lhms-devel@lists.sourceforge.net>
In-Reply-To: <20060805145137.aad34b44.kamezawa.hiroyu@jp.fujitsu.com>
References: <20060804131351.21401.4877.sendpatchset@localhost.localdomain>
	 <20060805145137.aad34b44.kamezawa.hiroyu@jp.fujitsu.com>
Content-Type: text/plain
Organization: Linux Technology Center IBM
Date: Mon, 07 Aug 2006 11:39:27 -0700
Message-Id: <1154975968.5790.16.camel@keithlap>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-08-05 at 14:51 +0900, KAMEZAWA Hiroyuki wrote:
> On Fri, 4 Aug 2006 07:13:51 -0600
> Keith Mannthey <kmannth@us.ibm.com> wrote:
> > I have worked to integrate the feedback I recived on the last round of patches
> > and welcome more ideas/advice. Thanks to everyone who has provied input on
> > these patches already. 
> > 
> Just from review...
> 
> If new zone , which was empty at boot, are added into the system.
> build_all_zonelists() has to be called. (see online_pages() in memory_hotplug.c)
> it looks x86_64's __add_pages() doesn't calles it.

With RESERVE there are not empty zones.  All zones (including add-areas)
are setup during boot and hot add areas reserved in the bootmem
allocator. 

Zones don't change size there is no adding to the zone just on-lining on
pages at are already present in the zone. 
  

-- 
keith mannthey <kmannth@us.ibm.com>
Linux Technology Center IBM

