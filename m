Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264791AbSKEFlL>; Tue, 5 Nov 2002 00:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264871AbSKEFlK>; Tue, 5 Nov 2002 00:41:10 -0500
Received: from franka.aracnet.com ([216.99.193.44]:59366 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S264791AbSKEFlI>; Tue, 5 Nov 2002 00:41:08 -0500
Date: Mon, 04 Nov 2002 21:44:07 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: andersen@codepoet.org, Werner Almesberger <wa@almesberger.net>
cc: jw schultz <jw@pegasys.ws>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: ps performance sucks (was Re: dcache_rcu [performance results])
Message-ID: <3838354491.1036446246@[10.10.2.3]>
In-Reply-To: <20021105044216.GA4545@codepoet.org>
References: <20021105044216.GA4545@codepoet.org>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hehe.  You just reinvented my old /dev/ps driver.  :)

Indeed, sounds much more like a /dev thing than a /proc thing
at this point ;-)

> http://www.busybox.net/cgi-bin/cvsweb/busybox/examples/kernel-patches/devps.patch.9_25_2000?rev=1.2&content-type=text/vnd.viewcvs-markup
> 
> This is what Linus has to say on the subject:
> 
> ... If the problem is that /proc
>     is too large, then the right solution is to just clean up
>     /proc.  Which is getting done.  And yes, /proc will be larger
>     than /dev/ps, but I still find that preferable to having two
>     incompatible ways to do the same thing.

Ummm ... how do we make /proc smaller than 1 file to open per PID?
It's pretty easy to get it down that far. But it still sucks.

>     I do dislike /dev/ps mightily.

Well it can't be any worse than the current crap. At least it'd 
stand a chance in hell of scaling a little bit. So I took a very 
quick look ... what syscalls are you reduced to per pid, one ioctl 
and one read?

M.



