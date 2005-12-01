Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932520AbVLAW5c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932520AbVLAW5c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 17:57:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932543AbVLAW5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 17:57:32 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:18252 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S932520AbVLAW5b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 17:57:31 -0500
Subject: Re: Linux 2.6.15-rc4
From: Kasper Sandberg <lkml@metanurb.dk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0512011101400.3099@g5.osdl.org>
References: <Pine.LNX.4.64.0511302234020.3099@g5.osdl.org>
	 <1133445903.16820.1.camel@localhost>
	 <Pine.LNX.4.64.0512010759571.3099@g5.osdl.org>
	 <1133463473.16820.3.camel@localhost>
	 <Pine.LNX.4.64.0512011101400.3099@g5.osdl.org>
Content-Type: text/plain
Date: Thu, 01 Dec 2005 23:57:25 +0100
Message-Id: <1133477845.16820.7.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-01 at 11:04 -0800, Linus Torvalds wrote:
> 
> On Thu, 1 Dec 2005, Kasper Sandberg wrote:
> >
> > im not sure its a good idea to silence this, because this seems to be a
> > genuine error, the ati proprietary driver is not working.. if i try to
> > use 3d, it will display this message again, and the process trying to
> > use 3d will freeze, and become unkillable.
> 
> Ok, that's a totally different issue. That implies that my emulation of 
> the old behaviour simply isn't working very well.
> 
> Do you have full logs for that machine? In particular, I'd really like to 
> hear whether you have any of those
> 
> 	"<process-name> does an incomplete pfn remapping"
> 
> messages, and what the details were for that case. Same goes for what the 
> page flags and counts were in the "Bad page state at.." messages.

Bad page state at free_hot_cold_page (in process 'X', page b17a1780)
flags:0x80000414 mapping:00000000 mapcount:0 count:0
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

this is everything which doesent normally appear..

it should be noted that this started on -rc2.. :)
> 
> 			Linus
> 

