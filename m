Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285099AbSAGTEj>; Mon, 7 Jan 2002 14:04:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285229AbSAGTE3>; Mon, 7 Jan 2002 14:04:29 -0500
Received: from quark.didntduck.org ([216.43.55.190]:3856 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S285099AbSAGTEO>; Mon, 7 Jan 2002 14:04:14 -0500
Message-ID: <3C39F11F.35C88B2D@didntduck.org>
Date: Mon, 07 Jan 2002 14:03:59 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: mingo@elte.hu
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch] O(1) scheduler, -D1, 2.5.2-pre9, 2.4.17
In-Reply-To: <Pine.LNX.4.33.0201072122290.14092-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> 
> -D1 is a quick update over -D0:
> 
>         http://redhat.com/~mingo/O(1)-scheduler/sched-O1-2.5.2-D1.patch
>         http://redhat.com/~mingo/O(1)-scheduler/sched-O1-2.4.17-D1.patch
> 
> this should fix the child-inherits-parent-priority-boost issue that causes
> interactivity problems during compilation.
> 
>         Ingo

I noticed in this patch that you removed the rest_init() function.  The
reason it was split from start_kernel() is that there was a race where
init memory could be freed before the call to cpu_idle().  Note that
start_kernel() is marked __init and rest_init() is not.

--

				Brian Gerst
