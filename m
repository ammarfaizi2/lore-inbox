Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263006AbUDARvJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 12:51:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263010AbUDARvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 12:51:09 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:60838 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S263006AbUDARvG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 12:51:06 -0500
X-AuthUser: davidel@xmailserver.org
Date: Thu, 1 Apr 2004 09:51:02 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Ben <ben@zeus.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: epoll reporting events when it hasn't been asked to
In-Reply-To: <Pine.LNX.4.58.0404011731290.4013@stones.cam.zeus.com>
Message-ID: <Pine.LNX.4.44.0404010947490.2509-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Apr 2004, Ben wrote:

> This is odd. The epoll_ctl() got rid of all events for FD 7, yet the
> epoll_wait() following it returns event 16 (EPOLLHUP). Is this a bug?
> I don't normally see this behaviour for most connections, is it perhaps
> to do with the read returning ECONNRESET ?

It is a feature. epoll OR user events with POLLHUP|POLLERR so that even if 
the user sets the event mask to zero, it can still know when something 
like those abnormal condition happened. Which problem do you see with this?



- Davide


