Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265277AbUATIoO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 03:44:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265296AbUATIoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 03:44:14 -0500
Received: from [66.35.79.110] ([66.35.79.110]:43434 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S265277AbUATIoL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 03:44:11 -0500
Date: Tue, 20 Jan 2004 00:43:52 -0800
From: Tim Hockin <thockin@hockin.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Rusty Russell <rusty@au1.ibm.com>, vatsa@in.ibm.com,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       rml@tech9.net
Subject: Re: CPU Hotplug: Hotplug Script And SIGPWR
Message-ID: <20040120084352.GD15733@hockin.org>
References: <20040120063316.GA9736@hockin.org> <400CCE2F.2060502@cyberone.com.au> <20040120065207.GA10993@hockin.org> <400CD4B5.6020507@cyberone.com.au> <20040120073032.GB12638@hockin.org> <400CDCA1.5070200@cyberone.com.au> <20040120075409.GA13897@hockin.org> <400CE354.8060300@cyberone.com.au> <20040120082943.GA15733@hockin.org> <400CE8DC.70307@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <400CE8DC.70307@cyberone.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 20, 2004 at 07:37:48PM +1100, Nick Piggin wrote:
> (or OOM killed being another that comes to mind)
> 
> It is sometimes inevitable. With that knowledge we should be designing
> for graceful failure.

Don't get me started on OOM killer.  If the OOM killer is killing hotplug
scripts, there's another problem.  What's the chance of hotplug scripts
being the memory hog? :)

That said, I understand what you're saying.  It's rough.

> >But it is a violation of the affinity.  As the kernel we CAN NOT know what
> >the affinity really means.
> 
> Not if the application is designed to handle it. How would hotplug
> scripts make this any different, anyway?

IFF the app is designed to handle it.  The existence of a SIGPWR handler
does not necessarily imply that, though.  a SIGCPU or something might
correlate 1:1 with this, but SIGPWR doesn't.

Solving it from hotplug scripts means the task's affinity is not
automatically violated.  It means the decision to violate the affinity was
made in user-space, probably by the admin, who CAN know what the affinity
means.

> Rusty thought you just wouldn't send it unless the process was handling
> it.

I remembered that after I sent it, sorry. :)
