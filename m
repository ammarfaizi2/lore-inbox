Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265478AbUAZXJM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 18:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265573AbUAZXJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 18:09:12 -0500
Received: from mail.tmr.com ([216.238.38.203]:23050 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S265478AbUAZXJG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 18:09:06 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: sched-idle and disk-priorities for 2.6.X
Date: 26 Jan 2004 23:08:47 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bv46lv$6pu$1@gatekeeper.tmr.com>
References: <20040123185914.GA870@elf.ucw.cz> <Pine.LNX.4.44.0401231402580.22566-100000@chimarrao.boston.redhat.com> <20040123210449.GA250@elf.ucw.cz>
X-Trace: gatekeeper.tmr.com 1075158527 6974 192.168.12.62 (26 Jan 2004 23:08:47 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20040123210449.GA250@elf.ucw.cz>,
Pavel Machek  <pavel@ucw.cz> wrote:

| > > I'm afraid it needs to be more aggressive.
| > 
| > OK, is the patch below any better ?
| 
| Yes, this one actually works. When I launched two 150MB tasks, one of
| them with ulimit -m 1, the limited task yielded its memory to
| unlimited one. It worked as expected.

I'm not sure what "as expected" means with this small a limit, hopefully
not "pages its butt off." I am printing a hardcopy of the 2nd patch and
a bit of the surrounding code, and also compiling a new kernel with the
patch in place, so I can play a bit in the morning.

I also wonder if a sanity check is desirable on the minimum size. At
some point I would think the system would get a lot of overhead trying
to actually use a single 1k page :-(

Thanks for this prompt implementation, I do have a few applications
which can use it!
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
