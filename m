Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751024AbWELJVH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751024AbWELJVH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 05:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbWELJVH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 05:21:07 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:49039 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751024AbWELJVG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 05:21:06 -0400
Date: Fri, 12 May 2006 05:20:35 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Mark Hounschell <dmarkh@cfl.rr.com>
cc: Mark Hounschell <markh@compro.net>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: rt20 patch question
In-Reply-To: <4464509B.4080206@cfl.rr.com>
Message-ID: <Pine.LNX.4.58.0605120515050.29684@gandalf.stny.rr.com>
References: <446089CF.3050809@compro.net> <1147185483.21536.13.camel@c-67-180-134-207.hsd1.ca.comcast.net>
 <4460ADF8.4040301@compro.net> <Pine.LNX.4.58.0605100827500.3282@gandalf.stny.rr.com>
 <4461E53B.7050905@compro.net> <Pine.LNX.4.58.0605100938100.4503@gandalf.stny.rr.com>
 <446207D6.2030602@compro.net> <Pine.LNX.4.58.0605101215220.19935@gandalf.stny.rr.com>
 <44623157.9090105@compro.net> <Pine.LNX.4.58.0605101446090.22959@gandalf.stny.rr.com>
 <44623ED4.1030103@compro.net> <44631F1B.8000100@compro.net>
 <Pine.LNX.4.58.0605110739520.5610@gandalf.stny.rr.com>
 <Pine.LNX.4.58.0605110805470.5610@gandalf.stny.rr.com> <446335EA.3000506@compro.net>
 <Pine.LNX.4.58.0605110913220.6863@gandalf.stny.rr.com> <44633B78.8080907@compro.net>
 <Pine.LNX.4.58.0605110940001.7359@gandalf.stny.rr.com> <446350CF.3010204@compro.net>
 <Pine.LNX.4.58.0605120221410.26721@gandalf.stny.rr.com> <4464509B.4080206@cfl.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 12 May 2006, Mark Hounschell wrote:

> Steven Rostedt wrote:
>
> Done. Keep in mind it was taken only after one of those BUGs that seemed
> to cause a network connection loss into the emulation. It was not taken
> after one of those "stops" in 'complete preempt' mode. Did the logdev
> output show anything of interest concerning the "stops"?

Damn, your logdev email got lost in the noise.  I'm glad you mentioned it
otherwise I would have never known you sent it.  I'll look at it now.

>
> So do you think this BUG reported in 'preempt kernel' mode is related to
> the "stops" I am having in 'complete preempt mode?
>

Yes.  That BUG thread that I included you on affects you if hardirqs are
threaded in any preempt mode.  So yes it is a bug in 'complete preempt
mode' too.  So that driver really does need to be fixed for you.
Unfortunately, I don't have the time now to fix that.

Perhaps someone else can?

-- Steve

