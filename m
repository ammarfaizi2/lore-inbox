Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261754AbTKLXdo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 18:33:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261755AbTKLXdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 18:33:44 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:8714 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S261754AbTKLXdn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 18:33:43 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: So, Poll is not scalable... what to do?
Date: 12 Nov 2003 23:23:07 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <boufcr$k8l$1@gatekeeper.tmr.com>
References: <LAW12-F60bw5TYIo9WF0002bec8@hotmail.com>
X-Trace: gatekeeper.tmr.com 1068679387 20757 192.168.12.62 (12 Nov 2003 23:23:07 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <LAW12-F60bw5TYIo9WF0002bec8@hotmail.com>,
kirk bae <justformoonie@hotmail.com> wrote:
| If poll is not scalable, which method should I use when writing 
| multithreaded socket server?
| 
| What is the most efficient model to use?
| 
| Is there a "standard" model to use when writing a scalable multithreaded 
| socket serve such as "io completion ports" on windows?
| 

In many cases people just run a thread per socket and use blocking i/o.
Then the thread either does the work required or make an entry on a
"work to do" queue.

You've had other suggestions, this is just for completeness.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
