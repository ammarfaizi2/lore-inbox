Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751342AbWCGRXj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbWCGRXj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 12:23:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbWCGRXi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 12:23:38 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:6289 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751342AbWCGRXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 12:23:38 -0500
Date: Tue, 7 Mar 2006 12:23:23 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Serge Noiraud <serge.noiraud@bull.net>
cc: linux-kernel@vger.kernel.org, ltt-dev@shafik.org,
       Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <compudj@krystal.dyndns.org>
Subject: Re: RT patch and arch/i386/kernel/time.c question
In-Reply-To: <200603071742.42262.Serge.Noiraud@bull.net>
Message-ID: <Pine.LNX.4.58.0603071220100.15305@gandalf.stny.rr.com>
References: <200603071742.42262.Serge.Noiraud@bull.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 7 Mar 2006, Serge Noiraud wrote:

> hi,
>
> 	I'm trying to port the LTTng patch over the rt20 and I got the following problem :
> The LTTng patch try to modify the arch/i386/kernel/time.c file in which the
> timer_interrupt function doesn't exist anymore.
>
> In which file / function could I try to patch the equivalent function ?
>

The -rt patch uses the lastest stuff from Thomas Gleixner, John Stultz and
of course Ingo Molnar.  The functions you are interested in, are in
kernel/time/ directory.  Take a look at clockevents.c and perhaps
handle_tick().  I'm not sure what LTTng is doing there, but this will give
you a direction in which way to look.

-- Steve

