Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264601AbTFANwu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 09:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264632AbTFANwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 09:52:50 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:3525 "EHLO smtp.bitmover.com")
	by vger.kernel.org with ESMTP id S264601AbTFANwp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 09:52:45 -0400
Date: Sun, 1 Jun 2003 07:06:02 -0700
From: Larry McVoy <lm@bitmover.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: Larry McVoy <lm@bitmover.com>, Steven Cole <elenstev@mesatop.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Question about style when converting from K&R to ANSI C.
Message-ID: <20030601140602.GA3641@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Willy Tarreau <willy@w.ods.org>, Larry McVoy <lm@bitmover.com>,
	Steven Cole <elenstev@mesatop.com>, linux-kernel@vger.kernel.org
References: <1054446976.19557.23.camel@spc> <20030601132626.GA3012@work.bitmover.com> <20030601134942.GA10750@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030601134942.GA10750@alpha.home.local>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Sometimes it is nice to be able to see function names with a 
> > 
> > 	grep '^[a-zA-Z].*(' *.c
> 
> This will return 'int foo(void)', what's the problem ?

You get a lot of other false hits, like globals.  I don't feel strongly
about this, I'm more wondering why this style was choosen.  The way
I showed is pretty common,  it's sort of the "Unix" way (it's how the
original Unix guys did it, how BSD did it, and how the GNU guys do it), so
it's a somewhat surprising difference.  I've never understood the logic.
The more I think about it the less I understand it, doing it that way
means you are more likely to have to wrap a function definition which
is ugly:

static inline int cdrom_write_check_ireason(ide_drive_t *drive, int len, int ireason)
{
}

vs

static inline int
cdrom_write_check_ireason(ide_drive_t *drive, int len, int ireason)
{
}

It may be just what you are used to but I also find that when reading lots
of code it is nice to have it look like

return type
function_name(args)

because the function_name() stands out more, it's always at the left side so
I tend to parse it a little more quickly.

Don't get me wrong, I'm not arguing that you should go reformat all your
code (I tend to agree with Linus, if it's not your code, don't stick your
fingers in there just because you want to reformat it).  All I'm doing
is trying to understand why in this instance did Linux diverage from 
common practice.  
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
