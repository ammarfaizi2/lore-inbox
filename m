Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271732AbTGRHXy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 03:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271733AbTGRHXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 03:23:54 -0400
Received: from us01smtp2.synopsys.com ([198.182.44.80]:59636 "EHLO
	kiruna.synopsys.com") by vger.kernel.org with ESMTP id S271732AbTGRHXx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 03:23:53 -0400
Date: Fri, 18 Jul 2003 09:38:42 +0200
From: Alex Riesen <alexander.riesen@synopsys.COM>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] O6int for interactivity
Message-ID: <20030718073842.GA5598@Synopsys.COM>
Reply-To: alexander.riesen@synopsys.COM
Mail-Followup-To: Con Kolivas <kernel@kolivas.org>,
	linux-kernel@vger.kernel.org
References: <200307170030.25934.kernel@kolivas.org> <20030717090508.GE13611@Synopsys.COM> <1058433295.3f16690fa2f2e@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1058433295.3f16690fa2f2e@kolivas.org>
Organization: Synopsys, Inc.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas, Thu, Jul 17, 2003 11:14:55 +0200:
> > > O*int patches trying to improve the interactivity of the 2.5/6
> > > scheduler for desktops. It appears possible to do this without
> > > moving to nanosecond resolution.
> > 
> > tar ztf file.tar.gz and make something somehow do not like each other.
> > Usually it is tar, which became very slow. And listings of directories
> > are slow if system is under load (about 3), too (most annoying).
> > 
> > UP P3-700, preempt. 2.6.0-test1-mm1 + O6-int.
> 
> Thanks for testing. It is distinctly possible that O6.1 addresses this
> problem.  Can you please test that? It applies on top of O6 and only
> requires a recompile of sched.o.

Still no good. xine drops frames by kernel's make -j2, xmms skips while
bk pull (locally). Updates (after switching desktops in metacity) get
delayed for seconds (mozilla window redraws with www.kernel.org on it,
for example).

Priorities of xine threads were around 15-16, with one of them
constantly at 16 (the one with most cpu). gcc/as processes were 20-21.

That said, it feels better than before, though. And the last changes in
the scheduler seem to reveal more races in applications (a found rxvt
not checking for errors reading from pty).

-alex
