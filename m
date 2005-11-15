Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965043AbVKOWUy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965043AbVKOWUy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 17:20:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965042AbVKOWUy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 17:20:54 -0500
Received: from atlrel8.hp.com ([156.153.255.206]:36538 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S932548AbVKOWUv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 17:20:51 -0500
Message-ID: <437A5F42.3080100@hp.com>
Date: Tue, 15 Nov 2005 17:20:50 -0500
From: Vlad Yasevich <vladislav.yasevich@hp.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051109)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Yan Zheng <yanzheng@21cn.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       yoshfuji@linux-ipv6.org
Subject: Re: [PATCH]small fix for __ipv6_addr_type(...)
References: <4376F2CE.4050003@21cn.com>
In-Reply-To: <4376F2CE.4050003@21cn.com>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No, according to RFC 4007, loopback is considered a link-local
address.

-vlad

Yan Zheng wrote:
> Hi.
> 
> I think the scope for loopback address should be node local.
> 
> Regards
> 
> Signed-off-by: Yan Zheng <yanzheng@21cn.com>
> 
> ========================================================================
> --- linux-2.6.15-rc1/net/ipv6/addrconf.c    2005-11-13
> 12:23:06.000000000 +0800
> +++ linux/net/ipv6/addrconf.c    2005-11-13 15:50:03.000000000 +0800
> @@ -249,7 +249,7 @@ int __ipv6_addr_type(const struct in6_ad
> 
>             if (addr->s6_addr32[3] == htonl(0x00000001))
>                 return (IPV6_ADDR_LOOPBACK | IPV6_ADDR_UNICAST |
> -                   
> IPV6_ADDR_SCOPE_TYPE(IPV6_ADDR_SCOPE_LINKLOCAL));    /* addr-select 3.4 */
> +                   
> IPV6_ADDR_SCOPE_TYPE(IPV6_ADDR_SCOPE_NODELOCAL));    /* addr-select 3.4 */
> 
>             return (IPV6_ADDR_COMPATv4 | IPV6_ADDR_UNICAST |
>                 IPV6_ADDR_SCOPE_TYPE(IPV6_ADDR_SCOPE_GLOBAL));    /*
> addr-select 3.3 */
> -
> To unsubscribe from this list: send the line "unsubscribe netdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
