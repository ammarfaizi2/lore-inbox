Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261733AbTKLXhY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 18:37:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbTKLXhY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 18:37:24 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:10250 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S261733AbTKLXhW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 18:37:22 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: So, Poll is not scalable... what to do?
Date: 12 Nov 2003 23:26:46 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <boufjm$k9v$1@gatekeeper.tmr.com>
References: <LAW12-F60bw5TYIo9WF0002bec8@hotmail.com> <20031112053207.GA9634@alpha.home.local>
X-Trace: gatekeeper.tmr.com 1068679606 20799 192.168.12.62 (12 Nov 2003 23:26:46 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20031112053207.GA9634@alpha.home.local>,
Willy Tarreau  <willy@w.ods.org> wrote:
| On Tue, Nov 11, 2003 at 05:52:42PM -0600, kirk bae wrote:
| > If poll is not scalable, which method should I use when writing 
| > multithreaded socket server?
| 
| Honnestly, if you're using threads (I mean lots of threads, such as one
| per connection), I don't think that poll performance will be your worst
| ennemy. The first thing to do is to handle the task switching yourself
| either with a publicly available coroutine library or with one of your own.

It's not clear that with 2.6 this is necessary or desirable. I'll let
someone who worked on the new thread and/or futex development say more
if they will, but I'm reasonable convinced that in most cases the kernel
will do it better.
| 
| Take a look here for more a comparison of several available methods :
| 
|     http://www.kegel.com/c10k.html
| 
| epoll is compared to other methods with numbers here :
| 
|     http://www.xmailserver.org/linux-patches/nio-improve.html
| 
| Cheers,
| Willy
| 
| -
| To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
| the body of a message to majordomo@vger.kernel.org
| More majordomo info at  http://vger.kernel.org/majordomo-info.html
| Please read the FAQ at  http://www.tux.org/lkml/
| 


-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
