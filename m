Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267232AbUJIRFn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267232AbUJIRFn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 13:05:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267235AbUJIRFn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 13:05:43 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:65235 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S267232AbUJIRFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 13:05:14 -0400
Subject: Re: Inconsistancies in /proc (status vs statm) leading
	to	wrong	documentation (proc.txt)
From: Albert Cahalan <albert@users.sf.net>
To: eric.valette@free.fr
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <416815FD.2060502@free.fr>
References: <1097329771.2674.4036.camel@cube>  <4167F0D7.3020502@free.fr>
	 <1097339477.2669.4212.camel@cube>  <416815FD.2060502@free.fr>
Content-Type: text/plain
Organization: 
Message-Id: <1097341175.2669.4257.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 09 Oct 2004 12:59:35 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-10-09 at 12:46, Eric Valette wrote:
> Albert Cahalan wrote:
> 
> >>Well the Documentation is said to matches 2.6.8-rc3 and is only 5 weeks 
> >>old according to bitkeeper changesets... So at least the doc should be 
> >>fixed.
> > 
> > 
> > Removal would be simpler.
> 
> I beg to disagree. statm catche eyes when you want to know precisely 
> your memory usage or do you consider to be the single statm user via procps?

Not quite, but close. Those that know are willing
to read the kernel code, including that of past
releases, can certainly use the statm file.

> > I could go for another number: available address space.
> > Then I could display percent used.
> 
> The free command does provide the information I think so it must be 
> somewhere else...

Not at all. The free command is not per-process,
and doesn't ever deal with address space. It deals
with RAM.

For example, on a typical i386 box, you have almost
3 GB of address space available. (minus a bit at the
top for syscall handling, and perhaps minus a page at
address 0) The portion of this in use is of interest.

> > Even the other files are only partly for humans.
> > Minor changes will cause many tools to break.
> 
> Sure but many people in the embedded wolrd need to know precisley 
> process memory usage and possibly inside the program itsel not via 
> top/ps/free/...

For that, go directly to /proc/*/maps and be happy.
You may also want the RSS from /proc/*/status.


