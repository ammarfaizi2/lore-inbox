Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269404AbRHQBle>; Thu, 16 Aug 2001 21:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269412AbRHQBlX>; Thu, 16 Aug 2001 21:41:23 -0400
Received: from quark.didntduck.org ([216.43.55.190]:41223 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S269404AbRHQBlE>; Thu, 16 Aug 2001 21:41:04 -0400
Message-ID: <3B7B03F5.4020E4C@didntduck.org>
Date: Wed, 15 Aug 2001 19:21:25 -0400
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Airlie <airlied@skynet.ie>
CC: linux-kernel@vger.kernel.org
Subject: Re: old_select vs sys_select
In-Reply-To: <Pine.LNX.4.32.0108152359270.1907-100000@skynet>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Airlie wrote:
> 
> On the VAX port I'm updating my syscalls to match some of the other
> platforms,
> 
> why do some platforms defined old_select and some just use sys_ni_syscall
> for the system call number for the old_select... is this purely to deal
> with old applications that were compiled against old kernels, and so this
> means I don't have to implement old_select on the VAX at all..
> 
> Dave.

It's for handling older versions of libc (or applications that are
statically linked).  If you're starting from ground zero, forget about
any of that compatability cruft, as you will never encounter it for a
new port.

--

				Brian Gerst
