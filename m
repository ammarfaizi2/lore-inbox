Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264855AbSJVRwW>; Tue, 22 Oct 2002 13:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264861AbSJVRwW>; Tue, 22 Oct 2002 13:52:22 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:43962 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264855AbSJVRwU>; Tue, 22 Oct 2002 13:52:20 -0400
Subject: Re: epoll (was Re: [PATCH] async poll for 2.5)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Mark Mielke <mark@mark.mielke.cc>,
       "Charles 'Buck' Krasic" <krasic@acm.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>
In-Reply-To: <Pine.LNX.4.44.0210221043420.1563-100000@blue1.dev.mcafeelabs.com>
References: <Pine.LNX.4.44.0210221043420.1563-100000@blue1.dev.mcafeelabs.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 22 Oct 2002 19:13:35 +0100
Message-Id: <1035310415.31873.120.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-10-22 at 18:47, Davide Libenzi wrote:
> Since the sys_epoll ( and /dev/epoll ) fd support standard polling, you
> can mix sys_epoll handling with other methods like poll() and the AIO's
> POLL function when it'll be ready. For example, for devices that sys_epoll
> intentionally does not support, you can use a method like :

The more important question is why do you need epoll. asynchronous I/O
completions setting a list of futexes can already be made to do the job
and is much more flexible.

