Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267453AbTBRAu6>; Mon, 17 Feb 2003 19:50:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267494AbTBRAu4>; Mon, 17 Feb 2003 19:50:56 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:65290 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267453AbTBRAuz>;
	Mon, 17 Feb 2003 19:50:55 -0500
Date: Tue, 18 Feb 2003 01:00:54 +0000
From: Matthew Wilcox <willy@debian.org>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: fcntl and flock wakeups not FIFO?
Message-ID: <20030218010054.J28902@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[cc'ing the person or list mentioned in MAINTAINERS would get you a better
response :-P]

> I've been doing some experimenting with locking on 2.4.18 and have
> noticed that if I have a number of writers waiting on a lock, they are
> not woken up in the order in which they requested the lock.
> 
> Is this expected? If so, what was the reasoning for this and are there
> any patches to give FIFO wakeups?

That certainly isn't what's supposed to happen.  They should get woken
up in-order.  The code in 2.4.18 seems to be doing that.  Are you doing
anything clever with scheduling?

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
