Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261173AbVCABPh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261173AbVCABPh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 20:15:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261182AbVCABPe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 20:15:34 -0500
Received: from fire.osdl.org ([65.172.181.4]:23171 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261173AbVCABPZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 20:15:25 -0500
Date: Mon, 28 Feb 2005 17:16:35 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [andrea@cpushare.com: Re: [Twisted-Python] linux kernel 2.6.11-rc
 broke twisted process pipes]
In-Reply-To: <20050301010728.GX8880@opteron.random>
Message-ID: <Pine.LNX.4.58.0502281714420.25732@ppc970.osdl.org>
References: <20050301010728.GX8880@opteron.random>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 1 Mar 2005, Andrea Arcangeli wrote:
> 
> I tend to agree that previously it was working by luck, and I suspect
> it's still working by luck in openbsd too, since openbsd seem to do very
> similar to what linux was doing in 2.6.5-rc11 (and 2.6.5-rc11 made a lot
> more sense than 2.6.9 and previous)

I assume you mean 2.6.11-rc5, not 2.6.5-rc11.

> http://www.opengroup.org/onlinepubs/007908799/xsh/poll.html
> 
> POLLIN
>  Data other than high-priority data may be read without blocking. [..]
> POLLRDNORM
>  Normal data (priority band equals 0) may be read without blocking. [..]
> 
> btw, I don't really know the difference of POLLIN and POLLRDNORM

As you say, for pipes, none. It only matters on sockets that can have
urgent data (aka oob - out-of-band data).

		Linus
