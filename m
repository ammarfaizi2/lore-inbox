Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270326AbTHGSP6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 14:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270327AbTHGSP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 14:15:58 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:22021 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S270326AbTHGSP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 14:15:57 -0400
Subject: 2.6: More about interactivity
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1060280139.1406.17.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 07 Aug 2003 20:15:40 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just wanted to throw a few thoughts I have about the current scheduler
and my experiences with it (well, with my specific workloads and
applications on my little 700 Mhz PIII laptop).

I feel that 2.6.0-test2-mm5 is not as smooth as 2.6.0-test2-mm2 (O10int)
was. I am experiencing sound skips, but this time I'm not using XMMS,
but Juk, a KDE player which uses the aRTS sound daemon, which in turn, I
assume it uses the OSS API.

With X reniced at +0, the system feels not as smooth as 2.6.0-test2-mm2,
but at least there are no sound skips. However, to gain on smoothness, I
have chosen to renice X to -20. Renicing X to -20 makes Juk skip like
crazy simply by dragging a window over the screen. Also, with X at -20,
opening a long Bookmarks Konqueror menu also causes sound skips (even
with XMMS). By now, I'm sticking at +0, but I really miss those times
when I was running O10int and the desktop was as smooth as silk.

Now, let's go on talking about plain 2.6.0-test2-bk6. I feel it not as
good as Con's scheduler and, when starting a CPU hoggers, I can feel how
the system lags (starves) considerably for a few seconds. For example,
when launching an absurd while loop (while true; do a=2; done), X stops
responding for nearly 1 second, then becomes responsive but laggy for
another one, and then starts acting normally.

When O10int was released, I knew and felt the scheduler was working
great for me (well, it worked great with my workload and applications),
but now I'm starting to get afraid that, for me, it's getting again up
to a point like in the past when I was forced to continuously tweak
every kernel knob to try to make it smoother and make it fit my
particular needs.

Is there any pending work on the scheduler that I don't know of, or are
we getting past a point-of-no-return, where the scheduler will be left
as it is right now? I'm saying this as it is a long time since I haven't
heard any notice about new developments on the subject from either Con
or Ingo...

Greetings from a worried scheduler tester.

