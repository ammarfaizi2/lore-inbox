Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263423AbTIWSlC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 14:41:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263424AbTIWSlB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 14:41:01 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:52997 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263423AbTIWSk7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 14:40:59 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: Can we kill f inb_p, outb_p and other random I/O on port 0x80, in 2.6?
Date: 23 Sep 2003 18:31:41 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bkq3id$f0u$1@gatekeeper.tmr.com>
References: <m1isnlk6pq.fsf@ebiederm.dsl.xmission.com> <1064248391.8895.6.camel@dhcp23.swansea.linux.org.uk> <20030922190054.GC27209@mail.jlokier.co.uk> <m1wuc0io78.fsf@ebiederm.dsl.xmission.com>
X-Trace: gatekeeper.tmr.com 1064341901 15390 192.168.12.62 (23 Sep 2003 18:31:41 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <m1wuc0io78.fsf@ebiederm.dsl.xmission.com>,
Eric W. Biederman <ebiederm@xmission.com> wrote:
| Jamie Lokier <jamie@shareable.org> writes:

| > Unfortunately, there are a lot of drivers, and a lot of x86
| > arch-specific code, which use the delay operaters.  There's no real
| > way to verify that all the drivers are fine when the delay is reduced
| > or removed.
| 
| We just need something sufficiently good.  If the delay is removed
| on a system that needs it someone will complain.

The only problem with that is that is that (a) a complaint and a dollar
will get you a cheap beer, but this is Linux and no one *needs* to fix
it, therefore not breaking it becomes more important. The top developers
are not running legacy 386's, I bet. And (b) if the problem comes up
months from now, will anyone think to try timing changes for "every once
in a while" problems.

I really like the isa_delay() idea, or similar, which will be in a
single place and probably get enough attention to make it work. It just
sounds like a safer way to go with equal benefits.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
