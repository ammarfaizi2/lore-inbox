Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268700AbUJECBJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268700AbUJECBJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 22:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268730AbUJECBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 22:01:09 -0400
Received: from fw.osdl.org ([65.172.181.6]:14264 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268700AbUJECBG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 22:01:06 -0400
Date: Mon, 4 Oct 2004 18:58:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jason Stubbs <jstubbs@work-at.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Consistent lock up on >=2.6.8
Message-Id: <20041004185845.471bcc55.akpm@osdl.org>
In-Reply-To: <200410051053.09587.jstubbs@work-at.co.jp>
References: <200410041611.17000.jstubbs@work-at.co.jp>
	<200410041931.00159.jstubbs@work-at.co.jp>
	<20041004120535.3c68115a.akpm@osdl.org>
	<200410051053.09587.jstubbs@work-at.co.jp>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jason Stubbs <jstubbs@work-at.co.jp> wrote:
>
>  On Tuesday 05 October 2004 04:05, Andrew Morton wrote:
>  > update_defense_level() is calling si_meminfo() from timer context.  But
>  > si_meminfo takes non-irq-safe locks.
>  >
>  > Move it all to keventd context.
> 
>  That appears to have fixed it. I'm running my regular test and, while 
>  interactivity is non-existent, it hasn't locked. I'll leave it going for 
>  another few hours and report back to confirm.
> 
>  Much gratitude. I should go out and buy a kernel book so that I may some day 
>  be able to repay the favour. :)

You reported the bug, then you applied and ran the debug patch and then you
sent back the info which was necessary to arrive at a fix and then you
tested the fix.

How could you possibly have anything further to "repay"?
