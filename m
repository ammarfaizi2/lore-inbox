Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263268AbTJUTBN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 15:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263269AbTJUTBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 15:01:13 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:22291 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263268AbTJUTBL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 15:01:11 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: Circular Convolution scheduler
Date: 21 Oct 2003 18:51:10 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bn3v6u$hv6$1@gatekeeper.tmr.com>
References: <20031019085008.7505.qmail@email.com>
X-Trace: gatekeeper.tmr.com 1066762270 18406 192.168.12.62 (21 Oct 2003 18:51:10 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20031019085008.7505.qmail@email.com>,
Clayton Weaver <cgweav@email.com> wrote:
| (perhaps a bit less vague)
| 
| While the long-term time series analyses
| would doubtless be interesting for enterprise
| networks, I had something more modest in mind.
| 
| Most of the heuristic work so far seems to have
| been directed toward how to identify interactive
| processes as interactive without false positives
| on batch processes, making the code correct (no
| bugs), making it fast, and a little tuning to
| obtain generally ("for most people") usable
| values for how fast to scale up the priority
| on a process that has matched the heuristics,
| yes?
| 
| My question about inserting a convolution
| would be more relevant to what do we do
| with that information ("we believe that
| this process is interactive")once we have it.

I think that's the right point, but the advantage of better analysis may
not be in better finding which process does what, but deciding which
type of process we want to run and for how long. The reports of starving
this and that indicate that giving the "most interactive" process all it
can use may not be the best for the system responsiveness overall.

And the observed results from various fairness and deadline scheduling
seem to bear this out. Instead of using an override "this process has
waited too long" model, a better schudling in normal mode might be
possible.

Just my thought, not "do the same old but better," but "make better
choices for the system overall." That could target throughput or
responsiveness as desired.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
