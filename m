Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267243AbSLEOSp>; Thu, 5 Dec 2002 09:18:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267326AbSLEOSp>; Thu, 5 Dec 2002 09:18:45 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:45576 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S267243AbSLEOSo>; Thu, 5 Dec 2002 09:18:44 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: lkml, bugme.osdl.org?
Date: 5 Dec 2002 14:24:56 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <asnnjn$h1o$1@gatekeeper.tmr.com>
References: <200212030724.gB37O4DL001318@turing-police.cc.vt.edu> <20021203121521.GB30431@suse.de> <20021204115819.GB1137@gallifrey> <20021204124227.GB647@suse.de>
X-Trace: gatekeeper.tmr.com 1039098296 17464 192.168.12.62 (5 Dec 2002 14:24:56 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20021204124227.GB647@suse.de>,
Dave Jones  <davej@codemonkey.org.uk> wrote:

| indeed. this should be addressed by the time we get to stable releases.
| One possibility someone came up with at the summit was just a slightly
| different take on the existing pre/rc release model.
| The initial pre's remain as they are now, later pres are for strict
| bug-fixes and arch resyncs, then the release candidates roll out.
| It doesn't sound that impossible a plan, as long as whoever ends up
| doing it is strict enough not to include 'just one more feature'
| during the arch-merge pre's.

  This should fall out in the early rc versions I would think. Once new
features are stopped and only bugfixes are allowed, I'm not sure that
fixes to make an arch work are different from any other bugfix.
Otherwise you can get a "fix-lock" where a kernel get ported to most
archs, then a real bug is found and fixed which breaks some arch, then
we go round again.

  In practice, if new features are strictly kept out, the rc releases
should asymptotically approach stable.

  I'm not against having a "port-stable" stage, I just think it isn't
going to speed development. The maintainer would have to decide if a bug
fix could wait if it broke a port, but they do a lot of "is it a fix or
a feature" now, if you call a patch "fix missed detection of foo123
chip" it's a fix, and if you say "add detection of foo123" it becomes an
enhancement.

  Release maintainers have a really hard job, that's why we pay them the
big bucks;-)
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
