Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964854AbVJUDca@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964854AbVJUDca (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 23:32:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964855AbVJUDca
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 23:32:30 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:25307 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S964854AbVJUDca
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 23:32:30 -0400
Date: Thu, 20 Oct 2005 20:32:23 -0700
From: mike kravetz <kravetz@us.ibm.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: Andrew Morton <akpm@osdl.org>, Christoph Lameter <clameter@sgi.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, magnus.damm@gmail.com,
       marcelo.tosatti@cyclades.com
Subject: Re: [PATCH 0/4] Swap migration V3: Overview
Message-ID: <20051021033223.GC6846@w-mikek2.ibm.com>
References: <20051020225935.19761.57434.sendpatchset@schroedinger.engr.sgi.com> <20051020160638.58b4d08d.akpm@osdl.org> <20051020234621.GL5490@w-mikek2.ibm.com> <43585EDE.3090704@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43585EDE.3090704@jp.fujitsu.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2005 at 12:22:06PM +0900, KAMEZAWA Hiroyuki wrote:
> mike kravetz wrote:
> >On Thu, Oct 20, 2005 at 04:06:38PM -0700, Andrew Morton wrote:
> 
> >Just to be clear, there are at least two distinct requirements for hotplug.
> >One only wants to remove a quantity of memory (location unimportant).  The
> >other wants to remove a specific section of memory (location specific).  I
> >think the first is easier to address.
> >
> 
> The only difficulty to remove a quantity of memory is how to find
> where is easy to be removed. If this is fixed, I think it is
> easier to address.

We have been using Mel's fragmentation patches.  One of the data structures
created by these patches is a 'usemap' thats tracks how 'blocks' of memory
are used.  I exposed the usemaps via sysfs along with other hotplug memory
section attributes.  So, you can then have a user space program scan the
usemaps looking for sections that can be easily offlined.

-- 
Mike
