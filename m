Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262223AbTIWS0i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 14:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262745AbTIWS0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 14:26:37 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:45573 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S262223AbTIWS0e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 14:26:34 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: Can we kill f inb_p, outb_p and other random I/O on port 0x80, in 2.6?
Date: 23 Sep 2003 18:17:16 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bkq2nc$erb$1@gatekeeper.tmr.com>
References: <m1isnlk6pq.fsf@ebiederm.dsl.xmission.com> <1064248391.8895.6.camel@dhcp23.swansea.linux.org.uk> <1064250691.6235.2.camel@laptop.fenrus.com> <20030922182808.GA28372@mail.jlokier.co.uk>
X-Trace: gatekeeper.tmr.com 1064341036 15211 192.168.12.62 (23 Sep 2003 18:17:16 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030922182808.GA28372@mail.jlokier.co.uk>,
Jamie Lokier  <jamie@shareable.org> wrote:
| Arjan van de Ven wrote:
| > The first person to complain about the extra branch miss in udelay for
| > this will get laughed at by me ;)
| 
| udelay(1) is too slow on a 386 even without the branch miss.
| 
| If you think I/O operations are infinitely slower than other
| instructions, please explain why there is asm-optimised I/O code in
| asm-i386/floppy.h.
| 
| :)

The choices are:
1 - there really were some old crappy chips which were both slow and
    timing sensitive
2 - someone thought that would optimize access
3 - gcc of the time generated bad code if you didn't

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
