Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261389AbVAMTYU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261389AbVAMTYU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 14:24:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261383AbVAMTX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 14:23:29 -0500
Received: from [81.23.229.73] ([81.23.229.73]:29387 "EHLO mail.eduonline.nl")
	by vger.kernel.org with ESMTP id S261387AbVAMTWG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 14:22:06 -0500
From: Norbert van Nobelen <norbert-kernel@edusupport.nl>
Organization: EduSupport BV
To: John Richard Moser <nigelenki@comcast.net>
Subject: Re: thoughts on kernel security issues
Date: Thu, 13 Jan 2005 20:22:03 +0100
User-Agent: KMail/1.6.2
References: <Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org> <Pine.LNX.4.58.0501130926260.2310@ppc970.osdl.org> <41E6C507.5050302@comcast.net>
In-Reply-To: <41E6C507.5050302@comcast.net>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200501132022.03472.norbert-kernel@edusupport.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 13 January 2005 19:59, you wrote:
> Linus Torvalds wrote:
> > On Thu, 13 Jan 2005, Alan Cox wrote:
> >>On Iau, 2005-01-13 at 16:38, Linus Torvalds wrote:
>
> [...]
>
> > Am I claiming that disallowing self-written ELF binaries gets rid of all
> > security holes? Obviously not. I'm claiming that there are things that
> > people can do that make it harder, and that _real_ security is not about
> > trusting one subsystem, but in making it hard enough in many independent
> > ways that it's just too effort-intensive to attack.
>
> I think you can make it non-guaranteeable.
>
> > It's the same thing with passwords. Clearly any password protected system
> > can be broken into: you just have to guess the password. It then becomes
> > a matter of how hard it is to "guess" - at some point you say a password
> > is secure not because it is a password, but because it's too _expensive_
> > to guess/break.
>
> You can't guarantee you can guess a password.  You could for example
> write a pam module that mandates a 3 second delay on failed
> authentication for a user (it does it for the console currently; use 3
> separate consoles and you can do the attack 3 times faster).  Now you
> have to guess the password with one try every 3 seconds.

Already done, actually standard practice. This does not mean actually that you 
can not guess a password, just that it will take longer (on average).
Luck and some knowledge about the system and people speeds up the process, so 
the standard procedure if you really want to get into a system with a 
password is to get information.


>
> aA1# 96 possible values per character, 8 characters.  7.2139x10^15
> combinations.  It takes 686253404.7 years to go through all those at one
> every 3 seconds.  You've got a good chance at half that.
>
> This isn't "hard," it's "infeasible."  I think the idea is to make it so
> an attacker doesn't have to put lavish amounts of work into creating an
> exploit that reliably re-exploits a hole over and over again; but to
> make it so he can't make an exploit that actually works, unless it works
> only by rediculously remote chance.
>
> > So all security issues are about balancing cost vs gain. I'm convinced
> > that the gain from openness is higher than the cost. Others will
> > disagree.
>
> Yes.  Nobody code audits your binaries.  You need source code to do
> source code auditing.  :)
>
> > 		Linus
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> > in the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/

-- 
<a href="http://www.edusupport.nl">EduSupport: Linux Desktop for schools and 
small to medium business in The Netherlands and Belgium</a>
