Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265256AbSJWWQ0>; Wed, 23 Oct 2002 18:16:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265254AbSJWWQZ>; Wed, 23 Oct 2002 18:16:25 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:45473 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S265265AbSJWWPU>; Wed, 23 Oct 2002 18:15:20 -0400
X-AuthUser: davidel@xmailserver.org
Date: Wed, 23 Oct 2002 15:30:28 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Dan Kegel <dank@kegel.com>
cc: linux-aio <linux-aio@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: async poll
In-Reply-To: <3DB721B1.7090907@kegel.com>
Message-ID: <Pine.LNX.4.44.0210231528580.1581-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Oct 2002, Dan Kegel wrote:

> John Gardiner Myers wrote:
> >
> > Dan Kegel wrote:
> >
> >> In that situation, why not just add the fd to an epoll, and have the
> >> epoll deliver events through Ben's interface?
> >
> >
> > Because you might need to use the aio_data facility of the iocb
> > interface.
>
> Presumably epoll_add could be enhanced to let user specify a user data
> word.

It'll take 2 minutes to do such a thing. Actually the pollfd struct
contains the "events" field that is wasted when returning events and it
could be used for something more useful.



- Davide


