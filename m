Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751321AbVHMKa5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbVHMKa5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 06:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbVHMKa5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 06:30:57 -0400
Received: from modeemi.modeemi.cs.tut.fi ([130.230.72.134]:13270 "EHLO
	modeemi.modeemi.cs.tut.fi") by vger.kernel.org with ESMTP
	id S1751321AbVHMKa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 06:30:56 -0400
Date: Sat, 13 Aug 2005 13:30:53 +0300
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Adam Langley <alangley@gmail.com>
Subject: Re: Edge triggered epoll with pts devices acts as level triggered
Message-ID: <20050813103053.GM31158@jolt.modeemi.cs.tut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <396556a20508120419238abca6@mail.gmail.com>
User-Agent: Mutt/1.5.6+20040907i
From: shd@modeemi.cs.tut.fi (Heikki Orsila)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Langley wrote:
>                epoll_wait(epoll_fd, events, 4, -1);
>                write(1, ".", 1);

The test case is faulty. write will trigger the event again infinitely.
fds 0 and 1 are the same in many cases. Try this:

$ ./epolltest > foo

Now you will only get 1 trigger for each input.

-- 
Heikki Orsila			Barbie's law:
heikki.orsila@iki.fi		"Math is hard, let's go shopping!"
http://www.iki.fi/shd
