Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263396AbUJ2PDC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263396AbUJ2PDC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 11:03:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263405AbUJ2O6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 10:58:22 -0400
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:48780 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S263342AbUJ2OwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 10:52:09 -0400
From: Blaisorblade <blaisorblade_spam@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] Re: Why UML often does not build (was: Re: [PATCH] UML: Build fix for TT w/o SKAS)
Date: Fri, 29 Oct 2004 16:53:02 +0200
User-Agent: KMail/1.7.1
Cc: Werner Almesberger <wa@almesberger.net>, Chris Wedgwood <cw@f00f.org>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Jeff Dike <jdike@addtoit.com>
References: <20041027053602.GB30735@taniwha.stupidest.org> <20041029002831.GD12434@taniwha.stupidest.org> <20041029034444.A24523@almesberger.net>
In-Reply-To: <20041029034444.A24523@almesberger.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410291653.02985.blaisorblade_spam@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 29 October 2004 08:44, Werner Almesberger wrote:
> Chris Wedgwood wrote:
> > the problem here is that ptrace semantics are not well defined to
> > anything subtle can and will break from time to time
>
> I wonder what the "correct" solution for this would be: write a
> specification for Linux ptrace, or try to get the POSIX folks
> interested ?

> Given that we get subtle ptrace breakages quite regularly, it
> would be nice to see this eventually get resolved. "The
> implementation is the specification" doesn't seem to work well
> in this case.
Well, you are quite right - Linux is aimed at never breaking existing 
binaries, and ptrace() does not follow that.

However, the problem here is that UML was not behaving correctly. Instead of 
using the documented way, PTRACE_KILL, we just sent a SIGKILL and that 
happened to work (and since PTRACE_KILL implementation just sends a SIGKILL, 
you would still expect it to work).

In fact, I fixed the Gerd Knorr test program to use PTRACE_KILL and it works 
on 2.6.9.

> BTW, things have improved around UML quite a bit recently, and I
> think this is to no small amount due to Paolo's work.
Thanks a lot for that, it's something very important for me, but I'm not the 
only one deserving such recognition. See the amount of work done by Bodo 
Stroesser in a few weeks - he solved lots of problems which I fought against 
without success.

Besides that, I need to do a lot of janitorial work, while holding on more 
advanced stuff - so I think that anybody could be able to help here.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
