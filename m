Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751854AbWCIMXU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751854AbWCIMXU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 07:23:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751846AbWCIMXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 07:23:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:26514 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751848AbWCIMXT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 07:23:19 -0500
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH: 010/017](RFC) Memory hotplug for new nodes v.3. (allocate wait table)
Date: Thu, 9 Mar 2006 05:56:04 +0100
User-Agent: KMail/1.9.1
Cc: Yasunori Goto <y-goto@jp.fujitsu.com>, tony.luck@intel.com,
       jschopp@austin.ibm.com, haveblue@us.ibm.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20060308213301.0036.Y-GOTO@jp.fujitsu.com> <20060309040055.21f3ec2d.akpm@osdl.org>
In-Reply-To: <20060309040055.21f3ec2d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603090556.06226.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 09 March 2006 13:00, Andrew Morton wrote:
> Yasunori Goto <y-goto@jp.fujitsu.com> wrote:
> >
> >  +		/* we can use kmalloc() in run time */
> >  +		do {
> >  +			table_size = zone->wait_table_size
> >  +					* sizeof(wait_queue_head_t);
> >  +			zone->wait_table = kmalloc(table_size, GFP_ATOMIC);
> 
> Again, GFP_KERNEL would be better is possible.
> 
> Won't this place the node's wait_table into a different node's memory?

Yes, kmalloc_node would be better.

-Andi


