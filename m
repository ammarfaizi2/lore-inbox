Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751206AbWHHCGP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbWHHCGP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 22:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbWHHCGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 22:06:15 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:40428 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751206AbWHHCGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 22:06:14 -0400
Date: Tue, 8 Aug 2006 11:08:55 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: kmannth@us.ibm.com
Cc: akpm@osdl.org, discuss@x86-64.org, ak@suse.de,
       linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net
Subject: Re: [Lhms-devel] [PATCH 1/10] hot-add-mem x86_64: acpi motherboard
 fix
Message-Id: <20060808110855.b3a004a5.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <1154998617.5790.31.camel@keithlap>
References: <20060804131351.21401.4877.sendpatchset@localhost.localdomain>
	<20060805145137.aad34b44.kamezawa.hiroyu@jp.fujitsu.com>
	<1154975968.5790.16.camel@keithlap>
	<20060808093110.f7b2ae04.kamezawa.hiroyu@jp.fujitsu.com>
	<1154998617.5790.31.camel@keithlap>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Aug 2006 17:56:56 -0700
keith mannthey <kmannth@us.ibm.com> wrote:

> I know of no x86_64 hardware the supports empty node hot-add memory.  If
> it exists I would recommend using SPARSEMEM based hot-add.  On HW I am
> aware of there is always some memory present in a node at boot.   
>  
> 
O.K one more.

I know x86_64 has ZONE_DMA32. A system boot with only memory below 4G 
has no avilable memory in ZONE_NORMAL. If a new memory above 4G is added,
ZONE_NORMAL comes as *new* zone.
ZONE_NORMAL is empty at boot, so it's not in zonelist at boot.

is this not problem ?

-Kame

