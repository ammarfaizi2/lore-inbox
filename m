Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269262AbUJQSc5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269262AbUJQSc5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 14:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269265AbUJQSc5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 14:32:57 -0400
Received: from witte.sonytel.be ([80.88.33.193]:24557 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S269262AbUJQScz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 14:32:55 -0400
X-Return-Path: <joe@perches.com>
Subject: Re: [PATCH 0/8] replacing/fixing printk with pr_debug/pr_info in
	arch/i386 - intro
From: Joe Perches <joe@perches.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
In-Reply-To: <Pine.GSO.4.61.0410172006060.27743@waterleaf.sonytel.be>
References: <1098031764.3023.45.camel@pdp11.tsho.org>
	<20041017161953.GA24810@elte.hu>
	<Pine.GSO.4.61.0410172006060.27743@waterleaf.sonytel.be>
Content-Type: text/plain
Date: Sun, 17 Oct 2004 11:23:42 -0700
Message-Id: <1098037422.20419.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
X-Spambayes-Classification: ham; 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-10-17 at 20:10 +0200, Geert Uytterhoeven wrote:
> Iff you ever want to replace the above, make sure to do it like this:
>     printk_info("Start... ");
>     ...
>     printkc_info("Ok!\n");
> 
> (with `printkc_info()' being a continuation of `printk_info()'. And do the same
> for all other KERN_* variations. This would add real value, since the next step
> is to make the printk{,c}_*() definitions conditionally empty for embedded
> systems and/or systems with few memory.
> 
> Gr{oetje,eeting}s,

I suggest this is the incorrect usage.
Start then Continue then End.
I suppose one could use Continue/End with an implied start
or simply End (ie:  printk)

cheers,  joe
