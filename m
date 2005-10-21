Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964851AbVJUDWh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964851AbVJUDWh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 23:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964852AbVJUDWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 23:22:37 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:45715 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S964851AbVJUDWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 23:22:36 -0400
Message-ID: <43585EDE.3090704@jp.fujitsu.com>
Date: Fri, 21 Oct 2005 12:22:06 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: mike kravetz <kravetz@us.ibm.com>
CC: Andrew Morton <akpm@osdl.org>, Christoph Lameter <clameter@sgi.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, magnus.damm@gmail.com,
       marcelo.tosatti@cyclades.com
Subject: Re: [PATCH 0/4] Swap migration V3: Overview
References: <20051020225935.19761.57434.sendpatchset@schroedinger.engr.sgi.com> <20051020160638.58b4d08d.akpm@osdl.org> <20051020234621.GL5490@w-mikek2.ibm.com>
In-Reply-To: <20051020234621.GL5490@w-mikek2.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mike kravetz wrote:
> On Thu, Oct 20, 2005 at 04:06:38PM -0700, Andrew Morton wrote:

> Just to be clear, there are at least two distinct requirements for hotplug.
> One only wants to remove a quantity of memory (location unimportant).  The
> other wants to remove a specific section of memory (location specific).  I
> think the first is easier to address.
> 

The only difficulty to remove a quantity of memory is how to find
where is easy to be removed. If this is fixed, I think it is
easier to address.

My own target is NUMA-node-hotplug.
I want to make the possibility of hotplug *remove a specific section* be close to 100%.
Considering NUMA node hotplug,
if a process is memory location sensitve, it should be migrated before node is removed.
So, process migration by hand before system's memory hotplug looks attractive to me.

If we can implement memory migration before memory hotplug in good way,
I think it's good.

-- Kame

