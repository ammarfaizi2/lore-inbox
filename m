Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262225AbTIWSuq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 14:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262745AbTIWSuq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 14:50:46 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:57093 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S262225AbTIWSup
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 14:50:45 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: Can we kill f inb_p, outb_p and other random I/O on port 0x80, in 2.6?
Date: 23 Sep 2003 18:41:28 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bkq44o$f47$1@gatekeeper.tmr.com>
References: <20030922153651.16497.qmail@science.horizon.com> <m1brtck6wq.fsf@ebiederm.dsl.xmission.com> <20030922215432.GE29869@mail.jlokier.co.uk>
X-Trace: gatekeeper.tmr.com 1064342488 15495 192.168.12.62 (23 Sep 2003 18:41:28 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030922215432.GE29869@mail.jlokier.co.uk>,
Jamie Lokier  <jamie@shareable.org> wrote:
| linux@horizon.com writes:
| > > So can we gradually kill inb_p, outb_p in 2.6?  An the other
| > > miscellaneous users of I/O port 0x80 for I/O delays?
| > 
| > Actually, It's not easy.  The issue got debated a lot a few years ago.
| > A read is also acceptable, and allows a few more ports to be
| > potentially used, but that corrupts %al and thus bloats the code.
| 
| It bloats the code a lot less than udelay() calls or any other
| solution which keeps the delay!
| 
| In the worst case, the bloat from a read _should_ be two bytes: "push
| %eax; inb $80,%al; pop %eax".  Whereas a call to udelay is 5 bytes,
| for a call instruction.

Isn't one of the benefits of a rethink not to use any i/o bus cycles?

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
