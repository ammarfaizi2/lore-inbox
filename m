Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263453AbTJUWSi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 18:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263457AbTJUWSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 18:18:38 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:41988 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263453AbTJUWSg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 18:18:36 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: [RFC] frandom - fast random generator module
Date: 21 Oct 2003 22:08:31 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bn4aov$jf7$1@gatekeeper.tmr.com>
References: <3F8E552B.3010507@users.sf.net> <3F8E58A9.20005@cyberone.com.au> <bn40oa$i4q$1@gatekeeper.tmr.com> <bn46q9$1rv$1@cesium.transmeta.com>
X-Trace: gatekeeper.tmr.com 1066774111 19943 192.168.12.62 (21 Oct 2003 22:08:31 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <bn46q9$1rv$1@cesium.transmeta.com>,
H. Peter Anvin <hpa@zytor.com> wrote:
| Followup to:  <bn40oa$i4q$1@gatekeeper.tmr.com>
| By author:    davidsen@tmr.com (bill davidsen)
| In newsgroup: linux.dev.kernel
| >
| > In article <3F8E58A9.20005@cyberone.com.au>,
| > Nick Piggin  <piggin@cyberone.com.au> wrote:
| > 
| > | Without looking at the code, why should this be done in the kernel?
| > 
| > Because it's a generally useful function, /dev/random and /dev/urandom
| > are in the kernel, /dev/urandom is SLOW. And doing a userspace solution
| > is a bitch in shell scripts ;-)
| > 
| 
| Bullshit.  "myrng 36 | foo" works just fine.

myrng?? That doesn't seem to be part of the bash I have, or any
distribution I could check, and google shows a bunch of visual basic
results rather than anything useful.

If you're suggesting that every user write their own program to
generate random numbers, then write a script to call it, that kind of
defeats the purpose of doing shell instead of writing a program, doesn't
it? Not to mention that to get entropy the user program will have to
call the devices anyway.

I think this could also fail the objective of returning unique results
in an SMP system, but that's clearly imprementation dependent.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
