Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264231AbTGGSuK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 14:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264246AbTGGSuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 14:50:10 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:1951 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S264231AbTGGSuH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 14:50:07 -0400
X-AuthUser: davidel@xmailserver.org
Date: Mon, 7 Jul 2003 11:57:02 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Eric Varsanyi <e0216@foo21.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: epoll vs stdin/stdout
In-Reply-To: <20030707154823.GA8696@srv.foo21.com>
Message-ID: <Pine.LNX.4.55.0307071153270.4704@bigblue.dev.mcafeelabs.com>
References: <20030707154823.GA8696@srv.foo21.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jul 2003, Eric Varsanyi wrote:

> It seems reasonable to register for read events on stdin and write events
> on stdout.  In an earlier posting on the epoll API it was asserted that
> anyone registering for events on 2 fd's that shared the same file * was
> asking for trouble.
>
> I can imagine many apps that might want to proxy async traffic thru
> stdin/stdout, what is the intended general solution for this with epoll?
>
> FWIW in my app I'm just assuming that fd0 is a dup of fd1 if EPOLL_CTL_ADD
> on fd1 fails with EEXISTS, then I EPOLL_CTL_MOD on fd0 to add the write event.
> This seems like a bit of a hack tho.

Events caught by epoll comes from a file* since that is the abstraction
the kernel handles. Events really happen on the file* and there's no way
if you dup()ing 1000 times a single fd, to say that events are for fd = 122.



- Davide

