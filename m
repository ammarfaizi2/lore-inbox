Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262884AbSKRQIQ>; Mon, 18 Nov 2002 11:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262913AbSKRQIQ>; Mon, 18 Nov 2002 11:08:16 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:30341 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S262884AbSKRQIP>; Mon, 18 Nov 2002 11:08:15 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 18 Nov 2002 08:15:39 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Jakub Jelinek <jakub@redhat.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: [rfc] epoll interface change and glibc bits ...
In-Reply-To: <20021118111259.A27455@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.44.0211180814560.979-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Nov 2002, Jakub Jelinek wrote:

> On Mon, Nov 18, 2002 at 08:05:32AM -0800, Davide Libenzi wrote:
> >
> > 1) epoll's event structure extension
> >
> > I received quite a few request to extend the event structure to have space
> > for an opaque user data object. The eventpoll event structure will turn to
> > be :
> >
> > struct epollfd {
> > 	int fd;
> > 	unsigned short int events, revents;
> > 	unsigned long obj;
>
> Cannot this be uint64_t obj; ?
> Have mercy with 32<->64 bit translation layers in the kernel.

Maybe this :

typedef void *epoll_obj_t;




- Davide


