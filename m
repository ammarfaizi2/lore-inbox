Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264664AbTFAQdL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 12:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264666AbTFAQdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 12:33:11 -0400
Received: from miranda.zianet.com ([216.234.192.169]:24841 "HELO
	miranda.zianet.com") by vger.kernel.org with SMTP id S264664AbTFAQdJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 12:33:09 -0400
Subject: Re: Question about style when converting from K&R to ANSI C.
From: Steven Cole <elenstev@mesatop.com>
To: Larry McVoy <lm@bitmover.com>
Cc: Jonathan Lundell <linux@lundell-bros.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20030601161133.GC3012@work.bitmover.com>
References: <1054446976.19557.23.camel@spc>
	 <20030601132626.GA3012@work.bitmover.com>
	 <20030601134942.GA10750@alpha.home.local>
	 <20030601140602.GA3641@work.bitmover.com>
	 <p05210609baffd3a79cfb@[207.213.214.37]>
	 <20030601161133.GC3012@work.bitmover.com>
Content-Type: text/plain
Organization: 
Message-Id: <1054485978.19557.93.camel@spc>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 01 Jun 2003 10:46:19 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-06-01 at 10:11, Larry McVoy wrote:
> On Sun, Jun 01, 2003 at 09:04:22AM -0700, Jonathan Lundell wrote:
> > The reason I've liked this format is that it gives me a quick and 
> > universal way to find *specific* functions with vi or grep, by 
> > searching for "^function_name(".
> 
> Exactly.  I thought of making that point in my original posting and 
> figured everyone would tell me to use tags and I didn't want to have
> to remember all the other reasons I wanted this.
> 
> It really is nice knowing that "^function_name(" is the definition.

Thanks for the input.  You've convinced me.  When going through
arch/ppc/xmon/xmon.c, I will leave things like the following unchanged:

/* Command interpreting routine */
static int
cmds(struct pt_regs *excp)
{

My changes will be similar to the following:

@@ -1837,9 +1818,7 @@
        return *lineptr++;
 }

-void
-take_input(str)
-char *str;
+void take_input(char *str)
 {
        lineptr = str;
 }

I'll be changing the return type/function name line orientation only
when making other changes. And these will still go through the
applicable maintainers.

Steven

