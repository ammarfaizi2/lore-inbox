Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267699AbTAHEKn>; Tue, 7 Jan 2003 23:10:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267700AbTAHEKn>; Tue, 7 Jan 2003 23:10:43 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:56121 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S267699AbTAHEKm>; Tue, 7 Jan 2003 23:10:42 -0500
Date: Tue, 7 Jan 2003 23:19:22 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200301080419.h084JMT10615@devserv.devel.redhat.com>
To: Larry McVoy <lm@bitmover.com>
cc: linux-kernel@vger.kernel.org
Subject: User mode drivers (Honest does not pay here ...)
In-Reply-To: <mailman.1041987068.25081.linux-kernel2news@redhat.com>
References: <20030107232820.GB24664@merlin.emma.line.org> <Pine.LNX.4.43.0301080059460.24706-100000@cibs9.sns.it> <mailman.1041987068.25081.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I may be showing my ignorance here (won't be the first time) but this makes
> me wonder if Linux could provide a way to do "user level drivers".

It is a question often asked in comp.os.linux.development.system.
If performance penalties and security problems are no obstacle,
a lot of hardware can be serviced with a user mode driver, except
one that requires interrupts to operate. There is no way to deliver
an interrupt safely to the user mode, because a device specific
deactivation or ack-ing must be performed before interrupts are
enabled (on i386 at least). Other problems can be worked around
with ioperm and friends.

-- Pete
