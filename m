Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263088AbUDAT36 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 14:29:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262770AbUDAT3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 14:29:04 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:10152 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S262897AbUDAT2M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 14:28:12 -0500
X-AuthUser: davidel@xmailserver.org
Date: Thu, 1 Apr 2004 11:28:12 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Ben Mansell <ben@zeus.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: epoll reporting events when it hasn't been asked to
In-Reply-To: <Pine.LNX.4.58.0404011909350.3066@stones.cam.zeus.com>
Message-ID: <Pine.LNX.4.44.0404011125510.2509-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Apr 2004, Ben Mansell wrote:

> > It is a feature. epoll OR user events with POLLHUP|POLLERR so that even if
> > the user sets the event mask to zero, it can still know when something
> > like those abnormal condition happened. Which problem do you see with this?
> 
> What should the application do if it gets events that it didn't ask for?
> If you choose to ignore them, the next time epoll_wait() is called it
> will return instantly with these same messages, so the app will spin and
> eat CPU.

Shouldn't the application handle those exceptional conditions instead of 
ignoring them?



> Perhaps it should only OR the user event with POLLHUP|POLLERR if
> POLLIN or POLLOUT is set?

This can certainly be done, since it's a one-liner fix. I'm not sure if it 
is the correct behaviour. Anyone else?



- Davide


