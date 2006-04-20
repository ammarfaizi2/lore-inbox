Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751202AbWDTGof@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbWDTGof (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 02:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbWDTGoe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 02:44:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:16359 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751202AbWDTGoe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 02:44:34 -0400
X-Authenticated: #14349625
Subject: Re: 2.6.16.1 & D state processes
From: Mike Galbraith <efault@gmx.de>
To: Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060420055422.37845.qmail@web52610.mail.yahoo.com>
References: <20060420055422.37845.qmail@web52610.mail.yahoo.com>
Content-Type: text/plain
Date: Thu, 20 Apr 2006 08:45:21 +0200
Message-Id: <1145515521.9712.8.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-04-20 at 15:54 +1000, Srihari Vijayaraghavan wrote:
> A couple of interesting things I've noticed after its
> recovery:
> 1. Executing "time sleep 1", takes more than 1 second.
> It reports real as 3 to 5 seconds, while my stop watch
> measures it as closer to 50 seconds.

Ah.  Something bad happened to time keeping, and that likely screwed up
(time dependent) io, not the other way around.

> 2. Pressing & holding a key at the console doesn't
> produce repeating characters.
> 
> Thought they might shed some light on the problem. (I
> ought to look at all the RTC & Time related settings
> between my minimal .config & FC5's, for I believe
> they're connected.)

Good idea.  What time source are you using?  I'd try plain old pit.

	-Mike

(As an aside, I suspect you're going to find that you've got dodgy
hardware.) 

