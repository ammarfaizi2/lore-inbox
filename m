Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262508AbUKEAlO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262508AbUKEAlO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 19:41:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262512AbUKEAlO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 19:41:14 -0500
Received: from [62.206.217.67] ([62.206.217.67]:28569 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S262507AbUKEAlJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 19:41:09 -0500
Message-ID: <418ACC07.4090104@trash.net>
Date: Fri, 05 Nov 2004 01:40:39 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.3) Gecko/20041008 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: matthias.andree@gmx.de, netfilter-devel@lists.netfilter.org,
       linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] Fix ip_conntrack_amanda data corruption bug that breaks
 amanda dumps
References: <20041104121522.GA16547@merlin.emma.line.org>	<418A7B0B.7040803@trash.net>	<20041104231734.GA30029@merlin.emma.line.org>	<418AC0F2.7020508@trash.net> <20041104160655.1c66b7ef.davem@davemloft.net>
In-Reply-To: <20041104160655.1c66b7ef.davem@davemloft.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:

>On Fri, 05 Nov 2004 00:53:22 +0100
>Patrick McHardy <kaber@trash.net> wrote:
>
>  
>
>>Your observation and your patch were correct, thanks. It is supposed
>>to be just a copy, I missed that it wasn't anymore. While your patch
>>works too, and is even faster with non-linear skbs, I don't like the
>>idea of using the skb as a scratch-area, so I sent this patch to Dave
>>instead.
>>    
>>
>
>His patch isn't correct, even making a temporary change to
>a shared SKB is illegal.  Things like tcpdump could see
>corrupt SKB contents if they look during that tiny window
>when the newline character has been changed to NULL by
>the amanda conntrack module.
>  
>

True, I'm stupid sometimes :)

Regards
Patrick

