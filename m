Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129040AbQJ3QGw>; Mon, 30 Oct 2000 11:06:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129133AbQJ3QGe>; Mon, 30 Oct 2000 11:06:34 -0500
Received: from serenity.mcc.ac.uk ([130.88.200.93]:6163 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S129040AbQJ3QG2>; Mon, 30 Oct 2000 11:06:28 -0500
Date: Mon, 30 Oct 2000 16:06:25 +0000 (GMT)
From: John Levon <moz@compsoc.man.ac.uk>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: kmalloc() allocation.
In-Reply-To: <Pine.LNX.3.95.1001030104956.735A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.21.0010301605380.14174-100000@mrworry.compsoc.man.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2000, Richard B. Johnson wrote:

> 
> Hello,
> How much memory would it be reasonable for kmalloc() to be able
> to allocate to a module?
> 
> Oct 30 10:48:31 chaos kernel: kmalloc: Size (524288) too large 
> 
> Using Version 2.2.17, I can't allocate more than 64k!  I need
> to allocate at least 1/2 megabyte and preferably more (like 2 megabytes).
> 
> There are 256 megabytes of SDRAM available. I don't think it's
> reasonable that a 1/2 megabyte allocation would fail, especially
> since it's the first module being installed.
> 
> The attempt to allocate is memory of type GFP_KERNEL.

Why do you need physically-contiguous memory ? Can you not just use
vmalloc()/vfree()

john

-- 
"It's not that the suggestions are not good ideas.  That problem is that
 committees cannot say no to good ideas, while the one thing that matters
 above all in any design task is saying no to almost everything." 
	- Vern Schryver 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
