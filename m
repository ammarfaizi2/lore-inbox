Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268767AbUJEERS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268767AbUJEERS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 00:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268769AbUJEERS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 00:17:18 -0400
Received: from vs-kg004.ocn.ad.jp ([210.232.239.83]:51934 "EHLO
	vs-kg004.ocn.ad.jp") by vger.kernel.org with ESMTP id S268767AbUJEERQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 00:17:16 -0400
From: Jason Stubbs <jstubbs@work-at.co.jp>
Organization: Work@ Inc
To: Andrew Morton <akpm@osdl.org>
Subject: Re: PROBLEM: Consistent lock up on >=2.6.8
Date: Tue, 5 Oct 2004 13:17:48 +0900
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
References: <200410041611.17000.jstubbs@work-at.co.jp> <200410051053.09587.jstubbs@work-at.co.jp> <20041004185845.471bcc55.akpm@osdl.org>
In-Reply-To: <20041004185845.471bcc55.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410051317.48071.jstubbs@work-at.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 05 October 2004 10:58, Andrew Morton wrote:
> Jason Stubbs <jstubbs@work-at.co.jp> wrote:
> >  On Tuesday 05 October 2004 04:05, Andrew Morton wrote:
> >  > update_defense_level() is calling si_meminfo() from timer context. 
> >  > But si_meminfo takes non-irq-safe locks.
> >  >
> >  > Move it all to keventd context.
> >
> >  That appears to have fixed it. I'm running my regular test and, while
> >  interactivity is non-existent, it hasn't locked. I'll leave it going for
> >  another few hours and report back to confirm.

Going on 3 hours and no problems.

> >  Much gratitude. I should go out and buy a kernel book so that I may some
> > day be able to repay the favour. :)
>
> You reported the bug, then you applied and ran the debug patch and then you
> sent back the info which was necessary to arrive at a fix and then you
> tested the fix.
>
> How could you possibly have anything further to "repay"?

Nevertheless... :)

Regards,
Jason Stubbs
