Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262821AbSKRQGB>; Mon, 18 Nov 2002 11:06:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262824AbSKRQGB>; Mon, 18 Nov 2002 11:06:01 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:29910 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S262821AbSKRQF6>; Mon, 18 Nov 2002 11:05:58 -0500
Date: Mon, 18 Nov 2002 11:12:59 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: [rfc] epoll interface change and glibc bits ...
Message-ID: <20021118111259.A27455@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <Pine.LNX.4.44.0211180753090.979-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0211180753090.979-100000@blue1.dev.mcafeelabs.com>; from davidel@xmailserver.org on Mon, Nov 18, 2002 at 08:05:32AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2002 at 08:05:32AM -0800, Davide Libenzi wrote:
> 
> 1) epoll's event structure extension
> 
> I received quite a few request to extend the event structure to have space
> for an opaque user data object. The eventpoll event structure will turn to
> be :
> 
> struct epollfd {
> 	int fd;
> 	unsigned short int events, revents;
> 	unsigned long obj;

Cannot this be uint64_t obj; ?
Have mercy with 32<->64 bit translation layers in the kernel.

	Jakub
