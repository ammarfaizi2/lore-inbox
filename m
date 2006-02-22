Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751323AbWBVDvd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbWBVDvd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 22:51:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751329AbWBVDvd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 22:51:33 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:9350 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751323AbWBVDvb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 22:51:31 -0500
Message-ID: <43FBDFF9.4080002@jp.fujitsu.com>
Date: Wed, 22 Feb 2006 12:52:25 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Christoph Lameter <clameter@engr.sgi.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, Dave Hansen <haveblue@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] remove zone_mem_map
References: <43FBAEBA.2020300@jp.fujitsu.com> <Pine.LNX.4.64.0602211900450.23557@schroedinger.engr.sgi.com> <43FBD995.20601@jp.fujitsu.com> <Pine.LNX.4.64.0602211939210.26289@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0602211939210.26289@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Wed, 22 Feb 2006, KAMEZAWA Hiroyuki wrote:
> 
>> BTW, ia64 looks very special. Does it make sensible performance gain ?
> 
> Well yes, we actually have virtual mappings in kernel address space. 
> F.e. The hotplug remove issues could be fixed there by remapping pages.
> 
Ah, if we place node_data[i](array of pointer to pgdat) in region 7,
there is no trouble ?
(maybe zone_table[] should be also..)

-- Kame

