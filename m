Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751371AbWCaOoT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371AbWCaOoT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 09:44:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751064AbWCaOoT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 09:44:19 -0500
Received: from mail15.syd.optusnet.com.au ([211.29.132.196]:53439 "EHLO
	mail15.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750754AbWCaOoS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 09:44:18 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Al Boldi <a1426z@gawab.com>
Subject: Re: [RFC] sched.c : procfs tunables
Date: Sat, 1 Apr 2006 00:44:08 +1000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, linux-smp@vger.kernel.org
References: <200603311723.49049.a1426z@gawab.com>
In-Reply-To: <200603311723.49049.a1426z@gawab.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604010044.09185.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 01 April 2006 00:23, Al Boldi wrote:
> Proper scheduling in a multi-tasking environment is critical to the success
> of a desktop OS.  Linux, being mainly a server OS, is currently tuned to
> scheduling defaults that may be appropriate only for the server scenario.
>
> To enable Linux to play an effective role on the desktop, a more flexible
> approach is necessary.  An approach that would allow the end-User the
> freedom to adjust the OS to the specific environment at hand.
>
> So instead of forcing a one-size fits all approach on the end-User, would
> not exporting sched.c tunables to the procfs present a flexible approach to
> the scheduling dilemma?
>
> All comments that have a vested interest in enabling Linux on the desktop
> are most welcome, even if they describe other/better/smarter approaches.

None of the current "tunables" have easily understandable heuristics. Even 
those that appear to be obvious, like timselice, are not. While exporting 
tunables is not a bad idea, exporting tunables that noone understands is not 
really helpful. Even with heavy documentation, changes are not immediately 
predictable, and parts of the scheduler "know" about the default tuning 
values and they'd be broken by modifying them. Other scheduler designs, or 
more infrastructure on the current one (like what Mike's working on) might 
make some more obvious tunables. I've already discussed what I think in that 
regard too on a similar email thread. Exporting them also incurs a not 
insignificant cost.

Cheers,
Con
