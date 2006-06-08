Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751285AbWFHTim@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbWFHTim (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 15:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbWFHTim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 15:38:42 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:51645 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751285AbWFHTil (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 15:38:41 -0400
Message-ID: <44887B70.9050707@in.ibm.com>
Date: Fri, 09 Jun 2006 01:03:04 +0530
From: Balbir Singh <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
Organization: IBM India Private Limited
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051205
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       jlan@engr.sgi.com, peterc@gelato.unsw.edu.au
Subject: Re: Merge of per task delay accounting (was Re: 2.6.18 -mm merge
 plans)
References: <20060604135011.decdc7c9.akpm@osdl.org> <4484D25E.4020805@in.ibm.com> <4486017F.8030308@watson.ibm.com> <20060606154034.10147da7.akpm@osdl.org> <448833E2.6000608@watson.ibm.com> <20060608104224.b2fe8c60.akpm@osdl.org> <44886E38.3090809@watson.ibm.com>
In-Reply-To: <44886E38.3090809@watson.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shailabh Nagar wrote:
>> hm.  Is it possible to check the privileges of a netlink message sender?
>>  
>>
> Not entirely sure. But there's. a check in net/netlink/genetlink.c: 
> genl_rcv_msg()
> for
> if ((ops->flags & GENL_ADMIN_PERM) && security_netlink_recv(skb))
> {    err = -EPERM;
>    goto errout;
> }
> 
> and security_netlink_recv(skb), normally set to cap_netlink_recv, checks 
> on the skb's effective capability
> being CAP_NET_ADMIN which I thought would be sufficient.
> Need to look further.
> 
> If it doesn't turn out to fit properly, sysfs config variable can be used.
>

The genl_ops has a flags field. If the flags field is initialized to
GENL_ADMIN_PERM, then privleges are checked as pointed out by you.
 
-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
