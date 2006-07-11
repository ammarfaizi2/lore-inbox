Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965030AbWGKHK3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965030AbWGKHK3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 03:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965084AbWGKHK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 03:10:29 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:37528 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S965030AbWGKHK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 03:10:29 -0400
Date: Tue, 11 Jul 2006 16:11:45 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-kernel@vger.kernel.org, mbligh@google.com, hch@infradead.org,
       marcelo@kvack.org, arjan@infradead.org, nickpiggin@yahoo.com.au,
       ak@suse.de
Subject: Re: [RFC 1/8] Add CONFIG_ZONE_DMA to all archesM
Message-Id: <20060711161145.8fa5ecfa.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <Pine.LNX.4.64.0607100855580.4491@schroedinger.engr.sgi.com>
References: <20060708000501.3829.25578.sendpatchset@schroedinger.engr.sgi.com>
	<20060708000506.3829.34340.sendpatchset@schroedinger.engr.sgi.com>
	<20060710095254.bad0084b.kamezawa.hiroyu@jp.fujitsu.com>
	<Pine.LNX.4.64.0607100855580.4491@schroedinger.engr.sgi.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jul 2006 08:56:50 -0700 (PDT)
Christoph Lameter <clameter@sgi.com> wrote:

> On Mon, 10 Jul 2006, KAMEZAWA Hiroyuki wrote:
> 
> > 
> > How about configuring this by
> > 
> > config ZONE_DMA
> > 	def_bool y
> > 	depends on GENERIC_ISA_DMA || ARCH_ZONE_DMA
> > 
> > and set ARCH_ZONE_DMA for each arch ?
> 
> Yes we do something like that in a later patch. What would be the 
> advantage of having CONFIG_ARCH_ZONE_DMA instead of CONFIG_ZONE_DMA?
> 
I think it's a bit complicated that both (generic)mm/Kconfig and arch/???/Kconfg
has the same config option. I think there are 2 ways..

1. remove CONFIG_ZONE_DMA from mm/Kconfig and move all to under arch/
2. define ARCH_ZONE_DMA under /arch and unite them in mm/Kconfig by
   CONFIG_ZONE_DMA


-Kame

