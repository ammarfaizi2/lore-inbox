Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263301AbTJUUti (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 16:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263308AbTJUUti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 16:49:38 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:19716 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263301AbTJUUtN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 16:49:13 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: Blockbusting news, this is important (Re: Why are bad disk sectors numbered strangely, and what happens to them?)
Date: 21 Oct 2003 20:39:11 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bn45hf$ir2$1@gatekeeper.tmr.com>
References: <32a101c3916c$e282e330$5cee4ca5@DIAMONDLX60> <200310171935.h9HJZaLm002335@81-2-122-30.bradfords.org.uk> <m37k33igui.fsf@defiant. <m3u166vjn0.fsf@defiant.pm.waw.pl>
X-Trace: gatekeeper.tmr.com 1066768751 19298 192.168.12.62 (21 Oct 2003 20:39:11 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <m3u166vjn0.fsf@defiant.pm.waw.pl>,
Krzysztof Halasa  <khc@pm.waw.pl> wrote:
| John Bradford <john@grabjohn.com> writes:
|
| > My most important point is that writes should never fail on a good
| > drive.
| 
| That's certainly what the drives do. Unless they are out of spare
| sectors, of course.
| 
| Doing cat /dev/zero > /dev/hd* fixes all bad sectors on modern drive.

Flash from the past, back in the days of MFM drives, and "new" RLL
controllers, we wrote software which regularly read all the data off a
track with appropriate retries, reformatted the track, wrote the data,
and read it back to verify. This was because of 'sector walk" which made
the sectors move relative to the IRG. And we wrote our own device
drivers to use large sectors to get more capacity, those were the days.

However, that's the kind of thing I would hope S.M.A.R.T. could do, with
relocation of course.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
