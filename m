Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262015AbTCLUwA>; Wed, 12 Mar 2003 15:52:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262005AbTCLUud>; Wed, 12 Mar 2003 15:50:33 -0500
Received: from bitmover.com ([192.132.92.2]:17071 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S261944AbTCLUsS>;
	Wed, 12 Mar 2003 15:48:18 -0500
Date: Wed, 12 Mar 2003 12:58:59 -0800
From: Larry McVoy <lm@bitmover.com>
To: Nicolas Pitre <nico@cam.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, Larry McVoy <lm@bitmover.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] BK->CVS (real time mirror)
Message-ID: <20030312205859.GG7275@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Nicolas Pitre <nico@cam.org>, Sam Ravnborg <sam@ravnborg.org>,
	Larry McVoy <lm@bitmover.com>, lkml <linux-kernel@vger.kernel.org>
References: <20030312201416.GA2433@mars.ravnborg.org> <Pine.LNX.4.44.0303121542010.14172-100000@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303121542010.14172-100000@xanadu.home>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 12, 2003 at 03:46:58PM -0500, Nicolas Pitre wrote:
> It seems that some things that should have been attributed to me (or others)
> are listed as from torvalds too.
> 
> Example: drivers/char/tty_io.c
> 
> revision 1.59
> date: 2003/03/04 02:13:05;  author: torvalds;  state: Exp;  lines: +4 -6
> small tty irq race fix
> 
> (Logical change 1.8144)

Yeah, I'm almost there, I'm pretty sure that what is happening is that 
the user name is being picked up from the changeset which is current in
the path.  We extract the user name and put it in the comments but I 
don't see where we set $LOGNAME before doing the ci.

So here's a question.  Suppose we have a series of deltas being clumped
together in a file.  All made by different people.  Whose name wins?
My gut is to sort them, run them through uniq -c, and take the top one.
The other idea is to count up lines inserted/deleted over each delta
and take the user who has done the most work.

Thoughts?
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
