Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129166AbRCOWnG>; Thu, 15 Mar 2001 17:43:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129197AbRCOWmz>; Thu, 15 Mar 2001 17:42:55 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11533 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S129166AbRCOWmu>;
	Thu, 15 Mar 2001 17:42:50 -0500
Date: Thu, 15 Mar 2001 22:41:25 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: Art Boulatov <art@ksu.ru>, linux-kernel@vger.kernel.org
Subject: Re: pivot_root & linuxrc problem
Message-ID: <20010315224125.C7500@flint.arm.linux.org.uk>
In-Reply-To: <3AB0C09A.1020505@ksu.ru> <Pine.LNX.4.33.0103152143320.928-100000@mikeg.weiden.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0103152143320.928-100000@mikeg.weiden.de>; from mikeg@wen-online.de on Thu, Mar 15, 2001 at 10:11:55PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2001 at 10:11:55PM +0100, Mike Galbraith wrote:
> On Thu, 15 Mar 2001, Art Boulatov wrote:
> 
> > How can I "exec /sbin/init" from "/linuxrc", whatever it is,
> > if "linuxrc" does not get PID=1?
> >
> > Actually, why does NOT "linuxrc" get PID=1?
> 
> That's the question.. the first task started gets pid=1, and when
> that is true, exec /sbin/init has no problem.  What else is your
> system starting?.. it must be starting something.

Linux always forks from PID1 before executing /linuxrc automagically.
Check init/main.c.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

