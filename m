Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269776AbUJGKHu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269776AbUJGKHu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 06:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267370AbUJGKHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 06:07:49 -0400
Received: from brown.brainfood.com ([146.82.138.61]:38801 "EHLO
	gradall.private.brainfood.com") by vger.kernel.org with ESMTP
	id S269777AbUJGKHe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 06:07:34 -0400
Date: Thu, 7 Oct 2004 05:07:26 -0500 (CDT)
From: Adam Heath <doogie@debian.org>
X-X-Sender: adam@gradall.private.brainfood.com
To: Martijn Sipkema <martijn@entmoot.nl>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
In-Reply-To: <021b01c4ac59$cbe92ea0$161b14ac@boromir>
Message-ID: <Pine.LNX.4.58.0410070506400.1194@gradall.private.brainfood.com>
References: <4164CB02.2030607@kegel.com> <20041007080414.GA28999@outpost.ds9a.nl>
 <Pine.LNX.4.58.0410070328010.1194@gradall.private.brainfood.com>
 <021b01c4ac59$cbe92ea0$161b14ac@boromir>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Oct 2004, Martijn Sipkema wrote:

> > > It does not matter - this behaviour should not be depended upon. There are
> > > lots of other reasons why a packet might in fact not be available, kernels
> > > are allowed to drop UDP packets at will.
> >
> > I've been lurking and reading this thread with great interest.  I had been
> > leaning towards thinking the kernel was wrong, until I read this email.
> >
> > This is a very excellent point.
>
> No, it isn't. If the kernel drops a UDP packet, select() should not return
> indicating available data.

The kernel can drop a packet after select() returns, and before read() is
called.  That's the whole point of *U*DP.
