Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262071AbUIDNjP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262071AbUIDNjP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 09:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262406AbUIDNjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 09:39:15 -0400
Received: from colin2.muc.de ([193.149.48.15]:26899 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S262071AbUIDNiY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 09:38:24 -0400
Date: 4 Sep 2004 15:38:22 +0200
Date: Sat, 4 Sep 2004 15:38:22 +0200
From: Andi Kleen <ak@muc.de>
To: Roland McGrath <roland@redhat.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org
Subject: Re: [PATCH] cleanup ptrace stops and remove notify_parent
Message-ID: <20040904133822.GF33964@muc.de>
References: <200409010027.i810RsWT001980@magilla.sf.frob.com> <200409010156.i811uLdd014564@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409010156.i811uLdd014564@magilla.sf.frob.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2004 at 06:56:21PM -0700, Roland McGrath wrote:
> I don't have a program like yours to test that it was broken with my patch
> (now in 2.6.9-rc1-mm2).  But the following additional patch relative to
> 2.6.9-rc1-mm2 should do it.  I've tested that it doesn't create any new
> problems.  I don't have something right handy that tests the case in
> question, but you've said that you do.

I am travelling and can't reach the code right now, but I will
test later.

> 
> This makes any ptrace operation that finds the target in TASK_STOPPED state
> morph it into TASK_TRACED state before doing anything.  This necessitates
> reverting the last_siginfo accesses to check instead of assume last_siginfo
> is set, since it's no longer impossible to be in TASK_TRACED without being
> stopped in ptrace_stop (though there are no associated races to worry
> about).

Looks good, thanks.

-Andi
