Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262033AbTL3Alv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 19:41:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262092AbTL3Alv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 19:41:51 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:46855 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S262033AbTL3Alt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 19:41:49 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: [PATCH] 2.6.0 batch scheduling, HT aware
Date: 30 Dec 2003 00:29:58 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bsqgu6$fk1$1@gatekeeper.tmr.com>
References: <200312231138.21734.kernel@kolivas.org> <200312271042.55989.kernel@kolivas.org> <20031227110903.GA1413@elf.ucw.cz> <200312272215.01563.kernel@kolivas.org>
X-Trace: gatekeeper.tmr.com 1072744198 16001 192.168.12.62 (30 Dec 2003 00:29:58 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200312272215.01563.kernel@kolivas.org>,
Con Kolivas  <kernel@kolivas.org> wrote:
| On Sat, 27 Dec 2003 22:09, Pavel Machek wrote:
| > So... even on normal SMP,
| > "task-on-other-cpu-slows-down-task-on-this-cpu" effect exists. Okay,
| > it is not as visible as on HT machine (50% slowdown), but its
| > definitely there.
| 
| Sure but I think we're getting pedantic here. The problem is really simple - a 
| uniprocessor HT desktop booted in SMP mode feels half the speed while running 
| setiathome (or video encoding or whatever cpu bound task) compared to booting 
| it in UP mode. So, ironically, enabling the HT makes the machine feel slower 
| when running multiple tasks. And there will be a heck of a lot of these in 
| the future.

Let me put forth a thought, without a solution. In the case you
describe, what is needed, and not provided in hardware, is a way to do
priority within the CPU, so in the case of a contested resource there is
a way to ensure the process we wish wins.

Since that seems unavailable in Intel, do other CPUs do better (or
different)?
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
