Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264076AbTJ1SSJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 13:18:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264073AbTJ1SSJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 13:18:09 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:60677 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S264076AbTJ1SSF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 13:18:05 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: how do file-mapped (mmapped) pages become dirty?
Date: 28 Oct 2003 18:07:52 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bnmb9o$r2q$1@gatekeeper.tmr.com>
References: <006901c39d50$0b1313d0$2501a8c0@CARTMAN>
X-Trace: gatekeeper.tmr.com 1067364472 27738 192.168.12.62 (28 Oct 2003 18:07:52 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <006901c39d50$0b1313d0$2501a8c0@CARTMAN>,
Amir Hermelin <amir@montilio.com> wrote:

| When a process mmaps a file, how does the kernel know the memory has been
| written to (and hence the page is dirty)? Is this done by setting the
| protected flag, and when the memory is first written to it's set to dirty?
| What function is responsible for this setting? And when will the page be
| written back to disk (i.e. where's the flusher located)?

At least on x86, the CPU sets the dirty bit on write, although once
upon a time less capable CPUs did it the way you suggest. That said, I
think copy on write is still done the way you suggest, but look at the
code if you really care. Or wait for someone to tell me I'm wrong ;-)

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
