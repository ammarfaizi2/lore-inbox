Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263734AbTJCNin (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 09:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263741AbTJCNin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 09:38:43 -0400
Received: from janus.zeusinc.com ([205.242.242.161]:13080 "EHLO
	zso-proxy.zeusinc.com") by vger.kernel.org with ESMTP
	id S263734AbTJCNim (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 09:38:42 -0400
Subject: Problems caused by scheduler tweaks in 2.6.0-test6?
From: Tom Sightler <ttsig@tuxyturvy.com>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1065188297.2660.17.camel@iso-8590-lx.zeusinc.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-2) 
Date: Fri, 03 Oct 2003 09:38:17 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Over the last few months I have tested many different scheduler tweaks
mostly by testing the -mm kernels and also by applying Nick's patches
against vanilla kernels.  Up until recently I have been very happy with
2.6.0-test5 with Nick's scheduler patches.

Then I decided to try 2.6.0-test6 which seems to include a lot of Con's
work and, while overall this seems nice, I'm having two relatively
serious side effects that seem to be related to this inclusion.

1.  VMware performance varies wildly.  I can't put my finger on this
exact issue, but I have found as way to repeatably trigger bad
performance.  When running VMware in fullscreen mode, enable window
animation and repeatedly minimize/maximize a window.  Under 2.4.x and
2.6.0-test5 w/Nick's patches this process runs reasonably smooth,
although noticably slower than native speed.  With stock 2.6.0-test6
after only a few seconds the minimize/maximize animiation slows to a
complete crawl, take 20+ seconds to complete the minimize opertaion. 
I've tried tuning VMware with priorities but no luck.

2.  I also use Wine to run various Windows programs on occasion,
particularly Outlook 2000 (mainly when attempting to help other running
this application on Windows).  The program runs fine, but always hangs
on exit.  I didn't originally think this was related to the scheduler,
but interestingly, after applying Nick's patches to 2.6.0-test6, which
back out Con's changes, this problem goes away.

Is there any help out there for these type of issues?  I know that many
people seem to think these changes make life better, and I'll admidt
that playing MP3's and DVD's is better with these changes, but I'd
rather have my system preform well at other tasks.  I would think having
a way to turn off all the fancy interactivity detection would be ideal
but there always seems to be opposition to adding tuning knobs.

Later,
Tom


