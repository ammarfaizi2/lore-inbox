Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262427AbUCCK30 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 05:29:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262428AbUCCK30
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 05:29:26 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:27805 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S262427AbUCCK3V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 05:29:21 -0500
X-AuthUser: davidel@xmailserver.org
Date: Wed, 3 Mar 2004 02:29:35 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Ben <linux-kernel-junk-email@slimyhorror.com>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fw: epoll and fork()
In-Reply-To: <Pine.LNX.4.58.0403021527360.20736@baphomet.bogo.bogus>
Message-ID: <Pine.LNX.4.44.0403030225480.25251-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Mar 2004, Ben wrote:

> child can close an inherited fd without affecting the parent), simply
> because the only connection a process has with epoll is the file
> descriptor. I suppose if you think of epoll_ctl() and epoll_wait() as
> write()s and read()s on the file descriptor, then it makes sense that
> these operations would affect both processes.

Note that if the parent or the child does close an fd, this does not get 
automatically unregistered from the epoll fd of the other task. An fd can 
be unregistered from an epoll fd either explicitly with an epoll_ctl() or 
implicitly when the use count of the underlying file* goes to zero.



- Davide


