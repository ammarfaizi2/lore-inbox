Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264864AbSJVWKl>; Tue, 22 Oct 2002 18:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264906AbSJVWKl>; Tue, 22 Oct 2002 18:10:41 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:56991 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S264864AbSJVWKl>; Tue, 22 Oct 2002 18:10:41 -0400
X-AuthUser: davidel@xmailserver.org
Date: Tue, 22 Oct 2002 15:25:39 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Erich Nahum <nahum@watson.ibm.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>
Subject: Re: epoll (was Re: [PATCH] async poll for 2.5)
In-Reply-To: <200210222154.RAA29096@orinoco.watson.ibm.com>
Message-ID: <Pine.LNX.4.44.0210221521230.1563-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Oct 2002, Erich Nahum wrote:

> There is a third way, described in the original Banga/Mogul/Druschel
> paper, available via Dan Kegel's web site: extend the accept() call to
> return whether an event has already happened on that FD.  That way you
> can service a ready FD without reading /dev/epoll or calling
> sigtimedwait, and you don't have to waste a read() call on the socket
> only to find out you got EAGAIN.
>
> Of course, this changes the accept API, which is another matter.  But
> if we're talking a new API then there's no problem.

Why differentiate between connect and accept. At that point you should
also handle connect as a particular case, that's the point. And that's why
I like the API's rule to be consistent and I would not like to put inside
the kernel source code explicit event dispatch inside accept/connect.



- Davide


