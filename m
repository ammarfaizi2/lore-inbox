Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932409AbWH1HaP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409AbWH1HaP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 03:30:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932412AbWH1HaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 03:30:15 -0400
Received: from mail.us.es ([193.147.175.20]:1179 "EHLO us.es")
	by vger.kernel.org with ESMTP id S932409AbWH1HaN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 03:30:13 -0400
Message-ID: <44F29CD4.9000707@netfilter.org>
Date: Mon, 28 Aug 2006 09:35:48 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20060205 Debian/1.7.12-1.1
X-Accept-Language: en
MIME-Version: 1.0
To: Benoit Boissinot <benoit.boissinot@ens-lyon.fr>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: 2.6.18-rc4-mm3
References: <20060826160922.3324a707.akpm@osdl.org> <40f323d00608270550y2b4706a8i95990344f0eccad1@mail.gmail.com>
In-Reply-To: <40f323d00608270550y2b4706a8i95990344f0eccad1@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benoit Boissinot wrote:
> On 8/27/06, Andrew Morton <akpm@osdl.org> wrote:
> 
>>
>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc4/2.6.18-rc4-mm3/ 
>>
>>
>> Changes since 2.6.18-rc4-mm2:
>>
>>  git-net.patch
> 
> 
> It introduces a new warning for me:
> net/netfilter/xt_CONNMARK.c: In function 'target':
> net/netfilter/xt_CONNMARK.c:59: warning: implicit declaration of
> function 'nf_conntrack_event_cache'
> 
> The warning is due to the following .config:
> CONFIG_IP_NF_CONNTRACK=m
> CONFIG_IP_NF_CONNTRACK_MARK=y
> # CONFIG_IP_NF_CONNTRACK_EVENTS is not set
> CONFIG_IP_NF_CONNTRACK_NETLINK=m
> 
> This change was introduced by:
> http://www.kernel.org/git/?p=linux/kernel/git/davem/net-2.6.19.git;a=commit;h=76e4b41009b8a2e9dd246135cf43c7fe39553aa5 
> 
> Proposed solution (based on the define in
> include/net/netfilter/nf_conntrack_compat.h:

That is my fault, thanks for catching up this Benoit.

Acked-by: Pablo Neira Ayuso <pablo@netfilter.org>

-- 
The dawn of the fourth age of Linux firewalling is coming; a time of 
great struggle and heroic deeds -- J.Kadlecsik got inspired by J.Morris
