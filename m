Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261563AbUKGJ0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbUKGJ0h (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 04:26:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261564AbUKGJ0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 04:26:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:37028 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261563AbUKGJ0f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 04:26:35 -0500
X-Authenticated: #420190
Message-ID: <418DEA55.2080202@gmx.net>
Date: Sun, 07 Nov 2004 10:26:45 +0100
From: Marko Macek <marko.macek@gmx.net>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andries Brouwer <aebr@win.tue.nl>
CC: Andrew Morton <akpm@osdl.org>, Nick Piggin <piggin@cyberone.com.au>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] Remove OOM killer ...
References: <20041105200118.GA20321@logos.cnet> <20041106125317.GB9144@pclin040.win.tue.nl>
In-Reply-To: <20041106125317.GB9144@pclin040.win.tue.nl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer wrote:

> I have always been surprised that so few people investigated
> doing things right, that is, entirely without OOM killer.

Agreed.

> This is not in a state such that I would like to submit it,
> but I think it would be good to focus some energy into
> offering a Linux that is guaranteed free of OOM surprises.

A good thing would be to make the OOM killer only kill
processes that actually overcommit (independant of overcommit mode).

The first step would be adding a value in /proc/$pid/...
somewhere that shows how much a process is overcommitted when
overcommit is enabled. This would allow important processes to be
fixed for all overcommit modes.


	MArk
