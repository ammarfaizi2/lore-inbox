Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750824AbVLAOFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbVLAOFF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 09:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbVLAOFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 09:05:05 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:5953 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S1750824AbVLAOFE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 09:05:04 -0500
Subject: Re: Linux 2.6.15-rc4
From: Kasper Sandberg <lkml@metanurb.dk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0511302234020.3099@g5.osdl.org>
References: <Pine.LNX.4.64.0511302234020.3099@g5.osdl.org>
Content-Type: text/plain
Date: Thu, 01 Dec 2005 15:05:03 +0100
Message-Id: <1133445903.16820.1.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-30 at 22:40 -0800, Linus Torvalds wrote:
<snip>
> 
> 		Linus
> 
> [ Btw, some drivers will now complain loudly about their nasty mis-use of 
>   page remapping, and that migh look scary, but it should all be good, and 
>   we'd love to see the detailed output of dmesg on such machines. ]
> 

this is the ati proprietary driver on x86 laptop.

Backtrace:
 [<b013d88d>] bad_page+0x7d/0xc0
 [<b013e124>] free_hot_cold_page+0x44/0x100
 [<b0148c2c>] zap_pte_range+0xfc/0x220
 [<b0148e3c>] unmap_page_range+0xec/0x110
 [<b0148f21>] unmap_vmas+0xc1/0x1e0
 [<b014cc45>] unmap_region+0x85/0x110
 [<b014cf39>] do_munmap+0xd9/0x120
 [<b014cfc7>] sys_munmap+0x47/0x70
 [<b0102f1b>] sysenter_past_esp+0x54/0x75
Trying to fix it up, but a reboot is needed


<snip>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

