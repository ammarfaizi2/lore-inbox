Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132327AbRDCCxq>; Mon, 2 Apr 2001 22:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132337AbRDCCxg>; Mon, 2 Apr 2001 22:53:36 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:24839 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S132327AbRDCCxU>; Mon, 2 Apr 2001 22:53:20 -0400
Message-ID: <3AC93AE9.8AF73B94@uow.edu.au>
Date: Mon, 02 Apr 2001 19:52:25 -0700
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.18-0.22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Eric Gillespie <viking@flying-brick.caverock.net.nz>
CC: linux-kernel@vger.kernel.org
Subject: Re: More about 2.4.3 timer problems
In-Reply-To: <Pine.LNX.4.21.0104031038070.4158-100000@brick.flying-brick.caverock.net.nz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Gillespie wrote:
> 
>...
> VESA fb mode 1280x1024x16, clock lost 1m 35s in time
> ...
> Same command, normal (non-fb mode) lost no time off clock.

Is due to the 2.4.3 console drivers.  They block interrupts during
console output.  There's a fix in 2.4.2-ac<recent>.

There's also a patch against 2.4.3-pre6 at

	http://www.uow.edu.au/~andrewm/linux/console.html

If you'd care to test the 2.4.3-pre6 patch for a while, that'd
be useful.

-
