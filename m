Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262377AbTJISWo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 14:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262378AbTJISWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 14:22:44 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:31504 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S262377AbTJISWl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 14:22:41 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: Who changed /proc/<pid>/ in 2.6.0-test5-bk9?
Date: 9 Oct 2003 18:12:59 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bm48fb$599$1@gatekeeper.tmr.com>
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAwtz+A6aJAkeufXSGK2GIiwEAAAAA@casabyte.com> <Pine.LNX.4.44.0310071743370.32358-100000@home.osdl.org>
X-Trace: gatekeeper.tmr.com 1065723179 5417 192.168.12.62 (9 Oct 2003 18:12:59 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.44.0310071743370.32358-100000@home.osdl.org>,
Linus Torvalds  <torvalds@osdl.org> wrote:

| The reason people use threads is that sharing the VM space has real 
| advantages: it makes context switching much cheaper (fewer hw resources in 
| the form of TLB usages) and it allows for much faster synchronization 
| through a shared address space.
| 
| But the same isn't true of file descriptors or a lot of other software-
| level abstractions. There are no inherent advantages to sharing, and in
| fact sharing just gives more opportunity for race conditions, bad
| interaction etc.

That depends on what you're doing. It can be lower cost to have threads
putting fd's on a chain to be serviced by another thread than to start
another thread to do the service and use IPC to do serialization
between threads. And abstractions like SysV message queues are
inherently shared. Sometimes there are savings to be had by sharing.

Your base point that resources shouldn't be shared needlessly is
correct, or course.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
