Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264300AbTL3ArT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 19:47:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264301AbTL3ArT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 19:47:19 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:48903 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S264300AbTL3ArQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 19:47:16 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: [PATCH] 2.6.0 batch scheduling, HT aware
Date: 30 Dec 2003 00:35:26 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bsqh8e$fm1$1@gatekeeper.tmr.com>
References: <200312231138.21734.kernel@kolivas.org> <3FE7AF24.40600@cyberone.com.au> <bs9o97$dc3$1@gatekeeper.tmr.com> <200312240909.19006.kernel@kolivas.org>
X-Trace: gatekeeper.tmr.com 1072744526 16065 192.168.12.62 (30 Dec 2003 00:35:26 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200312240909.19006.kernel@kolivas.org>,
Con Kolivas  <kernel@kolivas.org> wrote:
| On Wed, 24 Dec 2003 02:51, bill davidsen wrote:
| > There are two goals here. Not having a batch process on one siling makes
| > sense, and I'm going to try Con's patch after I try Nick's latest.
| > Actually, if they play nicely I would use both, batch would be very
| > useful for nightly report generation on servers.
| 
| No hope of them playing nicely, but at some later stage I might resync on top 
| of Nick's work if I like the direction it takes (which looks likely!)
| 
| > But WRT the whole HT scheduling, it would seem that ideally you want to
| > schedule the two (or N) processes which have the lowest aggregate cache
| > thrash, if you had a way to determine that. I suspect that a process
| > which had a small itterative inner loop with a code+data footprint of
| > 2-3k would coexist well with almost anything else. Minimizing the FPU
| > contention also would improve performance, no doubt. I don't know that
| > there are the tools at the moment to get this information, but it seems
| > as though until it's available any scheduling will be working in the
| > dark to some extent.
| 
| Impossible with current tools. Only userspace would have a chance of 
| predicting this and the simple rule we work off is that userspace can't be 
| trusted so this does not appear doable in the foreseeable future.

Glad you agree, but this makes improvement dificult.


-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
