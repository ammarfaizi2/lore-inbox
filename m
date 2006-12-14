Return-Path: <linux-kernel-owner+w=401wt.eu-S932794AbWLNOXw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932794AbWLNOXw (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 09:23:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932795AbWLNOXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 09:23:52 -0500
Received: from web59212.mail.re1.yahoo.com ([66.196.101.38]:42114 "HELO
	web59212.mail.re1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932794AbWLNOXr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 09:23:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=CvZ4nP9BsUbuILflr2qM3kM/Lelz2EVJ2wE/a3QDWDJ7gEFR88QmcKrzW7FO1O7Hrn05vzHbRuXsRWjys632JaCgNLhCl7Yu+BfqgOjgWXdXAs3osl27kocGzB1XM8f9dBEGWJT2e7d+szAIr93ocmAHO0PaY6i8Y81M4stAjrw=;
X-YMail-OSG: 2yCS._cVM1lEPhGQaIE.q1WWI1yhI5etQRk3O0bx
Date: Thu, 14 Dec 2006 06:23:43 -0800 (PST)
From: tike64 <tike64@yahoo.com>
Subject: Re: realtime-preempt and arm
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <Pine.LNX.4.58.0612140740480.17165@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <813680.16966.qm@web59212.mail.re1.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> wrote:
> ...
> it's ok for the timer to be a little over, but it must never be a
> little under.
> ...
> So we make sure the timer goes off in (n+1) ms, and not just (n).

Ok, this makes sense - thanks.

What confuses / confused me is that I have 4 combinations:
without-rt/with-rt X select/nanosleep; I first tried the
without-rt/select combination and right after that with-rt combinations
skipping the without-rt/nanosleep case. The first one was the one (the
only one) which gives me the 10ms average delay. And after your
explanations that fact bugs me even more.

But that is a side issue. The real problem is now: how do I get rid of
the multi-ms jitter?

--

tike



 
____________________________________________________________________________________
Do you Yahoo!?
Everyone is raving about the all-new Yahoo! Mail beta.
http://new.mail.yahoo.com
