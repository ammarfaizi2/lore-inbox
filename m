Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262794AbVAQNQu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262794AbVAQNQu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 08:16:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262795AbVAQNQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 08:16:50 -0500
Received: from galaxy.systems.pipex.net ([62.241.162.31]:8650 "EHLO
	galaxy.systems.pipex.net") by vger.kernel.org with ESMTP
	id S262794AbVAQNQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 08:16:48 -0500
Date: Mon, 17 Jan 2005 13:17:51 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
X-X-Sender: tigran@ezer.homenet
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [discuss] booting a kernel compiled with -mregparm=0
In-Reply-To: <m11xckwcci.fsf@muc.de>
Message-ID: <Pine.LNX.4.61.0501171315460.4644@ezer.homenet>
References: <Pine.LNX.4.61.0501141623530.3526@ezer.homenet>
 <20050114205651.GE17263@kam.mff.cuni.cz> <Pine.LNX.4.61.0501141613500.6747@chaos.analogic.com>
 <cs9v6f$3tj$1@terminus.zytor.com> <Pine.LNX.4.61.0501170909040.4593@ezer.homenet>
 <m11xckwcci.fsf@muc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

On Mon, 17 Jan 2005, Andi Kleen wrote:
> The ABI supported way is to read the DWARF2 unwind tables. For that
> you would a dwarf2 reader.  gdb does that in user space, and libgcc2
> also does it for exception unwinding. IA64 has an in kernel dwarf2
> reader library (and ia64 kdb uses it), although it would probably need
> some work to make it work on x86-64.
>
> So far nobody wanted it enough to do the porting work though.

Thank you for the pointer. I will look at it and see if I can try to port 
it to x86_64, since that is the standard and official way. I admit that I 
didn't realize that the "magic stuff" which gdb does is in fact a dwarf2 
implementation (and this is what's missing in kdb on x86_64).

Kind regards
Tigran
