Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274009AbRISGZP>; Wed, 19 Sep 2001 02:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274010AbRISGZF>; Wed, 19 Sep 2001 02:25:05 -0400
Received: from lsmls02.we.mediaone.net ([24.130.1.15]:12015 "EHLO
	lsmls02.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S274009AbRISGYu>; Wed, 19 Sep 2001 02:24:50 -0400
Message-ID: <3BA83A3D.EBB1C568@kegel.com>
Date: Tue, 18 Sep 2001 23:25:01 -0700
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Davide Libenzi <davidel@xmailserver.org>
Subject: Re: [PATCH] /dev/epoll update ...
In-Reply-To: <3BA80108.C830D602@kegel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Kegel wrote:
> 1. it would be very nice to be able to expand the interest list
>    without affecting the currently ready list.  In fact, this may
>    be needed to support existing programs.    A quick look at
>    your code gives me the impression that it would be easy to add
>    a ioctl(kdpfd, EP_REALLOC, newmaxfds) call to do this.  Do you agree?

Aw, crap, nevermind.   Since when you expand the interest list
you can double it, this happens so seldom it doesn't matter that
you have to do EP_FREE + EP_ALLOC + EP_POLL. 

I stand by my other two requests, though (the uniform naming convention
and hands off poll.h).

- Dan
