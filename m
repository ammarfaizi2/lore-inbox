Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263378AbTJUVy2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 17:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263382AbTJUVy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 17:54:28 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:36868 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263378AbTJUVy0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 17:54:26 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: Software RAID5 with 2.6.0-test
Date: 21 Oct 2003 21:44:21 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bn49bl$jai$1@gatekeeper.tmr.com>
References: <1065690658.10389.19.camel@slurv> <Pine.LNX.3.96.1031017125544.24004C-100000@gatekeeper.tmr.com> <yw1xu167kbcw.fsf@users.sourceforge.net> <20031017192419.GG8711@unthought.net>
X-Trace: gatekeeper.tmr.com 1066772661 19794 192.168.12.62 (21 Oct 2003 21:44:21 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20031017192419.GG8711@unthought.net>,
Jakob Oestergaard  <jakob@unthought.net> wrote:

| Now that I'm posting anyway - I thought of a plus for the HW RAID
| controllers (hey, they're way behind on the scoreboard so far, so I
| might as well be a gentleman and give them a point or two):
| *) Battery backed write cache
| 
| This will allow the controller to say 'ok I'm done with your sync()',
| way before the data actually reaches the disk platters.  For some
| workloads this can be a big win.

Unless the drives are battery backed up as well, I'm not sure that this
is a good thing, or at least a safe thing. And if a write error happens
after the controller tells you the sync() is done? That's a question,
not a comment, I'm not sure Linux software RAID would relocate if the
drive was out of spare sectors, either, but it at least could.

I don't question your statement that caching helps performance, but I
think there is some loss of reliability. I have no numbers to estimate
the effect, so take it as a comment only.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
