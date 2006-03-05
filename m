Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751921AbWCEXUL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751921AbWCEXUL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 18:20:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752082AbWCEXUL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 18:20:11 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:27916 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751921AbWCEXUJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 18:20:09 -0500
Date: Mon, 6 Mar 2006 00:19:54 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: "Paul D. Smith" <psmith@gnu.org>
Cc: bug-make@gnu.org, LKML <linux-kernel@vger.kernel.org>,
       kbuild-devel@lists.sourceforge.net, Art Haas <ahaas@airmail.net>
Subject: Re: kbuild: Problem with latest GNU make rc
Message-ID: <20060305231954.GA25710@mars.ravnborg.org>
References: <17413.49617.923704.35763@lemming.engeast.baynetworks.com> <20060304214026.GB1539@mars.ravnborg.org> <17419.25684.389269.70457@lemming.engeast.baynetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17419.25684.389269.70457@lemming.engeast.baynetworks.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 05, 2006 at 05:21:08PM -0500, Paul D. Smith wrote:
> %% Sam Ravnborg <sam@ravnborg.org> writes:
> 
>   sr> I foresee a lot of mails to lkml the next year or more with this
>   sr> issue if kept. People do build older kernels and continue to do so
>   sr> the next long time. Especially the embedded market seem keen to
>   sr> stay at 2.4 (wonder why), and as such we will see many systems
>   sr> that keep older kernel src but never make behaviour.
> 
> Well, this behavior doesn't exist in 2.4 kernels, since the kernel build
> in 2.4 was very different.  Nevertheless there are plenty of 2.6 kernels
> out there :-).
OK, I did not actually look at 2.4. But you are right that the build
system has seen a few updates since then.

>   sr> Suggestion:
>   sr> We are now warned about an incompatibility in kbuild and we will
>   sr> fix this asap. But that you postpone this particular behaviour
>   sr> change until next make release. Maybe you add in this change as
>   sr> the first thing after the stable relase so all bleeding edge make
>   sr> users see it and can report issues.
> 
> I am willing to postpone this change.  However, I can't say how much of
> a window this delay will give you: I can say that it's extremely
> unlikely that it will be another 3 years before GNU make 3.82 comes out.

One year would be good. The fixed kernel build will be available in an
official kernel in maybe two or three months form now. With current pace
we will have maybe 3 more kernel relase until this hits us. And only on
bleeding edge machines.

>   sr> It is not acceptable that the kernel links each time we do a make.
>   sr> We keep track of a version number, we do partly jobs as root etc.
>   sr> So any updates on an otherwise build tree is a bug - and will be
>   sr> reported and has to get fixed.
> 
> I've modified the kbuild system to collect .PHONY files into a variable,
> PHONY, and then used that in the if_changed* macros.
> 
> Using this method I've determined that the new version of GNU make works
> exactly like the old version under various tests (build from scratch,
> rebuild without any changes, rebuild with simple changes, etc.)
> 
> I've submitted a patch to linux-kernel implementing this change, with
> an appropriate Signed-off-by line.

GNU make is used and abused in several ways in the kbuild files.
If you found something prticular fishy then please let me know, there
may well be better solutions for part of the build system that I am not
aware of.

	Sam
