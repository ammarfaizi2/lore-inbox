Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132246AbRALRfy>; Fri, 12 Jan 2001 12:35:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132289AbRALRfe>; Fri, 12 Jan 2001 12:35:34 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:41999 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S132246AbRALRfZ>; Fri, 12 Jan 2001 12:35:25 -0500
Date: Fri, 12 Jan 2001 09:35:14 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Richard A Nelson <cowboy@vnet.ibm.com>,
        "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>,
        Andi Kleen <ak@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.1-pre1 breaks XFree 4.0.2 and "w"
In-Reply-To: <20010112180556.J2766@athlon.random>
Message-ID: <Pine.LNX.4.10.10101120931520.1806-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 12 Jan 2001, Andrea Arcangeli wrote:

> On Fri, Jan 12, 2001 at 11:42:32AM -0500, Richard A Nelson wrote:
> > 
> > Its fine either way on current x86 and many other platforms, but falls
> > on its face in the presence of asymetric MP.
> 
> Point taken, feel free to have a can_I_use per-cpu instead of global but don't
> overwrite the cpu_has with it. 

Andrea, the whole POINT of "cpu_has_xxx" is for the kernel to test for
features like this.

If you're not going to overwrite it when some feature is deemed disabled,
you're missing the whole _reason_ for having capabilities bitmaps in the
first place.

This is not negotiable. We used to have a damn mess in 2.2.x with all the
capabilities stuff, and 2.4.x finally cleans it up and gets it right
across different CPU's, exactly because we have a clean "this CPU can do
X" approach without any if's, but's and why's. 

The fact that 2.2.x has bad control over capabilities and is messy is NOT
an excuse to screw up forever. 

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
