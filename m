Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261433AbUKOEsn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261433AbUKOEsn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 23:48:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261437AbUKOEsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 23:48:43 -0500
Received: from fw.osdl.org ([65.172.181.6]:30400 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261433AbUKOEsl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 23:48:41 -0500
Date: Sun, 14 Nov 2004 20:48:22 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.10-rc2 doesn't boot
In-Reply-To: <20041115040710.GA2235@stusta.de>
Message-ID: <Pine.LNX.4.58.0411142040470.2222@ppc970.osdl.org>
References: <Pine.LNX.4.58.0411141835150.2222@ppc970.osdl.org>
 <20041115040710.GA2235@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 15 Nov 2004, Adrian Bunk wrote:
> io scheduler deadline registered
> io scheduler cfq registered
> 
> ---->  2.6.10-rc2 stops here
> 
> loop: loaded (max 8 devices)

Strange. There is not a lot in between those two registrations. The "cfq 
registered" comes from cfq_init(), and the "loop: loaded" thing comes from 
loop_init(), and in between them in the link there is just floppy.o.

And I don't see that _any_ of those three has changed. Yes, cfq got an 
__exit added to its exit function, and floppy got __initdata added, but 
neither of those should make any difference what-so-ever.

Just for interest, what happens if you disable floppy support? It doesn't 
look like you have a floppy on that system..

		Linus
