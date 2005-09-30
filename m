Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030355AbVI3QFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030355AbVI3QFF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 12:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030356AbVI3QFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 12:05:05 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:60047 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030355AbVI3QFE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 12:05:04 -0400
Date: Fri, 30 Sep 2005 17:05:03 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel cross-toolchain (Gentoo)
Message-ID: <20050930160503.GK7992@ftp.linux.org.uk>
References: <20050905155522.GA8057@mipter.zuzino.mipt.ru> <20050905160313.GH5155@ZenIV.linux.org.uk> <20050905164712.GI5155@ZenIV.linux.org.uk> <20050905212026.GL5155@ZenIV.linux.org.uk> <20050907183131.GF5155@ZenIV.linux.org.uk> <20050912191744.GN25261@ZenIV.linux.org.uk> <20050912192049.GO25261@ZenIV.linux.org.uk> <20050930120831.GI7992@ftp.linux.org.uk> <20050930125645.GJ7992@ftp.linux.org.uk> <20050930160911.GA24810@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050930160911.GA24810@mipter.zuzino.mipt.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2005 at 08:09:11PM +0400, Alexey Dobriyan wrote:
> 1) Watch for it to install gcc 3.4.*. Chances of successful build are much
>    higher than with 3.3. Use --g switch of crossdev (_especially_ with
>    s390).

Umm...  Is crossdev toolchain with target==host the same as native one?

> 3) re ia64
> 	I was told that "ia64 is known to not cross compile at all due
> 	to the unwind code". #101626.

*snerk*  Read: needs libc headers for ia64.

> 4) re m68k
> 	binutils only. Haven't investigated.

Oh?  Both FC4 (4.0.1) and sarge (3.3.5) handle it without any complications

> 5) re mips64
> 	Ditto.

Same as above

> 6) re mips
> 	Builds OK. Naive allyesconfig with CROSS_COMPILE=mips-... barfs
> 	at me violently mentioning some compiler switches.

mips in mainline doesn't build.

> # crossdev -v -s1 -t powerpc-unknown-linux-gnu
> # crossdev -v -s1 -t powerpc64-unknown-linux-gnu

Actually, powerpc64 can handle ppc32...
> # crossdev -v -s1 -t sparc-unknown-linux-gnu
> # crossdev -v -s1 -t sparc64-unknown-linux-gnu

Same story.
