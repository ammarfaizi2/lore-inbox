Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261587AbTIKWXo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 18:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261590AbTIKWXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 18:23:43 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:17927 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S261587AbTIKWXm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 18:23:42 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: [PATCH] AES i586-asm optimized
Date: 11 Sep 2003 22:14:47 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bjqs4n$u7c$1@gatekeeper.tmr.com>
References: <20030910153859.GA17919@leto2.endorphin.org> <20030910161738.GA29990@gtf.org> <3F5F5A22.956A72A6@pp.inet.fi> <3F6095B5.9010100@pobox.com>
X-Trace: gatekeeper.tmr.com 1063318487 30956 192.168.12.62 (11 Sep 2003 22:14:47 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3F6095B5.9010100@pobox.com>,
Jeff Garzik  <jgarzik@pobox.com> wrote:
| Jari Ruusu wrote:

| > It uses classic Pentium instruction set. Speed optimized for my 300 MHz
| > Pentium-2 test box. Original Gladman version that I started with was pretty
| > fast but I was able to improve performance about 7% over original version.
| > 
| > On my same 300 MHz P2 test box, assembler implementation is about twice as
| > fast as the mainline kernel C implementation.
| 
| 
| Neat.  Consider me surprised, then  ;-)
| 
| Don't take my message as objection to the merge.  I dunno what DaveM or 
| JamesM thinks, but I definitely support merging patches like this.  It 
| provides a great example, if nothing else.
| 
| Eventually I bet there will be issues about automatic algorithm 
| selection:  like the RAID5 code, which benchmarks all available 
| algorithms, and selects the fastest one.

Didn't we just have this discussion? ;-) RAID5 benchmarks all available
code and then uses SSE2 or whatever because it doesn't plunk the
registers or cache or something... sorry, the details escape me, or the
sorry details escape me, or whatever.

BTW: I do agree with your point here, I'm using cryptoloop for some
stuff I'm doing, and while I never do enough disk i/o to care, this is a
good thing for the future. I'm using a PII-350, but next month I have to
add a P55C SMP machine, and will be doing much more crypto.

Thanks for asking for clarification, the patch looks better for it.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
