Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261486AbTIKUFh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 16:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261490AbTIKUFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 16:05:37 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:51718 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S261486AbTIKUFg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 16:05:36 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
Date: 11 Sep 2003 19:56:41 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bjqk1p$t9r$1@gatekeeper.tmr.com>
References: <99F2150714F93F448942F9A9F112634C0638B196@txexmtae.amd.com> <3F60837D.7000209@pobox.com> <20030911162634.64438c7d.ak@suse.de> <3F6087FC.7090508@pobox.com>
X-Trace: gatekeeper.tmr.com 1063310201 30011 192.168.12.62 (11 Sep 2003 19:56:41 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3F6087FC.7090508@pobox.com>,
Jeff Garzik  <jgarzik@pobox.com> wrote:
| Andi Kleen wrote:
| > It was not created for that (I know that because I created it ;-)
| 
| hehe
| 
| 
| > X86_GENERIC is merely an optimization hint (currently it only changes the cache
| > line size hint) It does not change anything related to correctness. Everything
| > that handles correctness is checked unconditionally.
| 
| When, building non-Pentium4-related code when CONFIG_MPENTIUM4 && 
| !CONFIG_X86_GENERIC, it's OK that the code is incorrect for (picking 
| example) AMD processors.
| 
| It would be a user bug to boot that on an AMD box, just like it would be 
| user bug to boot a CONFIG_M586 kernel on an ancient 386.
| 
| 
| > is_prefetch is a correctness thing.
| 
| When we know at compile time it's not needed, it should not be enabled.

Clearly that's right. This buys nothing on CPUs which don't have the
problem, why have *any* overhead in size and speed? It's too bad that
people have to read around all that code, they don't need to give it a
home in their RAM and execute it as well.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
