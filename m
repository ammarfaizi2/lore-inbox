Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262080AbUDDB2k (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 20:28:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262103AbUDDB2k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 20:28:40 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:56200 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S262080AbUDDB2j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 20:28:39 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sat, 3 Apr 2004 17:28:36 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Jamie Lokier <jamie@shareable.org>
cc: Ben Mansell <ben@zeus.com>, Steven Dake <sdake@mvista.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Is POLLHUP an input-only or bidirectional condition? (was: epoll
 reporting events when it hasn't been asked to)
In-Reply-To: <20040403223541.GB6122@mail.shareable.org>
Message-ID: <Pine.LNX.4.44.0404031723570.2710-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Apr 2004, Jamie Lokier wrote:

> Btw, I notice epoll never reports POLLNVAL.  Is that correct?

Yep, epoll does not allow you to push an invalid/unopen file descriptor 
inside the set. So you get an EBADF from epoll_ctl().



- Davide


