Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261634AbVBHTSx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261634AbVBHTSx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 14:18:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261635AbVBHTSx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 14:18:53 -0500
Received: from fire.osdl.org ([65.172.181.4]:41378 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261634AbVBHTSu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 14:18:50 -0500
Message-ID: <42091079.9000400@osdl.org>
Date: Tue, 08 Feb 2005 11:18:17 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ieee1394 needs CONFIG_NET but does not depend on it
References: <20050208184136.GA7369@elf.ucw.cz>
In-Reply-To: <20050208184136.GA7369@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
> If I attempt to compile IEE1394 without CONFIG_NET, I get:
> 
> drivers/built-in.o(.text+0xcf885): In function `hpsb_alloc_packet':
> : undefined reference to `alloc_skb'
> drivers/built-in.o(.text+0xd03a6): In function `hpsb_send_packet':
> : undefined reference to `skb_queue_tail'
> drivers/built-in.o(.text+0xd0ea3): In function `abort_requests':
> : undefined reference to `skb_dequeue'
> drivers/built-in.o(.text+0xd0f99): In function
> `queue_packet_complete':
> : undefined reference to `skb_queue_tail'
> drivers/built-in.o(.text+0xd1026): In function `hpsbpkt_thread':
> : undefined reference to `skb_dequeue'
> drivers/built-in.o(.text+0xcf930): In function `hpsb_free_packet':
> : undefined reference to `__kfree_skb'
> make: *** [.tmp_vmlinux1] Error 1
> 9.20user 0.83system 10.05 (0m10.058s) elapsed 99.83%CPU
> pavel@amd:/usr/src/linux-mm$
> 
> Looks like some Kconfig dependency is needed...

Yes, it's known, should be in subversion and bk trees.

-- 
~Randy
