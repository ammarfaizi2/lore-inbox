Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751905AbWCIMDz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751905AbWCIMDz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 07:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751913AbWCIMDc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 07:03:32 -0500
Received: from smtp.osdl.org ([65.172.181.4]:8138 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751905AbWCIMDN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 07:03:13 -0500
Date: Thu, 9 Mar 2006 04:01:04 -0800
From: Andrew Morton <akpm@osdl.org>
To: Yasunori Goto <y-goto@jp.fujitsu.com>
Cc: tony.luck@intel.com, ak@suse.de, jschopp@austin.ibm.com,
       haveblue@us.ibm.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH: 012/017](RFC) Memory hotplug for new nodes v.3.
 (rebuild zonelists after online pages)
Message-Id: <20060309040104.6e6f5ccd.akpm@osdl.org>
In-Reply-To: <20060308213410.003A.Y-GOTO@jp.fujitsu.com>
References: <20060308213410.003A.Y-GOTO@jp.fujitsu.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yasunori Goto <y-goto@jp.fujitsu.com> wrote:
>
> In current code, zonelist is considered to be build once, no modification.
>  But MemoryHotplug can add new zone/pgdat. It must be updated.
> 
>  This patch modifies build_all_zonelists(). 
>  By this, build_all_zonelist() can reconfig pgdat's zonelists.
> 
>  To update them safety, this patch use stop_machine_run().

Yup, that's a good way of doing it.
