Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261463AbVCGBTn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261463AbVCGBTn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 20:19:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261437AbVCGBTn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 20:19:43 -0500
Received: from ns1.lanforge.com ([66.165.47.210]:49313 "EHLO www.lanforge.com")
	by vger.kernel.org with ESMTP id S261516AbVCGBTZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 20:19:25 -0500
Message-ID: <422BABCE.3030904@candelatech.com>
Date: Sun, 06 Mar 2005 17:18:06 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "leo.yuriev.ru" <leo@yuriev.ru>
CC: Lennert Buytenhek <buytenh@gnu.org>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ethernet-bridge: update skb->priority in case forwarded
 frame has VLAN-header
References: <1199527299.20050305165713@yuriev.ru>
In-Reply-To: <1199527299.20050305165713@yuriev.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Leo Yuriev wrote:
> Kernel 2.6 (2.6.11)
> 
> When ethernet-bridge forward a packet and such ethernet-frame has
> VLAN-tag, bridge should update skb->prioriry for properly QoS
> handling.
> 
> This small patch does this. Currently vlan_TCI-priority directly
> mapped to skb->priority, but this looks enough.

If this packet came in from an 802.1Q VLAN device, the VLAN code already
has the logic necessary to map the .1q priority to an arbitrary skb->priority.

See the vconfig commands:
        set_egress_map  [vlan-name]      [skb_priority]   [vlan_qos]
        set_ingress_map [vlan-name]      [skb_priority]   [vlan_qos]

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

